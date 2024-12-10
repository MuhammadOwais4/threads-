import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';
class ReplyController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> addReply(
      String userId, int postId, String postUserId, String reply) async {
    isLoading.value = true;

    try {
      // *Add Comment
      await SupabaseService.client.from("replies").insert({
        "user_id": userId,
        "reply": reply,
        "post_id": postId,
        "to_user_id": postUserId
      });
// Increase the post comment count
      await SupabaseService.client.rpc(
        "comment_increment",
        params: {"count": 1, "row_id": postId},
      );
// *Add Comment Notification
      await SupabaseService.client.from("notifications").insert({
        "user_id": userId,
        "notification": "commented on your post",
        "post_id": postId,
        "to_user_id": postUserId
      });

      Get.back();
      showCustomSnackBar(
        "Success",
        "Reply added successfully!",
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
