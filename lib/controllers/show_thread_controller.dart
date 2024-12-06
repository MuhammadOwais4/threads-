import 'package:demo/models/post_model.dart';
import 'package:demo/models/reply_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';


class ShowThreadController extends GetxController {
  RxBool showThreadLoading = false.obs;
  Rx<PostModel?> post = Rx<PostModel?>(null);
  Rx<List<ReplyModel>> replies = Rx<List<ReplyModel>>([]);

  Future<void> showThread(dynamic postId) async {
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

      replies.value = [
        for (var item in replyResponce)
          ReplyModel.fromJson(
            item,
          )
      ];
    } catch (e) {
      showCustomSnackBar(
        "Error",
        e.toString(),
      );
    } finally {
      showThreadLoading.value = false;
    }
  }
}
