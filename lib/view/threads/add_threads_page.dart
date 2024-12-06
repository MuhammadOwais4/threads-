import 'package:demo/controllers/threads_controller.dart';
import 'package:demo/services/navigation_services.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:demo/widgets/threads/threads_image_preview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddThreadsPage extends StatefulWidget {
  const AddThreadsPage({super.key});

  @override
  State<AddThreadsPage> createState() => _AddThreadsPageState();
}

class _AddThreadsPageState extends State<AddThreadsPage> {
  final ThreadsController controller = Get.put(ThreadsController());

  final TextEditingController textEditingController = TextEditingController();

  String content = "";

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Add Threads"),
          leading: IconButton(
            onPressed: () {
              Get.find<NavigationServices>().backtoPrev();
            },
            icon: const Icon(
              Icons.cancel,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (!controller.isLoading.value && content.isNotEmpty) {
                  controller.addThread(
                    textEditingController.text,
                    SupabaseService.currentUser.value!.id,
                  );
                }
              },
              child: controller.isLoading.value
                  ? const CircularProgressIndicator.adaptive()
                  : Text(
                      "Post",
                      style: TextStyle(
                          color: content.isEmpty ? Colors.grey[800] : null),
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      child: ImageCircle(
                        url: getS5Url(
                          SupabaseService
                              .currentUser.value!.userMetadata?["image"],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: context.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            SupabaseService
                                .currentUser.value!.userMetadata?["name"],
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
                              hintText: "Type a thread",
                            ),
                            style: const TextStyle(fontSize: 14),
                          ),
                          IconButton(
                            onPressed: () => controller.pickImage(),
                            icon: const Icon(
                              Icons.attach_file,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (controller.image.value != null) const ThreadsImagePreview()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
