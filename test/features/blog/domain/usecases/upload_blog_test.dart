import 'dart:io';

import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_code_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockBlogRepository extends Mock implements BlogRepository {}

void main() {
  late UploadBlog uploadBlog;
  late BlogRepository mockBlogRepository;
  late Blog blog;
  late File image;

  setUpAll(() {
    mockBlogRepository = MockBlogRepository();
    uploadBlog = UploadBlog(blogRepository: mockBlogRepository);
    blog = Blog.empty();
    image = File('path');
  });

  test("Given [BlogRepository] when [uploadBlog] is called then return [Blog]",
      () async {
    //Arrage
    final uploadedBlog = Blog.empty();

    when(() => mockBlogRepository.uploadBlog(blog, image))
        .thenAnswer((invocation) async => Right(uploadedBlog));

    //Act
    final result = await uploadBlog(UploadBlogParams(blog: blog, image: image));

    //Assert
    expect(result, equals(Right<Failure, Blog>(uploadedBlog)));
    verify(() => mockBlogRepository.uploadBlog(blog, image))
        .called(1); // Verify call
  });

  test("Given [BlogRepository] when [uploadBlog] fails then return [Failure]",
      () async {
    //Arrage
    final failure = Failure(message: "Failed to upload blog");

    when(() => mockBlogRepository.uploadBlog(blog, image))
        .thenAnswer((invocation) async => Left(failure));

    //Act
    final result = await uploadBlog(UploadBlogParams(blog: blog, image: image));

    //Assert
    expect(result, equals(Left<Failure, Blog>(failure)));
    verify(() => mockBlogRepository.uploadBlog(blog, image))
        .called(1); // Verify call
  });
}
