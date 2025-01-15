part of 'search_blogs_bloc.dart';

sealed class SearchBlogsEvent {
  const SearchBlogsEvent();
}

class SearchBlogsSearched extends SearchBlogsEvent {
  final String query;

  SearchBlogsSearched({required this.query});
}

class SearchBlogsCleared extends SearchBlogsEvent {}
