import 'package:demo/models/notification_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';


class NotificationsController extends GetxController {
  RxBool isLaoding = false.obs;
  Rx<List<NotificationModel>> notifications = Rx<List<NotificationModel>>([]);

  Future<void> getNotifications(String userId) async {
    try {
      isLaoding.value = true;
      final responce =
          await SupabaseService.client.from("notifications").select('''
post_id , notification, user_id, created_at
users:user_id (email , metadata)
''').eq("to_user_id", userId).order(
                "created_at",
                ascending: false,
              );

      if (responce.isNotEmpty) {
        notifications.value = [
          for (var item in responce) NotificationModel.fromJson(item)
        ];
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
}
