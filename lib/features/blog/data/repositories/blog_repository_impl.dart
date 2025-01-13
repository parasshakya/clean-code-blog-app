import 'dart:io';

import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/models/user_model.dart';
import 'package:clean_code_app/core/error/exceptions.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class BlogRepositoryImp implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await remoteDataSource.getAllBlogs();
      return right(blogs);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Blog>> uploadBlog(Blog blog, File image) async {
    try {
      final blogModel = BlogModel.fromDomain(blog);
      final res = await remoteDataSource.uploadBlog(blogModel, image);
      return right(res);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getBlogPoster(String userId) async {
    try {
      final res = await remoteDataSource.getBlogPoster(userId);
      return right(res);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
