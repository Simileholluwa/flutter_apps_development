import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion_v2/screens/questions_page/questions_overview.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../controllers/questions_controller.dart';
import '../../firebase_ref/loading_status.dart';
import '../../widgets/app_button.dart';
import '../../widgets/content_area.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/questions/answer_card.dart';

class QuestionsPage extends GetView<QuestionsController> {
  const QuestionsPage({Key? key}) : super(key: key);

  static const String routeName = "/questions_page";

  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,
      ),
      child: WillPopScope(
        onWillPop: () async {
          if (DateTime.now().difference(_lastExitTime) >=
              const Duration(seconds: 2)) {
            _showSnackBar();
            _lastExitTime = DateTime.now();
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: CustomAppBar(
            timer: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.timer,
                    color: orangeColor,
                    size: 22,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    controller.time.value,
                    style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                ],
              ),
            ),
            showMenu: true,
            titleWidget: Obx(
              () => Center(
                child: Text(
                  'Question ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                  style: Theme.of(context).textTheme.titleMedium!.merge(const TextStyle(fontWeight: FontWeight.bold,),),
                ),
              ),
            ),
          ),
          body: Obx(
            () => Column(
              children: [
                if (controller.loadingStatus.value == LoadingStatus.loading)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                        right: 20,
                      ),
                      child: ContentAreaCustom(
                        child: SizedBox(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              LoadingAnimationWidget.fourRotatingDots(
                                color: textColor,
                                size: 70,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Loading Database...',
                                style: bigLobster,
                              ),
                              Text(
                                'Ensure you have an active internet connection',
                                style: smallestLobster,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (controller.loadingStatus.value == LoadingStatus.completed)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: ContentAreaCustom(
                        addRadius: true,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 10.0,
                                  right: 10,
                                  left: 10,
                                ),
                                child: Text(
                                  controller.currentQuestion.value!.question,
                                  style: Theme.of(context).textTheme.titleLarge!.merge(const TextStyle(fontWeight: FontWeight.bold,),),
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
                                        final answer = controller
                                            .currentQuestion
                                            .value!
                                            .answers[index];
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
                                      itemCount: controller.currentQuestion
                                          .value!.answers.length,
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    top: 20,
                    left: 30,
                    right: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: controller.loadingStatus.value ==
                            LoadingStatus.completed,
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: AppButton(
                            onTap: () {
                              controller.isLastQuestion
                                  ? Get.toNamed(QuestionsOverview.routeName)
                                  : controller.nextQuestion();
                            },
                            buttonWidget: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 30,
                            ),
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
      ),
    );
  }
}

void _showSnackBar() {
  Get.snackbar(
    'Quit',
    'Press the back button again to quit practice.',
    padding: const EdgeInsets.only(
      left: 25,
    ),
    icon: Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const Icon(
        Icons.info_outline_rounded,
        size: 30,
        color: Colors.white,
      ),
    ),
    margin: const EdgeInsets.only(
      left: 25,
      right: 25,
      top: 20,
    ),
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    duration: const Duration(
      seconds: 2,
    ),
  );
}
