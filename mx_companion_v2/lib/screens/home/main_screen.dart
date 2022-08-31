import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/zoom_drawer.dart';
import 'package:mx_companion_v2/screens/home/question_card.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_icon.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/question_paper/question_paper_controller.dart';
import '../../widgets/content_area.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionPaperController questionPaperController = Get.find();
    MyZoomDrawerController controller = Get.find();
    return Container(
      decoration: BoxDecoration(color: primaryDarkColor1),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(mobileScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        splashColor: altBackgroundColor,
                        onTap: controller.menu,
                        child: Icon(
                          AppIcons.menuLeft,
                          color: textColor,
                          size: 25,
                        ),
                      ),
                      InkWell(
                        splashFactory: InkRipple.splashFactory,
                        splashColor: altBackgroundColor,
                        onTap: (){},
                        child: Icon(
                          Icons.search,
                          color: textColor,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.waving_hand_sharp,
                        color: orangeColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Obx(
                        () => Text(
                          controller.user.value == null
                              ? 'Hello there!'
                              : 'Hello, ${controller.user.value!.displayName}!',
                          style: GoogleFonts.lobsterTwo(
                            fontSize: 17,
                            color: altTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Choose your preferred course to begin your practice journey.',
                    style: GoogleFonts.jost(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  right: 25,
                  top: 20,
                  bottom: 20,
                ),
                child: ContentAreaCustom(
                  addPadding: false,
                  child: Obx(
                    () => ListView.builder(
                      //padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
