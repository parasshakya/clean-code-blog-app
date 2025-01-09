part of 'add_new_blog_bloc.dart';

@immutable
sealed class AddNewBlogState {}

final class AddNewBlogInitial extends AddNewBlogState {}

final class AddNewBlogSuccess extends AddNewBlogState {}

final class AddNewBlogLoadInProgress extends AddNewBlogState {}

final class AddNewBlogFailure extends AddNewBlogState {
  final String errorMessage;

  AddNewBlogFailure({required this.errorMessage});
}
