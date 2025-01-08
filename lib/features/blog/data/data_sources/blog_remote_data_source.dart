import 'dart:io';

import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:dio/dio.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blog, File file);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Dio dio;

  BlogRemoteDataSourceImpl({required this.dio});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog, File image) async {
    try {
      final fileName = image.path.split('/').last;

      final blogFormData = FormData.fromMap({
        ...blog.toJson(),
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
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final response = await dio.get("/blogs");
      final data = response.data["data"] as List<Map<String, dynamic>>;
      return data.map((e) => BlogModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
