import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      decoration: const BoxDecoration(
          color: transparentColor
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(mobileScreenPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap:  controller.toggleDrawer,
                    child: const Icon(AppIcons.menuLeft,
                      color: altTextColor,
                      size: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5,),
                      Text('Hello username',
                        style: GoogleFonts.jost(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Choose your preferred course to begin your practice journey.',
                    style: GoogleFonts.jost(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20,),
                child: ContentAreaCustom(
                  addPadding: false,
                  child: Obx(
                        () => ListView.separated(
                      padding: UIParameters.mobileScreenPadding,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: QuestionsCard(
                            model: questionPaperController.allPapers[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20,);
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
