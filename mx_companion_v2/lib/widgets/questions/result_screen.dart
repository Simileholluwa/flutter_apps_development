import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/question_paper/result_controller.dart';
import 'package:mx_companion_v2/widgets/questions/questions_answer_card.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/questions_controller.dart';
import '../../screens/questions_page/check_answer.dart';
import '../app_button.dart';
import '../content_area.dart';
import '../custom_app_bar.dart';
import 'answer_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String routeName = "/resultScreen";

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: controller.correctAnsweredQuestions,
            timer: const SizedBox(
              height: 80,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ContentAreaCustom(
                  addRadius: true,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/practice_complete.png"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 5,
                          ),
                          child: Text(
                            "Congratulations!",
                            style: bigLobster,
                          ),
                        ),
                        Text(
                          "You have earned ${controller.points} points, keep practicing to earn more!",
                          textAlign: TextAlign.center,
                          style: smallLobster,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Tap any question number to view your answers and where you might have been wrong.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GridView.builder(
                            itemCount: controller.allQuestions.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Get.width ~/ 75,
                              childAspectRatio: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                            itemBuilder: (_, index) {
                              final _question = controller.allQuestions[index];
                              AnswerStatus _status = AnswerStatus.notAnswered;
                              final _selectedAnswer = _question.selectedAnswer;
                              final _correctAnswer = _question.correctAnswer;

                              if (_selectedAnswer == _correctAnswer) {
                                _status = AnswerStatus.correct;
                              } else if (_question.selectedAnswer == null) {
                                _status = AnswerStatus.wrong;
                              } else {
                                _status = AnswerStatus.wrong;
                              }
                              return QuestionAnswerCard(
                                  index: index + 1,
                                  status: _status,
                                  onTap: () {
                                    controller.jumpToQuestion(
                                      index,
                                      goBack: false,
                                    );
                                    Get.toNamed(AnswerCheckScreen.routeName);
                                  });
                            }),

                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        onTap: () {
                          controller.saveTestResult();
                        },
                        buttonWidget: const Text(
                          'Home', style: TextStyle(fontSize: 20,),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
