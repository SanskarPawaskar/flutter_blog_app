import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widget/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogs());
  }

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
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.failure);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return Loader();
          }
          if (state is BlogDisplaySuccess) {
            return ListView.builder(
              itemCount: state.blogs.length,

              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 1
                      ? AppPallete.gradient1
                      : index % 3 == 0
                      ? AppPallete.gradient2
                      : AppPallete.gradient3,
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
