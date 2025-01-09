import 'dart:io';

import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_new_blog_event.dart';
part 'add_new_blog_state.dart';

class AddNewBlogBloc extends Bloc<AddNewBlogEvent, AddNewBlogState> {
  final UploadBlog _uploadBlog;

  AddNewBlogBloc({required UploadBlog uploadBlog})
      : _uploadBlog = uploadBlog,
        super(AddNewBlogInitial()) {
    on<AddNewBlogEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddNewBlogUploaded>(_onBlogUploaded);
  }
  _onBlogUploaded(
      AddNewBlogUploaded event, Emitter<AddNewBlogState> emit) async {
    emit(AddNewBlogLoadInProgress());
    final response = await _uploadBlog(
        UploadBlogParams(blog: event.blog, image: event.image));

    response.fold(
        (failure) => emit(AddNewBlogFailure(errorMessage: failure.message)),
        (blog) => emit(AddNewBlogSuccess()));
  }
}
