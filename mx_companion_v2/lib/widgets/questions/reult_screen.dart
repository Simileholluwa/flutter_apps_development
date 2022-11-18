import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/question_paper/result_controller.dart';
import 'package:mx_companion_v2/widgets/questions/questions_answer_card.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/questions_controller.dart';
import '../../screens/questions_page/check_answer.dart';
import '../app_button.dart';
import '../background_decoration.dart';
import '../content_area.dart';
import '../custom_app_bar.dart';
import 'answer_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({Key? key}) : super(key: key);

  static const String routeName = "/resultScreen";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: controller.correctAnsweredQuestions,
          timer: const SizedBox(
            height: 80,
          ),
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
                          height: 25,
                        ),
                        Text(
                          "Tap any question number to view your answers and where you might have been wrong.",
                          textAlign: TextAlign.center,
                          style: smallestJost,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: GridView.builder(
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
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () {
                            controller.saveTestResult();
                          },
                          buttonWidget: Text(
                            'Home',
                            style: cardTitles,
                          ),
                          btnColor: primaryDarkColor1,
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
    );
  }
}
