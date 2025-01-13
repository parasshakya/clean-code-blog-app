import 'package:clean_code_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel(
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

  // fromDomain function
  factory BlogModel.fromDomain(Blog blog) {
    return BlogModel(
        id: blog.id,
        title: blog.title,
        content: blog.content,
        imageUrl: blog.imageUrl,
        topics: blog.topics,
        userId: blog.userId);
  }

  // toDomain function
  Blog toDomain() {
    return Blog(
        id: id,
        title: title,
        content: content,
        imageUrl: imageUrl,
        topics: topics,
        userId: userId);
  }
}
