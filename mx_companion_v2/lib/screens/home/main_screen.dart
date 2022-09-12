import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/home/question_card.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_icon_button.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      controller.user.value == null
                          ? 'Hello there, to start practicing,'
                          : 'Hello, ${controller.user.value!.displayName}, to start practicing,',
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
                  fontWeight: FontWeight.bold
                ),
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
              color: textColor,
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
        ),
        expandedHeight: 350,
        backgroundColor: primaryDarkColor1,
        actions: [
          controller.user.value == null? CustomIconButton(
            onPressed: () {
              controller.signIn();
            },
            icon: FontAwesomeIcons.arrowRightToBracket,
            size: 24,
          ) : CustomIconButton(
            onPressed: () {
              controller.signOut();
            },
            icon: FontAwesomeIcons.arrowRightFromBracket,
            size: 24,
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 15,
            ),
            child: CustomIconButton(
              onPressed: () {},
              icon: Icons.search,
            ),
          ),
        ],
        children: [
          ContentAreaCustom(
            addPadding: false,
            child: Obx(
              () => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 20, bottom: 20,),
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 5, right: 10,),
                    child: const Divider(
                      height: 30,
                      color: textColor,
                      indent: 98,
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
                itemCount: questionPaperController.allPapers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
