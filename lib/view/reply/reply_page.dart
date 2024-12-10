import 'package:demo/controllers/reply_controller.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/widgets/home/post_card_image.dart';
import 'package:demo/widgets/home/post_card_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ReplyPage extends StatefulWidget {
  ReplyPage({super.key});

  @override
  State<ReplyPage> createState() => _ReplyPageState();
}

class _ReplyPageState extends State<ReplyPage> {
  final ReplyController controller = Get.put(ReplyController());

  final TextEditingController textEditingController = TextEditingController();

  String content = "";

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Reply"),
          actions: [
            TextButton(
              onPressed: () {
                if (content.isNotEmpty) {
                  controller.addReply(
                    SupabaseService.currentUser.value!.id,
                    post.postId!,
                    post.userId!,
                    textEditingController.text,
                  );
                }
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      "Reply",
                      style: TextStyle(
                        color: content.isEmpty ? Colors.grey[800] : null,
                      ),
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
                  "../images/avatar.png",
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
                    onChanged: (value) {
                      setState(() {
                        content = value;
                      });
                    },
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
      ),
    );
  }
}
