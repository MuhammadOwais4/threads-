import 'package:demo/models/post_model.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/home/post_card_bottom_bar.dart';
import 'package:demo/widgets/home/post_card_image.dart';
import 'package:demo/widgets/home/post_card_top_bar.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadCard extends StatelessWidget {
  final PostModel post;
  const ThreadCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: ImageCircle(
                  url: getS5Url(
                    post.users!.metadata?.image,
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
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          RoutesNames.showThread,
                          arguments: post,
                        );
                      },
                      child: Column(
                        children: [
                          PostCardTopBar(
                            post: post,
                          ),
                          if (post.image != null)
                            PostCardImage(
                              post: post,
                            ),
                        ],
                      ),
                    ),
                    PostCardBottomBar(
                      post: post,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(
            color: Color(
              0xff242424,
            ),
          ),
        ],
      ),
    );
  }
}
