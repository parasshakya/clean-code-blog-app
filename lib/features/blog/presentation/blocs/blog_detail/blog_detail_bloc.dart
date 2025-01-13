import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_blog_poster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_detail_event.dart';
part 'blog_detail_state.dart';

class BlogDetailBloc extends Bloc<BlogDetailEvent, BlogDetailState> {
  final GetBlogPoster _getBlogPoster;

  BlogDetailBloc({required GetBlogPoster getBlogPoster})
      : _getBlogPoster = getBlogPoster,
        super(BlogDetailInitial()) {
    on<BlogDetailEvent>((event, emit) {});
    on<BlogDetailPosterFetched>(_onBlogDetailPosterFetched);
  }

  _onBlogDetailPosterFetched(
      BlogDetailPosterFetched event, Emitter<BlogDetailState> emit) async {
    emit(BlogDetailGetPosterLoadInProgress());
    final response =
        await _getBlogPoster(GetBlogPosterParams(userId: event.userId));
    response.fold(
        (failure) =>
            emit(BlogDetailGetPosterFailure(errorMessage: failure.message)),
        (poster) => emit(BlogDetailGetPosterSuccess(poster: poster)));
  }
}
