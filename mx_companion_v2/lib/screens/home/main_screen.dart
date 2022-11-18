import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/home/question_card.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/custom_icon_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
        systemNavigationBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarColor:
            UIParameters.isDarkMode() ? primaryDarkColor1 : primaryLightColor1,
      ),
    );
    DateTime _lastExitTime = DateTime.now();
    QuestionPaperController questionPaperController = Get.find();
    MyZoomDrawerController controller = Get.find();
    return WillPopScope(
      onWillPop: () async {
        if (DateTime.now().difference(_lastExitTime) >= Duration(seconds: 2)) {
          _showSnackBar();
          _lastExitTime = DateTime.now();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: primaryDarkColor1,
        body: SamsungUiScrollEffect(
          toolbarHeight: 70,
          expandedTitle: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.waving_hand,
                        size: 15,
                        color: orangeColor,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        controller.user.value == null
                            ? 'Hello there, to start practicing,'
                            : 'Hello ${controller.user.value!.displayName}, to start practicing,',
                        style: smallLobster,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Tap On Any Course',
                  style: heading,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          collapsedTitle: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Text(
              'Courses',
              style: appHeading,
              textAlign: TextAlign.center,
            ),
          ),
          expandedHeight: 350,
          backgroundColor: primaryDarkColor1,
          actions: [
            CustomIconButton(
              onPressed: () {},
              icon: Icons.search,
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 15,
              ),
              child: CustomIconButton(
                onPressed: () {
                  controller.menu();
                },
                icon: Icons.apps_sharp,
              ),
            ),
          ],
          children: [
            Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (questionPaperController.loadingStatus.value ==
                      LoadingStatus.loading)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          LoadingAnimationWidget.inkDrop(
                            color: orangeColor,
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
                            style: smallLobster,
                          ),
                        ],
                      ),
                    ),
                  if (questionPaperController.loadingStatus.value ==
                      LoadingStatus.completed)
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, left: 15.0, bottom: 5,),
                      child: Obx(
                        () => ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: questionPaperController.allPapers.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 5,);
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: QuestionsCard(
                                model: questionPaperController.allPapers[index],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _showSnackBar() {
  Get.snackbar(
    'Exit',
    'Press the back button again to exit app.',
    padding: const EdgeInsets.only(left: 25,),
    icon: Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.only(right: 10,),
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        borderRadius: const BorderRadius.all(Radius.circular(10),),
      ),
      child: const Icon(Icons.info_outline_rounded, size: 30,),
    ),
    margin: const EdgeInsets.only(left: 25, right: 25, top: 50,),
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: primaryDark,
    duration: const Duration(seconds: 2,),
  );
}