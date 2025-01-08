import 'dart:io';

import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:clean_code_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogUploaded>(_onBlogUploaded);
    on<BlogsGetAll>(_onBlogsFetched);
  }

  _onBlogUploaded(BlogUploaded event, Emitter<BlogState> emit) async {
    emit(BlogUploadLoadInProgress());
    final response = await _uploadBlog(
        UploadBlogParams(blog: event.blog, image: event.image));

    response.fold(
        (failure) => emit(BlogUploadFailure(errorMessage: failure.message)),
        (blog) => emit(BlogUploadSuccess()));
  }

  _onBlogsFetched(BlogsGetAll event, Emitter<BlogState> emit) async {
    emit(BlogsGetAllLoadInProgress());
    final response = await _getAllBlogs(NoParams());
    response.fold(
        (failure) => emit(BlogsGetAllFailure(errorMessage: failure.message)),
        (blogs) => emit(BlogsGetAllSuccess(blogs: blogs)));
  }
}
