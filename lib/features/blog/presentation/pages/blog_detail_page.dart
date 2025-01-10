import 'package:clean_code_app/core/common/widgets/loader.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blog_detail/blog_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailPage extends StatefulWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (_) => BlogDetailPage(blog: blog));
  final Blog blog;
  const BlogDetailPage({super.key, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  void initState() {
    context
        .read<BlogDetailBloc>()
        .add(BlogDetailPosterFetched(userId: widget.blog.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                          fit: BoxFit.cover, widget.blog.imageUrl)),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<BlogDetailBloc, BlogDetailState>(
                    builder: (context, state) {
                  if (state is BlogDetailGetPosterLoadInProgress) {
                    return const Loader();
                  }

                  if (state is BlogDetailGetPosterSuccess) {
                    return Text(state.poster.name);
                  }

                  return const SizedBox();
                }, listener: (context, state) {
                  if (state is BlogDetailGetPosterFailure) {
                    showSnackBar(context, "Failed to get poster");
                  }
                }),
                Text(
                  widget.blog.title,
                  style: const TextStyle(fontSize: 30),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.blog.content,
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
