import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/storage_service.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/storage_keys.dart';
import 'package:get/get.dart';


class SettingsController extends GetxController {
  void logout() {
    StorageService.session.remove(StorageKeys.userSession);
    SupabaseService.client.auth.signOut();
    Get.offAllNamed(RoutesNames.login);
  }
}
