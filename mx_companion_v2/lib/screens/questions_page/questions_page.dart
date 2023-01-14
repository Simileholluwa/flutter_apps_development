import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/config/themes/ui_parameters.dart';
import 'package:mx_companion_v2/screens/questions_page/questions_overview.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../controllers/questions_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/app_button.dart';
import '../../widgets/background_decoration.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/questions/answer_card.dart';

class QuestionsPage extends GetView<QuestionsController> {
  const QuestionsPage({Key? key}) : super(key: key);

  static const String routeName = "/questions_page";

  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
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
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          timer: Container(
            width: 100,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: const ShapeDecoration(
              shape: StadiumBorder(
                side: BorderSide(
                  color: textColor,
                  width: 2,
                ),
              ),
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer,
                    color: orangeColor,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.time.value,
                    style: smallJost,
                  ),
                ],
              ),
            ),
          ),
          showMenu: true,
          titleWidget: Obx(
            () => Center(
              child: Text(
                'Question ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: smallJost,
              ),
            ),
          ),
        ),
        body: BackgroundDecoration(
          child: Obx(
            () => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  Expanded(
                    child: ContentAreaCustom(
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                    ),
                  ),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: ContentAreaCustom(
                      addRadius: true,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          top: 25,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.currentQuestion.value!.question,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            GetBuilder<QuestionsController>(
                                id: 'answers_list',
                                builder: (context) {
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                      right: 10,
                                    ),
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers[index];
                                      return AnswerCard(
                                        answer:
                                            '${answer.identifier}. ${answer.answer}',
                                        onTap: () {
                                          controller.selectedAnswer(
                                              answer.identifier);
                                        },
                                        isSelected: answer.identifier ==
                                            controller.currentQuestion.value!
                                                .selectedAnswer,
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const SizedBox(
                                      height: 10,
                                    ),
                                    itemCount: controller
                                        .currentQuestion.value!.answers.length,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ColoredBox(
                  color: primaryDark,
                  child: Padding(
                    padding: UIParameters.mobileScreenPadding,
                    child: Row(
                      children: [
                        Visibility(
                          visible: controller.isFirstQuestion,
                          child: SizedBox(
                            width: 70,
                            height: 70,
                            child: AppButton(
                              onTap: () {
                                controller.prevQuestion();
                              },
                              buttonWidget: const Icon(
                                Icons.arrow_back_ios_new,
                                color: altTextColor,
                                size: 30,
                              ),
                              btnColor: primaryDarkColor1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: controller.loadingStatus.value ==
                              LoadingStatus.completed,
                          child: Expanded(
                            child: AppButton(
                              onTap: () {
                                controller.isLastQuestion
                                    ? Get.toNamed(QuestionsOverview.routeName)
                                    : controller.nextQuestion();
                              },
                              buttonWidget: Text(
                                controller.isLastQuestion ? 'Continue' : 'Next',
                                style: cardTitles,
                              ),
                              btnColor: primaryDarkColor1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showSnackBar() {
  Get.snackbar(
    'Quit',
    'Press the back button again to quit practice.',
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