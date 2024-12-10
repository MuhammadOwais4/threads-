import 'package:demo/controllers/search_user_controller.dart';
import 'package:demo/models/user_model.dart';
import 'package:demo/routes/routes_names.dart';
import 'package:demo/utils/helpers.dart';
import 'package:demo/widgets/profile/image_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchUserController controller = Get.put(SearchUserController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                title: const Text(
                  "Search",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                expandedHeight: GetPlatform.isIOS ? 110 : 105,
                collapsedHeight: GetPlatform.isIOS ? 90 : 80,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          controller.searchUsers(value);
                        },
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(
                            0xff242424,
                          ),
                          hintText: "Search User...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (controller.isLaoding.value)
                        const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      else if (!controller.isLaoding.value &&
                          !controller.notFound.value)
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              for (UserModel user in controller.users.value)
                                ListTile(
                                  onTap: () {
                                    Get.toNamed(
                                      RoutesNames.showUserProfile,
                                      arguments: user.id,
                                    );
                                  },
                                  leading: ImageCircle(
                                    url: gets5Url(
                                      user.metadata?.image,
                                    ),
                                  ),
                                  title: Text(
                                    user.metadata!.name!,
                                  ),
                                  subtitle: Text(
                                    user.metadata?.description ?? "",
                                  ),
                                )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
