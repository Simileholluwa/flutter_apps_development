import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/app_icon.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/AppIconText.dart';

class QuestionsCard extends GetView<QuestionPaperController> {
  final QuestionsModel model;
  const QuestionsCard({Key? key,
  required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(30),),
            splashFactory: InkRipple.splashFactory,
            splashColor: standoutBlue,
            highlightColor: standoutBlue,
            hoverColor: standoutBlue,
            onTap: (){
              controller.navigateToQuestions(paper: model);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20,),
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10),),
                            color: standoutBlue.withOpacity(.2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(model.creditUnit!,
                              style: GoogleFonts.jost(
                                color: altTextColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                              ),
                              Text('units',
                                style: GoogleFonts.jost(
                                  fontSize: 10,
                                  color: altTextColor,
                                  fontFeatures: [const FontFeature.subscripts()],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 15,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(model.courseCode!,
                              style: cardTitles(context),
                            ),
                            const SizedBox(height: 5,),
                            Text(model.courseTitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lobsterTwo(
                                color: altTextColor,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text("${model.semester!} semester",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lobsterTwo(
                                  color: altTextColor,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Row(
                              children: [
                                AppIconText(
                                  icon: const Icon(Icons.help_outline_sharp,
                                    color: orangeColor,
                                    size: 17,
                                  ),
                                  text: Text('${model.questionCount} questions',
                                    style: GoogleFonts.lobsterTwo(
                                      fontSize: 17,
                                      color: altTextColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                AppIconText(
                                  icon: const Icon(Icons.timer,
                                    color: orangeColor,
                                    size: 17,
                                  ),
                                  text: Text(model.timeInMinutes(),
                                    style: GoogleFonts.lobsterTwo(
                                      fontSize: 17,
                                      color: altTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: (){},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(cardBorderRadius),
                  bottomLeft: Radius.circular(cardBorderRadius),
                ),
                color: standoutBlue.withOpacity(.2),
              ),
              child: const Icon(AppIcons.trophyOutLine, color: textColor,),
            ),
          ),
        ),
      ],
    );
  }
}
