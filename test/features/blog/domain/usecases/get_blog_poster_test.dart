import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_code_app/features/blog/domain/usecases/get_blog_poster.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import 'blog_repository.mock.dart';

void main() {
  late BlogRepository mockBlogRepository;
  late GetBlogPoster getBlogPoster;
  late User user;
  late GetBlogPosterParams getBlogPosterParams;

  setUpAll(() {
    mockBlogRepository = MockBlogRepository();
    getBlogPoster = GetBlogPoster(blogRepository: mockBlogRepository);
    user = User(id: "1", name: "Paras", email: "paras@gmail.com");
    getBlogPosterParams = GetBlogPosterParams(userId: user.id);
  });

  test(
      "Given [BlogRepository] when [getBlogPoster] is called then return [User]",
      () async {
    when(() => mockBlogRepository.getBlogPoster(user.id))
        .thenAnswer((invocation) async => Right(user));

    final result = await getBlogPoster(getBlogPosterParams);

    expect(result, equals(Right<Failure, User>(user)));

    verify(() => mockBlogRepository.getBlogPoster(user.id)).called(1);
  });

  test(
      "Given [BlogRepository] when [getBlogPoster] fails then return [Failure]",
      () async {
    final failure = Failure(message: "Failed to get blog poster");

    when(() => mockBlogRepository.getBlogPoster(user.id))
        .thenAnswer((invocation) async => Left(failure));

    final result = await getBlogPoster(getBlogPosterParams);

    expect(result, equals(Left<Failure, User>(failure)));
    verify(() => mockBlogRepository.getBlogPoster(user.id)).called(1);
  });
}
