import 'package:clean_code_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/widgets/loader.dart';
import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/blogs/blogs_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:clean_code_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:clean_code_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:clean_code_app/features/blog/presentation/widgets/drop_down_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const BlogsPage());
  const BlogsPage({super.key});

  @override
  State<BlogsPage> createState() => _BlogsPageState();
}

class _BlogsPageState extends State<BlogsPage> {
  String selectedFilter = 'All'; // Default filter
  final List<String> filters = [
    "All",
    "Technology",
    "Biology",
    "Politics",
    "Entertainment",
    "Physics",
    "Business"
  ];

  @override
  void initState() {
    context.read<BlogsBloc>().add(BlogsFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog App"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              final currentUserId =
                  (context.read<AppUserCubit>().state as AppUserLoggedIn)
                      .user
                      .id;
              context
                  .read<AuthBloc>()
                  .add(AuthLoggedOut(userId: currentUserId));
            },
            icon: const Icon(Icons.logout),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(AddNewBlogPage.route());
                },
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  size: 30,
                ))
          ],
        ),
        body: Column(
          children: [
            DropDownFilterButton(
                filters: filters,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedFilter = value;
                    });

                    if (value == "All") {
                      context.read<BlogsBloc>().add(BlogsFetched());
                    } else {
                      context
                          .read<BlogsBloc>()
                          .add(BlogsFetched(topic: selectedFilter));
                    }
                  }
                },
                selectedFilter: selectedFilter),
            BlocListener<AppUserCubit, AppUserState>(
              listener: (context, state) {
                if (state is AppUserInitial) {
                  Navigator.of(context)
                      .pushAndRemoveUntil(SignInPage.route(), (route) => false);
                }
              },
              child: BlocConsumer<BlogsBloc, BlogsState>(
                listener: (context, state) {
                  if (state is BlogsFailure) {
                    showSnackBar(context, state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is BlogsLoadInProgress) {
                    return const Loader();
                  }
                  if (state is BlogsFailure) {
                    return const Center(
                      child:
                          Text("Failed to load blogs, Please try again later."),
                    );
                  }
                  if (state is BlogsSuccess) {
                    if (state.blogs.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("No blogs found"),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.blogs.length,
                          itemBuilder: (context, index) {
                            final blog = state.blogs[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(BlogDetailPage.route(blog));
                              },
                              child: BlogCard(
                                blog: blog,
                                color: index % 3 == 0
                                    ? AppPallete.gradient2
                                    : index % 3 == 1
                                        ? AppPallete.gradient1
                                        : AppPallete.gradient3,
                              ),
                            );
                          }),
                    );
                  }
                  return const Loader();
                },
              ),
            ),
          ],
        ));
  }
}
