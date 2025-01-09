import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  final GetAllBlogs _getAllBlogs;

  BlogsBloc({required GetAllBlogs getAllBlogs})
      : _getAllBlogs = getAllBlogs,
        super(BlogsInitial()) {
    on<BlogsEvent>((event, emit) {});
    on<BlogsFetched>(_onBlogsFetched);
  }
  _onBlogsFetched(BlogsFetched event, Emitter<BlogsState> emit) async {
    emit(BlogsLoadInProgress());
    final response = await _getAllBlogs(NoParams());
    response.fold(
        (failure) => emit(BlogsFailure(errorMessage: failure.message)),
        (blogs) => emit(BlogsSuccess(blogs: blogs)));
  }
}
