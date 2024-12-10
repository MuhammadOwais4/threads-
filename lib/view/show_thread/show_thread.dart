import 'package:demo/controllers/home_controller.dart';
import 'package:demo/models/reply_model.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/home/thread_card.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShowThread extends StatefulWidget {
  const ShowThread({super.key});

  @override
  State<ShowThread> createState() => _ShowThreadState();
}

class _ShowThreadState extends State<ShowThread> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    controller.showThread(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Thread"),
      ),
      body: Obx(
        () => controller.showThreadLoading.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SingleChildScrollView(
                child: controller.post.value != null
                    ? Column(
                        children: [
                          ThreadCard(
                            post: controller.post.value!,
                          ),
                          if (controller.replies.value.isNotEmpty)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  for (ReplyModel reply
                                      in controller.replies.value)
                                    ListTile(
                                      isThreeLine: true,
                                      titleAlignment:
                                          ListTileTitleAlignment.top,
                                      onTap: () {},
                                      leading: ImageCircle(
                                        url: gets5Url(
                                          reply.users!.metadata?.image,
                                        ),
                                      ),
                                      title: Text(
                                        reply.users!.metadata!.name!,
                                      ),
                                      subtitle: Text(
                                        reply.reply!,
                                      ),
                                      trailing: Text(
                                        formateDateFromNow(
                                          reply.createdAt!,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            )
                        ],
                      )
                    : null,
              ),
      ),
    );
  }
}
