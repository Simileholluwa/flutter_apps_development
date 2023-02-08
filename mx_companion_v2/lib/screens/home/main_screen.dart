import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/home/question_card.dart';
import '../../config/themes/custom_text.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/AppIconText.dart';
import '../../widgets/content_area.dart';

class MainScreen extends GetView<MyZoomDrawerController> {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {

    AuthController auth = Get.find();

    DateTime _lastExitTime = DateTime.now();
    QuestionPaperController questionPaperController = Get.find();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(_lastExitTime) >=
              const Duration(seconds: 2)) {
            auth.showSnackBar('Press the back button again to exit app.',);
            _lastExitTime = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              scrolledUnderElevation: 0,
            ),
            body: SafeArea(
              child: Obx(
                    () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  controller.toggleZoomDrawer();
                                },
                                icon: const Icon(
                                  Icons.apps,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            bottom: 20,
                          ),
                          child: AppIconText(
                            icon: const Icon(
                              Icons.waving_hand,
                              color: Color(0xffeea346),
                              size: 15,
                            ),
                            text: Text(
                                controller.user.value == null
                                ? 'Hello there'
                                : 'Hello ${controller.user.value!.displayName}',
                            style: smallestLobster,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 30.0,
                            right: 20,
                            bottom: 20,
                          ),
                          child: Text(
                            'What would you like to practice?',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .merge(
                              const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (questionPaperController.loadingStatus.value ==
                        LoadingStatus.loading)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20.0,
                            right: 20,
                            bottom: 20,
                          ),
                          child: ContentAreaCustom(
                            addRadius: true,
                            addColor: true,
                            child: SizedBox(
                              height: double.maxFinite,
                              width: double.maxFinite,
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.blue,
                                    size: 70,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Loading Database...',
                                    style: bigLobster,
                                  ),
                                  Text(
                                    'Ensure you have an active internet connection',
                                    style: smallestLobster,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (questionPaperController.loadingStatus.value ==
                        LoadingStatus.completed)
                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10),
                          child: ContentAreaCustom(
                            addRadius: true,
                            addColor: true,
                            addPadding: false,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Obx(
                                        () => ListView.separated(
                                      physics:
                                      const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: questionPaperController
                                          .allPapers.length,
                                      separatorBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return Divider(
                                          height: 5,
                                          thickness: 3,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        );
                                      },
                                      itemBuilder: (BuildContext context,
                                          int index) {
                                        return Center(
                                          child: QuestionsCard(
                                            model: questionPaperController
                                                .allPapers[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
        ),
      ),
    );
  }
}

