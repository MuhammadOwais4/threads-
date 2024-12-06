import 'package:demo/models/post_model.dart';
import 'package:demo/utils/helpers.dart';
import 'package:flutter/material.dart';
class PostCardTopBar extends StatelessWidget {
  final PostModel post;
  const PostCardTopBar({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              post.users!.metadata!.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  formateDateFromNow(
                    post.createdAt!,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          style: const TextStyle(
            fontSize: 16,
          ),
          post.content!,
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
