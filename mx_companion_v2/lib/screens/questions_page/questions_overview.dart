import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/questions_controller.dart';
import '../../config/themes/app_dark_theme.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: Scaffold(
        appBar: CustomAppBar(
          title: controller.completedTest,
        ),
        body: Column(
          children: [
            Expanded(
              child: ContentAreaCustom(
                addRadius: true,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 20,),
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
                                  style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontWeight: FontWeight.bold,),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
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
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: UIParameters.mobileScreenPadding,
              child: AppButton(
                onTap: () {
                  controller.submit();
                },
                buttonWidget: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 20,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
