import 'package:clean_code_app/core/local_storage/user_local_data_source.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class ApiInterceptor extends Interceptor {
  final Dio dio; // For token refresh requests
  final UserLocalDataSource userLocalDataSource;

  ApiInterceptor({required this.userLocalDataSource, required this.dio});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // Get the token from secure storage
      final token = await userLocalDataSource.getAccessToken();

      // Add the Authorization header if the token exists
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }

      return handler.next(options); // Proceed with the request
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to add authorization header: $e',
        ),
      );
    }
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    // Optionally log responses
    print(
        'Response [${response.statusCode}] => Path: ${response.requestOptions.path}');
    return handler.next(response); // Proceed with the response
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        // Attempt to refresh the token
        final refreshToken = await userLocalDataSource.getRefreshToken();
        if (refreshToken != null) {
          final newToken = await _refreshToken(refreshToken);
          if (newToken != null) {
            // Save the new token
            await userLocalDataSource.saveAccessToken(newToken);

            // Retry the original request with the new token
            final updatedRequest = err.requestOptions;
            updatedRequest.headers['Authorization'] = 'Bearer $newToken';

            final response = await dio.fetch(updatedRequest);
            return handler.resolve(response);
          }
        }
      } catch (e) {
        print('Token refresh failed: $e');
      }
    }

    // Pass the error to the caller if token refresh or retry fails
    return handler.next(err);
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(
        '/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );
      return response.data['accessToken'];
    } catch (e) {
      print('Failed to refresh token: $e');
      return null;
    }
  }
}
