import 'dart:io';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:supabase/supabase.dart';

abstract interface class BlogRemoteDatasource {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadImage({required File image, required BlogModel blog});
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDatasourceImpl extends BlogRemoteDatasource {
  final SupabaseClient supabase;
  @override
  BlogRemoteDatasourceImpl(this.supabase);
  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData = await supabase
          .from("blogs")
          .insert(blog.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File image,
    required BlogModel blog,
  }) async {
    try {
      await supabase.storage.from('blog_images').upload(blog.id, image);
      return supabase.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabase.from('blogs').select('*,profiles (name)');
      return blogs
          .map(
            (blog) => BlogModel.fromJson(
              blog,
            ).copyWith(posterName: blog['profiles']['name']),
          )
          .toList();
    } catch (e) {
      throw ServerExceptoion(e.toString());
    }
  }
}
