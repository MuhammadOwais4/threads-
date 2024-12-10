import 'package:demo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostImagePreview extends StatelessWidget {
  const PostImagePreview({super.key});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Preview"),
        centerTitle: true,
      ),
      body: Center(
        child: Image.network(
          height: 600,
          width: double.infinity,
          gets5Url(imageUrl)!,
        ),
      ),
    );
  }
}
