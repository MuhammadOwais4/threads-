import 'package:demo/controllers/home_controller.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class PostCardBottomBar extends StatefulWidget {
  const PostCardBottomBar({super.key, required this.post});
  final PostModel post;

  @override
  State<PostCardBottomBar> createState() => _PostCardBottomBarState();
}

class _PostCardBottomBarState extends State<PostCardBottomBar> {
  String likeStatus = "";

  final HomeController controller = Get.find<HomeController>();

  void likeDislike(String status) {
    setState(() {
      likeStatus = status;
    });
    controller.likePost(
      widget.post.postId!,
      SupabaseService.currentUser.value!.id,
      widget.post.userId!,
      status,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            if (likeStatus == "1")
              IconButton(
                onPressed: () {
                  likeDislike("0");
                },
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
              )
            else
              IconButton(
                onPressed: () {
                  likeDislike("1");
                },
                icon: const Icon(Icons.favorite),
              ),
            IconButton(
              onPressed: () {
                Get.toNamed(
                  RoutesNames.reply,
                );
              },
              icon: const Icon(Icons.chat_bubble),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(RoutesNames.reply, arguments: widget.post);
              },
              icon: const Icon(Icons.send),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Row(
          children: [
            Text(
              "${widget.post.commentCount} Replies",
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "${widget.post.likeCount} Likes",
            ),
          ],
        )
      ],
    );
  }
}
