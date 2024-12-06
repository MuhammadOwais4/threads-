import 'package:demo/view/home/home_page.dart';
import 'package:demo/view/notifications/notifications_page.dart';
import 'package:demo/view/profile/profile_page.dart';
import 'package:demo/view/search/search_page.dart';
import 'package:demo/view/threads/add_threads_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class NavigationServices extends GetxService {
  var currentIndex = 0.obs;
  var previousIndex = 0.obs;

  List<Widget> pages = const [
    HomePage(),
    SearchPage(),
    AddThreadsPage(),
    NotificationsPage(),
    ProfilePage()
  ];

  void updateState(value) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = value;
  }

  void backtoPrev() {
    currentIndex.value = previousIndex.value;
  }
}
