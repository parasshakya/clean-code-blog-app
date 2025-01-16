import 'dart:io';

import 'package:clean_code_app/core/models/user_model.dart';
import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:dio/dio.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog, File file);
  Future<List<BlogModel>> getAllBlogs({String? topic});
  Future<UserModel> getBlogPoster(String userId);
  Future<List<BlogModel>> searchBlogs(String query);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Dio dio;

  BlogRemoteDataSourceImpl({required this.dio});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog, File image) async {
    try {
      final fileName = image.path.split('/').last;

      final blogFormData = FormData.fromMap({
        ...blog.toJsonForCreate(),
        "image": await MultipartFile.fromFile(image.path, filename: fileName)
      });

      final response = await dio.post("/blogs",
          data: blogFormData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data",
          }));
      final data = response.data["data"];
      return BlogModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs({String? topic}) async {
    try {
      final response = await dio.get("/blogs",
          queryParameters: topic != null ? {"topic": topic} : null);
      final data = response.data["data"] as List;
      return data.map((e) => BlogModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> getBlogPoster(String userId) async {
    try {
      final response = await dio.get('/users/$userId');
      final data = response.data["data"];
      return UserModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> searchBlogs(String query) async {
    try {
      final response =
          await dio.get("/blogs/search", queryParameters: {"query": query});
      final data = response.data["data"] as List;
      return data.map((e) => BlogModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
