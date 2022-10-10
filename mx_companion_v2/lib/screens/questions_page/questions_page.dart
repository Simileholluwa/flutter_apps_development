import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../controllers/questions_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/background_decoration.dart';
import '../../widgets/content_area.dart';

class QuestionsPage extends GetView<QuestionsController> {
  const QuestionsPage({Key? key}) : super(key: key);

    static const String routename = "/questions_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryDark,
      body: BackgroundDecoration(
        child: Obx(() =>
            Column(
              children: [
                if(controller.loadingStatus.value == LoadingStatus.loading)
                   Expanded(
                      child: ContentAreaCustom(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.inkDrop(color: orangeColor, size: 70,),
                              const SizedBox(height: 10,),
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
                      ),
                  ),
                if(controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentAreaCustom(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    controller.currentQuestion.value!.question,
                                  style: const TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
