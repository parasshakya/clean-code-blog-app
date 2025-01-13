import 'package:clean_code_app/core/entities/user.dart';
import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBlogPoster implements UseCase<User, GetBlogPosterParams> {
  final BlogRepository blogRepository;

  GetBlogPoster({required this.blogRepository});
  @override
  Future<Either<Failure, User>> call(GetBlogPosterParams params) async {
    return await blogRepository.getBlogPoster(params.userId);
  }
}

class GetBlogPosterParams {
  final String userId;

  GetBlogPosterParams({required this.userId});
}
