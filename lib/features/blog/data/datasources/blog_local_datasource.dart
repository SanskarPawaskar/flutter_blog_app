import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:hive/hive.dart';

abstract interface class BlogLocalDatasource {
  void uploadLocalBlogs({required List<BlogModel> blogs});
  List<BlogModel> loadBlogs();
}

class BlogLocalDatasourceImpl implements BlogLocalDatasource {
  final Box box;

  BlogLocalDatasourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    for (int i = 0; i < box.length; i++) {
      blogs.add(BlogModel.fromJson(box.get(i.toString())));
    }
    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    for (int i = 0; i < blogs.length; i++) {
      box.put(i.toString(), blogs[i].toJson());
    }
  }
}
