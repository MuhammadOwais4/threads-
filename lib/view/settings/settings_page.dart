import 'package:demo/controllers/settings_controller.dart';
import 'package:demo/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsController controller = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text(
                "Logout",
              ),
              trailing: const Icon(
                Icons.arrow_forward,
              ),
              onTap: () {
                showConfirmationDialog(
                  title: "Are You Sure",
                  message: "This action will logout you from app",
                  callback: controller.logout,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
