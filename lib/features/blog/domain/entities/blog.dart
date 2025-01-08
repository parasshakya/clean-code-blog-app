class Blog {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final String userId;

  Blog(
      {required this.id,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.topics,
      required this.userId});
}
