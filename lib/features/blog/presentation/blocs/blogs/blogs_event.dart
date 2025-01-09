part of 'blogs_bloc.dart';

@immutable
sealed class BlogsEvent {}

final class BlogsFetched extends BlogsEvent {}
