import 'dart:io';

import 'package:clean_code_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:clean_code_app/core/page_transitions/right_to_left_page_route.dart';
import 'package:clean_code_app/core/widgets/loader.dart';
import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/core/utils/pick_image.dart';
import 'package:clean_code_app/core/utils/show_snackbar.dart';
import 'package:clean_code_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_code_app/features/blog/data/models/blog_model.dart';
import 'package:clean_code_app/features/blog/presentation/blocs/add_new_blog/add_new_blog_bloc.dart';
import 'package:clean_code_app/features/blog/presentation/pages/blogs_page.dart';
import 'package:clean_code_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => RightToLeftPageRoute(page: const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;
  final formKey = GlobalKey<FormState>();

  selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      image = pickedImage;
      setState(() {});
    }
  }

  uploadBlog() async {
    if (formKey.currentState!.validate() &&
        image != null &&
        selectedTopics.isNotEmpty) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserLoggedIn).user.id;
      final blog = BlogModel(
          id: DateTime.now().toString(),
          title: titleController.text.trim(),
          content: contentController.text.trim(),
          imageUrl: "",
          topics: selectedTopics,
          userId: userId);
      context
          .read<AddNewBlogBloc>()
          .add(AddNewBlogUploaded(blog: blog, image: image!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Blog"),
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(
                Icons.done_outlined,
                size: 30,
              ))
        ],
      ),
      body: BlocConsumer<AddNewBlogBloc, AddNewBlogState>(
        listener: (context, state) {
          if (state is AddNewBlogFailure) {
            showSnackBar(context, state.errorMessage);
          }
          if (state is AddNewBlogSuccess) {
            Navigator.of(context).pushAndRemoveUntil(
              BlogsPage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is AddNewBlogLoadInProgress) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: selectImage,
                      child: image != null
                          ? SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  )))
                          : DottedBorder(
                              color: AppPallete.borderColor,
                              dashPattern: const [10, 4],
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(8),
                              strokeCap: StrokeCap.round,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 14,
                                    ),
                                    Text("Select your image")
                                  ],
                                ),
                              )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            "Technology",
                            "Biology",
                            "Politics",
                            "Entertainment",
                            "Physics",
                            "Business"
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (selectedTopics.contains(e)) {
                                            selectedTopics.remove(e);
                                          } else {
                                            selectedTopics.add(e);
                                          }
                                          setState(() {});
                                        },
                                        child: Chip(
                                            side: selectedTopics.contains(e)
                                                ? null
                                                : const BorderSide(
                                                    color:
                                                        AppPallete.borderColor),
                                            color: selectedTopics.contains(e)
                                                ? const MaterialStatePropertyAll(
                                                    AppPallete.gradient2)
                                                : null,
                                            label: Text(e))),
                                  ))
                              .toList(),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    BlogEditor(
                        hintText: "Blog Title",
                        textEditingController: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                        hintText: "Blog Content",
                        textEditingController: contentController)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
