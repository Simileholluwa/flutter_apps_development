import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/home/question_card.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_light_theme.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_icon_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const String routeName = "/mainScreen";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
            UIParameters.isDarkMode() ? primaryDark : primaryLightColor1,
        systemNavigationBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            UIParameters.isDarkMode() ? Brightness.light : Brightness.dark,
        statusBarColor:
            UIParameters.isDarkMode() ? primaryDark : primaryLightColor1,
      ),
    );

    QuestionPaperController questionPaperController = Get.find();
    MyZoomDrawerController controller = Get.find();
    return Scaffold(
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
                      style: GoogleFonts.lobsterTwo(
                        fontSize: 17,
                        color: altTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Tap On Any Course',
                style: GoogleFonts.jost(
                    color: altTextColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        collapsedTitle: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Courses',
            style: GoogleFonts.jost(
                color: textColor, fontSize: 30, fontWeight: FontWeight.bold),
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
                          style: GoogleFonts.lobsterTwo(
                            fontSize: 30,
                            color: altTextColor,
                          ),
                        ),
                        Text(
                          'Ensure you have an active internet connection',
                          style: GoogleFonts.lobsterTwo(
                            fontSize: 15,
                            color: altTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (questionPaperController.loadingStatus.value ==
                    LoadingStatus.completed)
                  ContentAreaCustom(
                    addPadding: false,
                    child: Obx(
                      () => ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        shrinkWrap: true,
                        itemCount: questionPaperController.allPapers.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                            ),
                            child: const Divider(
                              color: primaryDarkColor1,
                              //indent: 25,
                              //endIndent: 25,
                              thickness: 5,
                            ),
                          );
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
    );
  }
}
