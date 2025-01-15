import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'blog_repository.mock.dart';

void main() {
  late BlogRepository repository;
  late GetAllBlogs getAllBlogs;
  late List<Blog> blogList;
  late GetAllBlogsParams getAllBlogsParams;

  setUpAll(() {
    repository = MockBlogRepository();
    getAllBlogs = GetAllBlogs(blogRepository: repository);

    blogList = [Blog.empty()];
    getAllBlogsParams = GetAllBlogsParams();
  });

  group("Get all blogs", () {
    test(
        "Given [BlogRepository] when [getAllBlogs] is called then return [List<Blog>]",
        () async {
      //Arrange or stub
      when(() => repository.getAllBlogs())
          .thenAnswer((invocation) async => Right(blogList));

      //Act
      final result = await getAllBlogs(getAllBlogsParams);

      //Assert
      expect(result, equals(Right<Failure, List<Blog>>(blogList)));
    });

    test(
        "Given [BlogRepository] when [getAllBlogs] fails then return [Failure] ",
        () async {
      //Arrange or stub
      final failure = Failure(message: "Failed to get blogs");
      when(() => repository.getAllBlogs())
          .thenAnswer((invocation) async => Left(failure));

      //Act
      final result = await getAllBlogs(getAllBlogsParams);

      //Assert
      expect(result, equals(Left<Failure, List<Blog>>(failure)));
    });
  });

  group("Get blogs by filtering based on topic", () {
    String topic = "Technology";

    test(
        "Given [BlogRepository] when [getAllBlogs(topic)] call succeeds then it should return [List<Blog>] on that topic only.  ",
        () async {
      //blogs on technology topic
      const List<Blog> technologyBlogs = [
        Blog(
            id: '1',
            title: 'tech',
            content: 'tech',
            imageUrl: '',
            topics: ['Technology'],
            userId: '1234'),
        Blog(
            id: '2',
            title: 'tech',
            content: 'tech',
            imageUrl: '',
            topics: ['Technology, Biology, Physics'],
            userId: '4324'),
      ];

      when(() => repository.getAllBlogs(topic: topic))
          .thenAnswer((invocation) async => const Right(technologyBlogs));

      final result = await getAllBlogs(GetAllBlogsParams(topic: topic));

      expect(result, equals(const Right<Failure, List<Blog>>(technologyBlogs)));
    });

    test(
        "Given [BlogRepository] when [getAllBlogs(topic)] call fails then it should return [Failure].",
        () async {
      final failure = Failure(message: "failed to load blogs");

      when(() => repository.getAllBlogs(topic: topic))
          .thenAnswer((invocation) async => Left(failure));

      final result = await getAllBlogs(GetAllBlogsParams(topic: topic));

      expect(result, equals(Left<Failure, List<Blog>>(failure)));
    });
  });
}
