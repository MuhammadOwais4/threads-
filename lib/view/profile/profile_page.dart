import 'package:demo/controllers/profile_controller.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/services/supabase_service.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/home/thread_card.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.getCurrentUsersThreads(SupabaseService.currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(
          Icons.language,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(
                RoutesNames.settings,
              );
            },
            icon: const Icon(
              Icons.sort,
            ),
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 160,
                collapsedHeight: 160,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                SupabaseService
                                    .currentUser.value!.userMetadata?["name"],
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: context.width * 0.7,
                                child: Text(SupabaseService.currentUser.value!
                                        .userMetadata?["description"] ??
                                    "developer"),
                              ),
                            ],
                          ),
                          ImageCircle(
                            radius: 40,
                            url: getS5Url(
                              SupabaseService
                                  .currentUser.value!.userMetadata?["image"],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed(
                                  RoutesNames.editProfile,
                                );
                              },
                              child: const Text("Edit profile"),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: const Text("Share profile"),
                            ),
                          ),
                        ],
                      )
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
                        text: "Profile",
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Obx(
            () => TabBarView(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
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
              const Text("I am profile"),
            ]),
          ),
        ),
      ),
    );
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