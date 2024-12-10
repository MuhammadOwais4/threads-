import 'package:demo/controllers/home_controller.dart';
import 'package:demo/widgets/home/thread_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: controller.isLaoding.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : RefreshIndicator(
              onRefresh: () => controller.getThreads(),
              child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: Image.asset(
                        "../images/logo.png",
                        height: 50,
                      ),
                      centerTitle: true,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: controller.posts.value.length,
                            itemBuilder: (context, index) {
                              return ThreadCard(
                                post: controller.posts.value[index],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ),
      ),
    ));
  }
}
