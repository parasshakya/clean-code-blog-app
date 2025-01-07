import 'package:clean_code_app/core/theme/app_pallete.dart';
import 'package:clean_code_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Blog"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.done_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              DottedBorder(
                  color: AppPallete.borderColor,
                  dashPattern: const [10, 4],
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  strokeCap: StrokeCap.round,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    child: const Column(
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
                                              color: AppPallete.borderColor),
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
  }
}
