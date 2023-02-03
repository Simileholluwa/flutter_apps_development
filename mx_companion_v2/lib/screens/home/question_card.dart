import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';
import '../../config/themes/ui_parameters.dart';

class QuestionsCard extends GetView<QuestionPaperController> {
  final QuestionsModel model;
  final bool isSelected;
  const QuestionsCard({
    Key? key,
    required this.model,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Get.find();
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: (){
          auth.showPracticeInfo(() {
            controller.navigateToQuestions(paper: model, tryAgain: false,);
          },
            'Course title: ${model.courseTitle}\nSemester: ${model.semester}\nTime: ${model.timeInMinutes()}\nThe system automatically submits when the time elapses. Kindly ensure to click the \'Home\' button on the result screen.'
          );
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: UIParameters.cardBorderRadius,
                  color: Theme.of(context).canvasColor,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        model.creditUnit!,
                        style: Theme.of(context).textTheme.titleLarge!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                      Text(
                        'units',
                        style: Theme.of(context).textTheme.labelSmall,
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
                child: VerticalDivider(
                  width: 30,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.courseCode!,
                      style: Theme.of(context).textTheme.titleLarge!.merge(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    SizedBox(
                      width: 250,
                      child: Text(
                        model.courseTitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1!.merge( TextStyle(color: Theme.of(context).hintColor),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
