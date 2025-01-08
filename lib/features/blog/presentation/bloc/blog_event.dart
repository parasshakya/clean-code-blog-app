part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUploaded extends BlogEvent {
  final BlogModel blog;
  final File image;

  BlogUploaded({required this.blog, required this.image});
}

final class BlogLoaded extends BlogEvent {}
