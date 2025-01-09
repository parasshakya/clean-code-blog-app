part of 'blog_detail_bloc.dart';

@immutable
sealed class BlogDetailEvent {}

final class BlogDetailPosterFetched extends BlogDetailEvent {
  final String userId;

  BlogDetailPosterFetched({required this.userId});
}
