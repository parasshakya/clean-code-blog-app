import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final String userId;

  const Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.userId});

  Blog.empty()
      : this(
            content: "",
            id: "",
            imageUrl: "",
            title: "",
            topics: [],
            userId: '');

  @override
  List<Object?> get props => [id, content, title, imageUrl, topics, userId];
}
