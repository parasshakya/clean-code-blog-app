import 'package:clean_code_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.userId});

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["imageUrl"],
        topics: List<String>.from(json["topics"]),
        userId: json["userId"]);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
        "topics": topics,
        "userId": userId
      };
}
