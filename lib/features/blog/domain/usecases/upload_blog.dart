import 'dart:io';

import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(params) async {
    return await blogRepository.uploadBlog(params.blog, params.image);
  }
}

class UploadBlogParams {
  final BlogModel blog;
  final File image;

  UploadBlogParams({required this.blog, required this.image});
}
