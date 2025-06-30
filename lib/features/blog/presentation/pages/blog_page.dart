import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Blog App")),
        actions: [
          IconButton(
            onPressed: () {
              print("object");
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
    );
  }
}
