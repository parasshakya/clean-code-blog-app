import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/usecases/search_blogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_blogs_event.dart';
part 'search_blogs_state.dart';

class SearchBlogsBloc extends Bloc<SearchBlogsEvent, SearchBlogsState> {
  final SearchBlogs _searchBlogs;
  SearchBlogsBloc({required SearchBlogs searchBlogs})
      : _searchBlogs = searchBlogs,
        super(SearchBlogsInitial(blogs: [])) {
    on<SearchBlogsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SearchBlogsSearched>(_onSearchBlogsSearched);
    on<SearchBlogsCleared>(_onSearchBlogsCleared);
  }

  _onSearchBlogsSearched(
      SearchBlogsSearched event, Emitter<SearchBlogsState> emit) async {
    emit(SearchBlogsLoadInProgress());
    final response = await _searchBlogs(SearchBlogsParams(query: event.query));
    response.fold(
        (failure) => emit(SearchBlogsFailure(errorMessage: failure.message)),
        (blogs) => emit(SearchBlogsSuccess(blogs: blogs)));
  }

  _onSearchBlogsCleared(
      SearchBlogsCleared event, Emitter<SearchBlogsState> emit) {
    emit(SearchBlogsInitial(blogs: []));
  }
}
