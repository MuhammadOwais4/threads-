import 'package:demo/controllers/home_controller.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/home/thread_card.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ShowUserProfile extends StatefulWidget {
  const ShowUserProfile({super.key});

  @override
  State<ShowUserProfile> createState() => _ShowUserProfileState();
}

class _ShowUserProfileState extends State<ShowUserProfile> {
  final HomeController controller = Get.find<HomeController>();

  @override
  void initState() {
    controller.getUserProfileData(Get.arguments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile Preview"),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isUserDetailsLoading.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 100,
                        collapsedHeight: 100,
                        automaticallyImplyLeading: false,
                        flexibleSpace: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller
                                            .userDetails.value!.metadata!.name!,
                                        style: const TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: context.width * 0.7,
                                        child: Text(
                                          controller.userDetails.value!.metadata
                                                  ?.description ??
                                              "",
                                        ),
                                      ),
                                    ],
                                  ),
                                  ImageCircle(
                                    radius: 40,
                                    url: gets5Url(
                                      controller
                                          .userDetails.value!.metadata!.image,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SliverPersistentHeader(
                        delegate: SliverHeaderDelegate(
                          TabBar(
                            tabs: [
                              Tab(
                                text: "Thraeds",
                              ),
                              Tab(
                                text: "Replies",
                              )
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: controller.userdetailsPosts.value.isNotEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount:
                                    controller.userdetailsPosts.value.length,
                                itemBuilder: (context, index) {
                                  return ThreadCard(
                                    post: controller
                                        .userdetailsPosts.value[index],
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No posts found for this profile"),
                              ),
                      ),
                    ),
                    const Text("I am profile"),
                  ]),
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  const SliverHeaderDelegate(this._tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
