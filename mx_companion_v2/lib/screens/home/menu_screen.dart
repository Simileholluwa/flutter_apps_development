import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import '../../widgets/content_area.dart';
import '../../widgets/icon_and_text.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  static const String routeName = "/menu";

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    MyZoomDrawerController controller = Get.find();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 15, bottom: 5,),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Obx(
              () => Column(
            children: [
              Expanded(
                child: ContentAreaCustom(
                  addPadding: false,
                  addRadius: true,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15,),
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/man.png"),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            controller.user.value != null ? IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.edit, size: 30,),
                            ) : Container(),
                            controller.user.value != null ? IconButton(
                              onPressed: (){},
                              icon: const Icon(Icons.camera_alt, size: 30,),
                            ): Container(),
                            IconButton(
                              onPressed: (){
                                controller.user.value == null ? controller.signIn() : controller.signOut();
                              },
                              icon: Icon(controller.user.value == null ? Icons.login : Icons.logout, size: 30,),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          thickness: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        controller.user.value == null
                            ? Container()
                            : IconAndText(
                          onTap: () {},
                          text: 'Practice History',
                          image: const AssetImage(
                              "assets/images/bomb.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'FAQs',
                          image:
                          const AssetImage("assets/images/questions.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'Feedback',
                          image: const AssetImage(
                              "assets/images/testimonials.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'Social Groups',
                          image: const AssetImage(
                              "assets/images/connection.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'Notifications',
                          image: const AssetImage(
                              "assets/images/newsletter.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'Share App',
                          image: const AssetImage("assets/images/share.png"),
                        ),
                        IconAndText(
                          onTap: () {},
                          text: 'About Us',
                          image:
                          const AssetImage("assets/images/comment.png"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text('Contact Us'),
                ),
              ),
              Divider(
                height: 5,
                thickness: 3,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: (){
                      controller.openEmail();
                    },
                    icon: const Icon(Icons.mail, size: 30,),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.telegram, size: 30,),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.whatsapp, size: 30,),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.facebook, size: 30,),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}