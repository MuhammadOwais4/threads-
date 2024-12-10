import 'package:demo/routes/routes.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/storage_service.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await dotenv.load(fileName: ".env");
  Get.put(SupabaseService());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Threads",
      theme: theme,
      getPages: Routes.pages,
      initialRoute: StorageService.userSession != null
          ? RoutesNames.home
          : RoutesNames.login,
    );
  }
}
