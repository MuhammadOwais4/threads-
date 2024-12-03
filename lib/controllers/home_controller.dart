import 'package:demo/models/post_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLaoding = false.obs;
  Rx<List<PostModel>> posts = Rx<List<PostModel>>([]);

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

// *Add Comment Notification
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "liked your post",
        "post_id": postId,
        "to_user_id": postUserId
      });
    } else {
      // await SupabaseService.client.from("likes").delete().eq();

      await SupabaseService.client
          .rpc("like_decrement", params: {"row_id": postId, "count": 1});
    }
  }
}
