import 'package:demo/controllers/notifications_controller.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/navigation_services.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final NotificationsController controller = Get.put(NotificationsController());

  @override
  void initState() {
    controller.getNotifications(SupabaseService.currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        leading: IconButton(
          onPressed: () {
            Get.find<NavigationServices>().backtoPrev();
          },
          icon: const Icon(
            Icons.cancel,
          ),
        ),
      ),
      body: Obx(
        () => Expanded(
          child: controller.isLaoding.value
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.notifications.value.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications.value[index];
                    return ListTile(
                      isThreeLine: true,
                      titleAlignment: ListTileTitleAlignment.top,
                      onTap: () {
                        Get.toNamed(RoutesNames.showThread,
                            arguments:
                                controller.notifications.value[index].postId);
                      },
                      leading: ImageCircle(
                        url: gets5Url(
                          notification.users!.metadata!.image,
                        ),
                      ),
                      title: Text(
                        notification.users!.metadata!.name!,
                      ),
                      subtitle: Text(
                        notification.notification!,
                      ),
                      trailing: Text(
                        formateDateFromNow(
                          notification.createdAt!,
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
