part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploaded extends BlogEvent {
  final BlogModel blog;
  final File image;

  BlogUploaded({required this.blog, required this.image});
}

final class BlogsGetAll extends BlogEvent {}

final class BlogGetPoster extends BlogEvent {
  final String userId;

  BlogGetPoster({required this.userId});
}
