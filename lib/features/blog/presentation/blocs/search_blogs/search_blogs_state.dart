part of 'search_blogs_bloc.dart';

sealed class SearchBlogsState {
  const SearchBlogsState();
}

final class SearchBlogsInitial extends SearchBlogsState {
  List<Blog> blogs = [];

  SearchBlogsInitial({required this.blogs});
}

final class SearchBlogsSuccess extends SearchBlogsState {
  final List<Blog> blogs;

  SearchBlogsSuccess({required this.blogs});
}

final class SearchBlogsFailure extends SearchBlogsState {
  final String errorMessage;

  SearchBlogsFailure({required this.errorMessage});
}

final class SearchBlogsLoadInProgress extends SearchBlogsState {}
