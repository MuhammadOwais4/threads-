import 'package:demo/controllers/reply_controller.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/widgets/home/post_card_image.dart';
import 'package:demo/widgets/home/post_card_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReplyPage extends StatelessWidget {
  ReplyPage({super.key});

  final ReplyController controller = Get.put(ReplyController());

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reply"),
        actions: [
          TextButton(
            onPressed: () {
              controller.addReply(
                SupabaseService.currentUser.value!.id,
                post.postId!,
                post.userId!,
                textEditingController.text,
              );
            },
            child: controller.isLoading.value
                ? const CircularProgressIndicator.adaptive()
                : const Text(
                    "Reply",
                  ),
          ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width * 0.12,
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(
                "./assets/images/avatar.png",
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: context.width * 0.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCardTopBar(
                  post: post,
                ),
                PostCardImage(
                  post: post,
                ),
                TextFormField(
                  controller: textEditingController,
                  autofocus: true,
                  maxLines: 10,
                  minLines: 1,
                  maxLength: 1000,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type a reply",
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
