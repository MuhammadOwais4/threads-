import 'dart:async';

import 'package:demo/models/user_model.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController {
  RxBool isLaoding = false.obs;
  RxBool notFound = false.obs;

  Rx<List<UserModel>> users = Rx<List<UserModel>>([]);

  Timer? _debounce;

  Future<void> searchUsers(String name) async {
    if (name.isNotEmpty) {
      try {
        isLaoding.value = true;
        notFound.value = false;

        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(
          const Duration(milliseconds: 500),
          () async {
            final responce =
                await SupabaseService.client.from("users").select("*").like(
                      "metadata->>name",
                      "%$name%",
                    );

            if (responce.isNotEmpty) {
              notFound.value = false;
              users.value = [
                for (var item in responce) UserModel.fromJson(item)
              ];
            }else{
              notFound.value = true;
              users.value = [];
            }
          },
        );
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
}
