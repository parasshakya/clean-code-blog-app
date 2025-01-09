part of 'add_new_blog_bloc.dart';

@immutable
sealed class AddNewBlogEvent {}

final class AddNewBlogUploaded extends AddNewBlogEvent {
  final BlogModel blog;
  final File image;

  AddNewBlogUploaded({required this.blog, required this.image});
}
