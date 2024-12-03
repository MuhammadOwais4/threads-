import 'package:demo/models/post_model.dart';
import 'package:demo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCardImage extends StatelessWidget {
  final PostModel post;
  const PostCardImage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.height * 0.60,
            maxWidth: context.width,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              10,
            ),
            child: Image.network(
              getS5Url(post.image)!,
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
