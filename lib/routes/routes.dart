import 'package:demo/routes/routes_names.dart';
import 'package:demo/view/auth/login.dart';
import 'package:demo/view/auth/register.dart';
import 'package:demo/view/home.dart';
import 'package:demo/view/profile/edit_profile_page.dart';
import 'package:demo/view/reply/reply_page.dart';
import 'package:demo/view/settings/settings_page.dart';
import 'package:demo/view/show_thread/show_thread.dart';
import 'package:get/get.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RoutesNames.home,
      page: () => const Home(),
    ),
    GetPage(
      name: RoutesNames.login,
      page: () => const Login(),
    ),
    GetPage(
      name: RoutesNames.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: RoutesNames.editProfile,
      page: () => const EditProfilePage(),
    ),
    GetPage(
      name: RoutesNames.settings,
      page: () => const SettingsPage(),
    ),
    GetPage(
      name: RoutesNames.reply,
      page: () => ReplyPage(),
    ),
    GetPage(
      name: RoutesNames.showThread,
      page: () => const ShowThread(),
    ),
  ];
}
