import 'package:demo/controllers/profile_controller.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController textEditingController = TextEditingController();
  final ProfileController controller = Get.find<ProfileController>();

  @override
  void initState() {
    if (SupabaseService.currentUser.value!.userMetadata?["description"] !=
        null) {
      textEditingController.text =
          SupabaseService.currentUser.value!.userMetadata?["description"];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                if (!controller.isLaoding.value) {
                  controller.updateProfile(
                    SupabaseService.currentUser.value!.id,
                    textEditingController.text,
                  );
                }
              },
              child: controller.isLaoding.value
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(
                      "Done",
                    ),
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ImageCircle(
                      radius: 80,
                      url: gets5Url(SupabaseService
                          .currentUser.value!.userMetadata?["image"]),
                      file: controller.image.value,
                    ),
                    IconButton(
                      onPressed: () {
                        controller.pickImage();
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    label: Text(
                      "Type Profile Description",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
