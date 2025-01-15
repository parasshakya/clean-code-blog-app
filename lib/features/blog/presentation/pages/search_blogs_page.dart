import 'package:clean_code_app/core/page_transitions/right_to_left_page_route.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/core/widgets/loader.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/search_blogs/search_blogs_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBlogsPage extends StatefulWidget {
  static route() => RightToLeftPageRoute(page: const SearchBlogsPage());
  const SearchBlogsPage({super.key});

  @override
  State<SearchBlogsPage> createState() => _SearchBlogsPageState();
}

class _SearchBlogsPageState extends State<SearchBlogsPage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    context.read<SearchBlogsBloc>().add(SearchBlogsCleared());
    // Automatically focus the search bar and show the keyboard
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });

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
            TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              decoration: const InputDecoration(
                hintText: 'Search blogs...',
                prefixIcon: Icon(Icons.search),
              ),
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
