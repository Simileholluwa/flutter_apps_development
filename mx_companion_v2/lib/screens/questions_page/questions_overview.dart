import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/questions_controller.dart';
import 'package:mx_companion_v2/widgets/background_decoration.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/app_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/questions/answer_card.dart';
import '../../widgets/questions/questions_answer_card.dart';

class QuestionsOverview extends GetView<QuestionsController> {
  const QuestionsOverview({Key? key}) : super(key: key);

  static const String routeName = "/questionsOverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentAreaCustom(
                addRadius: true,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
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
                              Obx(
                                () => Text(
                                  "${controller.time.value} remaining",
                                  style: smallJost,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.allQuestions.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.width ~/ 75,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (_, index) {
                              AnswerStatus? _answerStatus;
                              if (controller
                                      .allQuestions[index].selectedAnswer !=
                                  null) {
                                _answerStatus = AnswerStatus.answered;
                              }
                              return QuestionAnswerCard(
                                addSplash: true,
                                index: index + 1,
                                status: _answerStatus,
                                onTap: () => controller.jumpToQuestion(index),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ColoredBox(
              color: primaryDark,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: AppButton(
                  onTap: () {
                    controller.submit();
                  },
                  buttonWidget: Text(
                    'Submit',
                    style: cardTitles,
                  ),
                  btnColor: primaryDarkColor1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
