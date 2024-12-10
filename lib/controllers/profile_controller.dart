import 'dart:convert';

import 'package:demo/models/post_model.dart';
import 'package:demo/models/reply_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';


class ProfileController extends GetxController {

  RxBool isLaoding = false.obs;
  RxBool isRepliesLoading = false.obs;
  RxBool usersLoading = false.obs;
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  Rx<List<ReplyModel>> replies = Rx<List<ReplyModel>>([]);

  Rx<File?> image = Rx<File?>(null);
  String uploadedPath = "";

  void pickImage() async {
    final file = await pickFileFromGallery();
    if (file != null) {
      image.value = file;
    }
  }

  Future<void> updateProfile(String userId, String description) async {
    isLaoding.value = true;
    String dir = "$userId/profile.jpg";
    try {
      if (image.value != null && image.value!.existsSync()) {
        String path =
            await SupabaseService.client.storage.from("threadss5").upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(
                    upsert: true,
                  ),
                );
        uploadedPath = path;
      }

      await SupabaseService.client.auth.updateUser(
        UserAttributes(
          data: {
            "image": uploadedPath.isNotEmpty ? uploadedPath : null,
            "description": description
          },
        ),
      );

      Get.back();
      showCustomSnackBar(
        "Success",
        "Profile Updated Successfully",
      );
    } on StorageException catch (e) {
      showCustomSnackBar(
        "Error",
        e.message,
      );
    } catch (e) {
      print(e.toString());
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      isLaoding.value = false;
    }
  }

  Future<void> getCurrentUsersThreads(String userId) async {
    try {
      usersLoading.value = true;
      final responce = await SupabaseService.client.from("posts").select('''
post_id , content , image , like_count , comment_count , created_at , user_id,
users:user_id (email , metadata)
''').eq("user_id", userId).order(
            "created_at",
            ascending: false,
          );

      if (responce.isNotEmpty) {
        posts.value = [for (var item in responce) PostModel.fromJson(item)];
      }
    } catch (e) {
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      usersLoading.value = false;
    }
  }

  Future<void> getCurrentUserReplies(String userId) async {
    try {
      isRepliesLoading.value = true;
      final responce = await SupabaseService.client.from("replies").select('''
id , post_id , reply ,created_at , user_id,
users:user_id (email , metadata)
''').eq("to_user_id", userId).order(
            "created_at",
            ascending: false,
          );

      if (responce.isNotEmpty) {
        replies.value = [for (var item in responce) ReplyModel.fromJson(item)];
      } else {
        replies.value = [];
      }
    } catch (e) {
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      isRepliesLoading.value = false;
    }
  }
}
