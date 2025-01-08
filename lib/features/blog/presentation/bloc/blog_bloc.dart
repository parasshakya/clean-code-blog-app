import 'dart:io';

import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc({required UploadBlog uploadBlog})
      : _uploadBlog = uploadBlog,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) {
      emit(BlogLoadInProgress());
    });

    on<BlogUploaded>(_onBlogUploaded);
  }

  _onBlogUploaded(BlogUploaded event, Emitter<BlogState> emit) async {
    final response = await _uploadBlog(
        UploadBlogParams(blog: event.blog, image: event.image));

    response.fold((failure) => emit(BlogFailure(errorMessage: failure.message)),
        (blog) => emit(BlogUploadSuccess()));
  }
}
