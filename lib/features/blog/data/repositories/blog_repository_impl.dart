import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepositories {
  final BlogRemoteDatasource blogRemoteDatasource;

  BlogRepositoryImpl(this.blogRemoteDatasource);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        url: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDatasource.uploadImage(
        image: image,
        blog: blogModel,
      );
      blogModel = blogModel.copyWith(url: imageUrl);
      final uploadedBlog = await blogRemoteDatasource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerExceptoion catch (e) {
      return left(Failure(e.excetionMessage));
    }
  }
}
