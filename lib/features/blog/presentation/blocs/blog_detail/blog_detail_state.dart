part of 'blog_detail_bloc.dart';

@immutable
sealed class BlogDetailState {}

final class BlogDetailInitial extends BlogDetailState {}

final class BlogDetailGetPosterSuccess extends BlogDetailState {
  final User poster;

  BlogDetailGetPosterSuccess({required this.poster});
}

final class BlogDetailGetPosterFailure extends BlogDetailState {
  final String errorMessage;

  BlogDetailGetPosterFailure({required this.errorMessage});
}

final class BlogDetailGetPosterLoadInProgress extends BlogDetailState {}
