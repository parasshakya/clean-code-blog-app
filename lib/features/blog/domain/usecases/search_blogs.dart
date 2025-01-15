import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class SearchBlogs implements UseCase<List<Blog>, SearchBlogsParams> {
  final BlogRepository blogRepository;

  SearchBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(SearchBlogsParams params) async {
    return await blogRepository.searchBlogs(params.query);
  }
}

class SearchBlogsParams {
  String query;
  SearchBlogsParams({required this.query});
}
