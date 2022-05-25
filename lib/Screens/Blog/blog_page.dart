import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static const routename = '/blog_page';
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('TODO: Blog link to AWS'),
      ),
    );
  }
}
