import 'package:demo/utils/storage_keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  static final session = GetStorage();

  static dynamic userSession = session.read(StorageKeys.userSession);
}
