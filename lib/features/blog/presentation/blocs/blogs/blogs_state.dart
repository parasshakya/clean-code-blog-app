part of 'blogs_bloc.dart';

@immutable
sealed class BlogsState {}

final class BlogsInitial extends BlogsState {}

final class BlogsSuccess extends BlogsState {
  final List<Blog> blogs;

  BlogsSuccess({required this.blogs});
}

final class BlogsLoadInProgress extends BlogsState {}

final class BlogsFailure extends BlogsState {
  final String errorMessage;

  BlogsFailure({required this.errorMessage});
}
