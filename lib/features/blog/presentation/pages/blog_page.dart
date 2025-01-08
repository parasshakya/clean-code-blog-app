import 'package:clean_code_app/core/common/widgets/loader.dart';
import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:clean_code_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<BlogBloc>().add(BlogsGetAll());
    super.initState();
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogsGetAllFailure) {
            showSnackBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          if (state is BlogsGetAllLoadInProgress) {
            return const Loader();
          }
          if (state is BlogsGetAllSuccess) {
            return ListView.builder(
                itemCount: state.blogs.length,
                itemBuilder: (context, index) {
                  final blog = state.blogs[index];
                  return BlogCard(
                    blog: blog,
                    color: index % 3 == 0
                        ? AppPallete.gradient2
                        : index % 3 == 1
                            ? AppPallete.gradient1
                            : AppPallete.gradient3,
                  );
                });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
