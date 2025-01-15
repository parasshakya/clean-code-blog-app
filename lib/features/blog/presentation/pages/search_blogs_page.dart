import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/core/widgets/loader.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/search_blogs/search_blogs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBlogsPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const SearchBlogsPage());
  const SearchBlogsPage({super.key});

  @override
  State<SearchBlogsPage> createState() => _SearchBlogsPageState();
}

class _SearchBlogsPageState extends State<SearchBlogsPage> {
  @override
  void initState() {
    context.read<SearchBlogsBloc>().add(SearchBlogsCleared());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Blogs"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchBar(
              hintText: "Search for blogs",
              autoFocus: true,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<SearchBlogsBloc>().add(SearchBlogsCleared());
                } else {
                  context
                      .read<SearchBlogsBloc>()
                      .add(SearchBlogsSearched(query: value));
                }
              },
            ),
            BlocConsumer<SearchBlogsBloc, SearchBlogsState>(
              builder: (context, state) {
                if (state is SearchBlogsInitial) {
                  return const SizedBox();
                }
                if (state is SearchBlogsLoadInProgress) {
                  return const Loader();
                }
                if (state is SearchBlogsFailure) {
                  return const Center(
                    child:
                        Text("Something went wrong. Please try again later."),
                  );
                }
                if (state is SearchBlogsSuccess) {
                  if (state.blogs.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: Text("Not found"),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final blog = state.blogs[index];
                        return ListTile(
                          title: Text(blog.title),
                        );
                      },
                      itemCount: state.blogs.length,
                    ),
                  );
                }
                return const Center(
                  child: Text("No State Found"),
                );
              },
              listener: (context, state) {
                if (state is SearchBlogsFailure) {
                  showSnackBar(context, "Failed to search blogs");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
