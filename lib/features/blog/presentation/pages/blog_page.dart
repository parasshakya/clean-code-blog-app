import 'package:clean_code_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (_) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(AddNewBlogPage.route());
              },
              icon: const Icon(Icons.add_circle_outline_rounded))
        ],
      ),
      body: Center(
        child: Text("Welcome to homepage"),
      ),
    );
  }
}
