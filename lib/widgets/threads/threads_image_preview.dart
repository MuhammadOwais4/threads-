import 'package:demo/controllers/threads_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadsImagePreview extends StatefulWidget {
  const ThreadsImagePreview({
    super.key,
  });

  @override
  State<ThreadsImagePreview> createState() => _ThreadsImagePreviewState();
}

class _ThreadsImagePreviewState extends State<ThreadsImagePreview> {
  final ThreadsController controller = Get.find<ThreadsController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                10,
              ),
              child: Image.file(
                controller.image.value!,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              onPressed: () => controller.image.value = null,
              icon: const Icon(
                Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
