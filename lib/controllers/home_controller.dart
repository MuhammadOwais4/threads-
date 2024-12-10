import 'dart:convert';

import 'package:demo/models/post_model.dart';
import 'package:demo/models/reply_model.dart';
import 'package:demo/models/user_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';


class HomeController extends GetxController {
  RxBool isLaoding = false.obs;
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);
  RxBool showThreadLoading = false.obs;
  Rx<PostModel?> post = Rx<PostModel?>(null);
  Rx<List<ReplyModel>> replies = Rx<List<ReplyModel>>([]);

  Rx<UserModel?> userDetails = Rx<UserModel?>(null);
  RxBool isUserDetailsLoading = false.obs;
  Rx<List<PostModel>> userdetailsPosts = Rx<List<PostModel>>([]);

  @override
  void onInit() {
    getThreads();
    super.onInit();
  }

  Future<void> getThreads() async {
    try {
      isLaoding.value = true;
      final responce = await SupabaseService.client.from("posts").select('''
post_id , content , image , like_count , comment_count , created_at , user_id,
users:user_id (email , metadata)
''').order(
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
      isLaoding.value = false;
    }
  }

  Future<void> likePost(
      int postId, String userId, String postUserId, String status) async {
    if (status == "1") {
      await SupabaseService.client.from("likes").insert({
        "post_id": postId,
        "user_id": userId,
      });

      await SupabaseService.client
          .rpc("like_increment", params: {"row_id": postId, "count": 1});

      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "liked your post",
        "post_id": postId,
        "to_user_id": postUserId
      });
    } else {

      await SupabaseService.client
          .rpc("like_decrement", params: {"row_id": postId, "count": 1});
    }
  }

  Future<void> showThread(int postId) async {
    try {
      showThreadLoading.value = true;
      final postResponce = await SupabaseService.client.from("posts").select('''
post_id , content , image , like_count , comment_count , created_at , user_id,
users:user_id (email , metadata)
''').eq("post_id", postId).single();

      post.value = PostModel.fromJson(postResponce);

      final replyResponce =
          await SupabaseService.client.from("replies").select('''
id , created_at , user_id , post_id , reply,
users:user_id (email , metadata)
''').eq("post_id", postId);

      if (replyResponce.isNotEmpty) {
        replies.value = [
          for (var item in replyResponce)
            ReplyModel.fromJson(
              item,
            )
        ];
      } else {
        replies.value = [];
      }
    } catch (e) {
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      showThreadLoading.value = false;
    }
  }

  Future<void> getUserProfileData(String userId) async {
    try {
      isUserDetailsLoading.value = true;
      final userProfileResponce = await SupabaseService.client
          .from("users")
          .select("*")
          .eq("id", userId)
          .single();

      userDetails.value = UserModel.fromJson(userProfileResponce);

      final postDetailsResponce =
          await SupabaseService.client.from("posts").select('''
post_id , content , image , like_count , comment_count , created_at , user_id,
users:user_id (email , metadata)
''').eq("user_id", userId).order(
                "created_at",
                ascending: false,
              );

      if (postDetailsResponce.isNotEmpty) {
        userdetailsPosts.value = [
          for (var item in postDetailsResponce) PostModel.fromJson(item)
        ];
      } else {
        userdetailsPosts.value = [];
      }
    } catch (e) {
      showCustomSnackBar("Error", e.toString());
    } finally {
      isUserDetailsLoading.value = false;
    }
  }

  Future<void> deletePost(int postId) async {
    try {
      await SupabaseService.client.from("posts").delete().eq("post_id", postId);
    } catch (e) {
      showCustomSnackBar("Error", e.toString());
    }
  }
}
