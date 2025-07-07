import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/fpdart.dart';


class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepositories blogRepositories;

  GetAllBlogs(this.blogRepositories);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepositories.getAllBlogs();
  }
}
