import 'dart:io';
import 'package:demo/services/navigation_services.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ThreadsController extends GetxController {
  Rx<File?> image = Rx<File?>(
    null,
  );
  RxBool isLoading = false.obs;


  String uploadedPath = "";
  void pickImage() async {
    final file = await pickFileFromGallery();
    if (file != null) image.value = file;
  }

  Future<void> addThread(String content, String userId) async {
    try {
      isLoading.value = true;
      if (image.value != null && image.value!.existsSync()) {
        const uuid = Uuid();
        final dir = "$userId/${uuid.v6()}";

        String url =
            await SupabaseService.client.storage.from("threadss5").upload(
                  dir,
                  image.value!,
                );

        uploadedPath = url;
      }

      if (content.isNotEmpty) {
        await SupabaseService.client.from("posts").insert(
          {
            "content": content,
            "image": uploadedPath.isNotEmpty ? uploadedPath : null,
            "like_count": 0,
            "comment_count": 0,
            "user_id": userId,
          },
        );
      }
      showCustomSnackBar(
        "Success",
        "Thread created successfully",
      );

      Get.find<NavigationServices>().currentIndex.value = 0;
    } on StorageException catch (e) {
      showCustomSnackBar(
        "Error",
        e.message,
      );
    } catch (e) {
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

}
