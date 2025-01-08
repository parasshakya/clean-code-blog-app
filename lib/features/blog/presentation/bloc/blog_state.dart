part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoadInProgress extends BlogState {}

final class BlogFailure extends BlogState {
  final String errorMessage;

  BlogFailure({required this.errorMessage});
}

final class BlogUploadSuccess extends BlogState {}

final class BlogSuccess extends BlogState {}
