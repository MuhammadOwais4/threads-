import 'package:demo/controllers/home_controller.dart';
import 'package:demo/models/post_model.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/common/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCardTopBar extends StatefulWidget {
  final PostModel post;
  const PostCardTopBar({super.key, required this.post});

  @override
  State<PostCardTopBar> createState() => _PostCardTopBarState();
}

class _PostCardTopBarState extends State<PostCardTopBar> {
  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              RoutesNames.showThread,
              arguments: widget.post.postId,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.post.users!.metadata!.name!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    formateDateFromNow(
                      widget.post.createdAt!,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                  ),
                  widget.post.userId == SupabaseService.currentUser.value!.id
                      ? IconButton(
                          onPressed: () {
                            Get.dialog(ConfirmationDialog(
                              title: "Are you sure ?",
                              message: "This action will delete this post]",
                              callback: () {
                                controller.deletePost(widget.post.postId!);
                                Get.back();
                              },
                            ));
                          },
                          icon: const Icon(
                            color: Colors.red,
                            size: 20,
                            Icons.delete,
                          ),
                        )
                      : const Text("")
                ],
              ),
            ],
          ),
        ),
        Text(
          style: const TextStyle(
            fontSize: 16,
          ),
          widget.post.content!,
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
