import 'package:clean_code_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  const BlogModel(
      {required super.id,
      required super.title,
      required super.content,
      required super.imageUrl,
      required super.topics,
      required super.userId});

  // Check for missing keys and throw an exception
  factory BlogModel.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('_id') ||
        !json.containsKey('title') ||
        !json.containsKey('content') ||
        !json.containsKey('imageUrl') ||
        !json.containsKey('topics') ||
        !json.containsKey('userId')) {
      throw Exception('Invalid Blog JSON: Missing required fields');
    }
    // Additional validation to ensure proper data types
    if (json['_id'] is! String ||
        json['title'] is! String ||
        json['content'] is! String ||
        json['imageUrl'] is! String ||
        json['topics'] is! List ||
        json['userId'] is! String) {
      throw Exception('Invalid Blog JSON: Incorrect data types');
    }

    return BlogModel(
        id: json["_id"],
        title: json["title"],
        content: json["content"],
        imageUrl: json["imageUrl"],
        topics: List<String>.from(json["topics"]),
        userId: json["userId"]);
  }

  Map<String, dynamic> toJsonForCreate() {
    // Validate fields before converting to JSON
    if (title.isEmpty || content.isEmpty || topics.isEmpty || userId.isEmpty) {
      throw Exception('Invalid BlogModel: Missing required fields');
    }

    return {
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "topics": topics,
      "userId": userId
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    // Validate fields before converting to JSON
    if (id.isEmpty ||
        title.isEmpty ||
        content.isEmpty ||
        topics.isEmpty ||
        userId.isEmpty ||
        imageUrl.isEmpty) {
      throw Exception('Invalid BlogModel: Missing required fields');
    }

    return {
      "_id": id,
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "topics": topics,
      "userId": userId
    };
  }

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
