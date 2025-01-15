import 'dart:io';

import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, Blog>> uploadBlog(Blog blog, File image);
  Future<Either<Failure, List<Blog>>> getAllBlogs({String? topic});
  Future<Either<Failure, User>> getBlogPoster(String userId);
  Future<Either<Failure, List<Blog>>> searchBlogs(String query);
}
