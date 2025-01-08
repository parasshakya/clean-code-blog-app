part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoadInProgress extends BlogState {}

final class BlogsGetAllLoadInProgress extends BlogState {}

final class BlogsGetAllFailure extends BlogState {
  final String errorMessage;

  BlogsGetAllFailure({required this.errorMessage});
}

final class BlogUploadSuccess extends BlogState {}

final class BlogUploadLoadInProgress extends BlogState {}

final class BlogUploadFailure extends BlogState {
  final String errorMessage;

  BlogUploadFailure({required this.errorMessage});
}

final class BlogsGetAllSuccess extends BlogState {
  final List<Blog> blogs;

  BlogsGetAllSuccess({required this.blogs});
}
