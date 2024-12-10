import 'dart:io';

import 'package:demo/widgets/common/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:jiffy/jiffy.dart';

void showCustomSnackBar(String title, String message) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    colorText: Colors.white,
    backgroundColor: const Color(0xff252526),
    padding: const EdgeInsets.all(0.0),
  );
}

void showConfirmationDialog({
  required String title,
  required String message,
  required VoidCallback callback,
}) {
  Get.dialog(
      ConfirmationDialog(title: title, message: message, callback: callback));
}

Future<File?> pickFileFromGallery() async {
  final ImagePicker picker = ImagePicker();
  // Pick an image.
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image == null) return null;
  const uuid = Uuid();
  final dir = Directory.systemTemp;
  final targetPath = "${dir.absolute.path}/${uuid.v6()}.jpg";
  File finalImage = await compressImage(File(image.path), targetPath);
  return finalImage;
}

Future<File> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 70,
  );
  return File(result!.path);
}

String? gets5Url(String? url) {
  if (url != null) {
    return "https://dtwtczjbyoedojzlzoad.supabase.co/storage/v1/s3$url";
  }
  return null;
}


// * formate date
String formateDateFromNow(String date) {
  // Parse UTC timestamp string to DateTime
  DateTime utcDateTime = DateTime.parse(date.split('+')[0].trim());

  // Convert UTC to IST (UTC+5:00 for Pakistan Standard Time)
  DateTime istDateTime = utcDateTime.add(const Duration(hours: 5));

  // Format the DateTime using Jiffy
  return Jiffy.parseFromDateTime(istDateTime).fromNow();
}
