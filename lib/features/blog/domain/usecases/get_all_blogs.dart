import 'package:clean_code_app/core/error/failures.dart';
import 'package:clean_code_app/core/usecase/usecase.dart';
import 'package:clean_code_app/features/blog/domain/entities/blog.dart';
import 'package:clean_code_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, GetAllBlogsParams> {
  final BlogRepository blogRepository;

  GetAllBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(GetAllBlogsParams params) async {
    return await blogRepository.getAllBlogs(topic: params.topic);
  }
}

class GetAllBlogsParams {
  String? topic;

  GetAllBlogsParams({this.topic});
}
