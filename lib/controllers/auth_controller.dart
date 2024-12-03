
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/storage_service.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  var registerLoading = false.obs;
  var loginLoading = false.obs;
  Future<void> register(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      final AuthResponse response = await SupabaseService.client.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });
      if (response.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(RoutesNames.home);
      }
    } on AuthException catch (e) {
      showCustomSnackBar("Error", e.message);
    } finally {
      registerLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      loginLoading.value = true;
      AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(password: password, email: email);

      if (response.user != null) {
        StorageService.session
            .write(StorageKeys.userSession, response.user!.toJson());
        Get.offAllNamed(RoutesNames.home);
      }
    } on AuthException catch (e) {
      showCustomSnackBar("Error", e.message);
    } finally {
      loginLoading.value = false;
    }
  }
}
