import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({super.key, required this.blog, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Row(
              children: [
                ...blog.topics.map((e) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Chip(side: null, label: Text(e)),
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            blog.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            blog.content,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
