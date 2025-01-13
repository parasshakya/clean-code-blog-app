import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockBlogRepository extends Mock implements BlogRepository {}

void main() {
  late BlogRepository repository;
  late GetAllBlogs getAllBlogs;
  late List<Blog> blogList;
  late NoParams noParams;

  setUpAll(() {
    repository = MockBlogRepository();
    getAllBlogs = GetAllBlogs(blogRepository: repository);

    blogList = [Blog.empty()];
    noParams = NoParams();
  });

  test(
      "Given [BlogRepository] when [getAllBlogs] is called then return [List<Blog>]",
      () async {
    //Arrange or stub
    when(() => repository.getAllBlogs())
        .thenAnswer((invocation) async => Right(blogList));

    //Act
    final result = await getAllBlogs(noParams);

    //Assert
    expect(result, equals(Right<Failure, List<Blog>>(blogList)));
  });

  test("Given [BlogRepository] when [getAllBlogs] fails then return [Failure] ",
      () async {
    //Arrange or stub
    final failure = Failure(message: "Failed to get blogs");
    when(() => repository.getAllBlogs())
        .thenAnswer((invocation) async => Left(failure));

    //Act
    final result = await getAllBlogs(noParams);

    //Assert
    expect(result, equals(Left<Failure, List<Blog>>(failure)));
  });
}
