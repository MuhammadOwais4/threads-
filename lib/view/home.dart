import 'package:demo/services/navigation_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NavigationServices navigationServices = Get.put(NavigationServices());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            navigationServices.updateState(value);
          },
          selectedIndex: navigationServices.currentIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: "Home",
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.search_outlined),
              label: "Search",
              selectedIcon: Icon(Icons.search),
            ),
            NavigationDestination(
              icon: Icon(Icons.add_outlined),
              label: "Add Thread",
              selectedIcon: Icon(Icons.add),
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              label: "Notifications",
              selectedIcon: Icon(Icons.favorite),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: "Profile",
              selectedIcon: Icon(Icons.person),
            ),
          ],
        ),
        body: AnimatedSwitcher(
          duration: const Duration(microseconds: 500),
          switchInCurve: Curves.ease,
          switchOutCurve: Curves.ease,
          child:
              navigationServices.pages[navigationServices.currentIndex.value],
        ),
      ),
    );
  }
}
