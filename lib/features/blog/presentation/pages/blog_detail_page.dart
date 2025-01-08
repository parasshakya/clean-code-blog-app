import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogDetailPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (_) => BlogDetailPage(blog: blog));
  final Blog blog;
  const BlogDetailPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(fit: BoxFit.cover, blog.imageUrl)),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              blog.title,
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              blog.content,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
