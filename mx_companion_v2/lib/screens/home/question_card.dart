import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../widgets/AppIconText.dart';

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
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        splashColor: altBackgroundColor,
        borderRadius: UIParameters.cardBorderRadius,
        onTap: (){
          controller.navigateToQuestions(paper: model, tryAgain: false,);
        },
        child: Ink(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: primaryDark,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: standoutBlue.withOpacity(.2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            model.creditUnit!,
                            style: GoogleFonts.jost(
                              color: altTextColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'units',
                            style: GoogleFonts.jost(
                              fontSize: 10,
                              color: altTextColor,
                              fontFeatures: [
                                const FontFeature.subscripts()
                              ],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.courseCode!,
                              style: cardTitles,
                            ),
                            AppIconText(
                              icon: const Icon(
                                Icons.timer,
                                color: orangeColor,
                                size: 17,
                              ),
                              text: Text(
                                model.timeInMinutes(),
                                style: GoogleFonts.lobsterTwo(
                                  fontSize: 17,
                                  color: altTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              model.courseTitle!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lobsterTwo(
                                color: altTextColor,
                                fontSize: 17,
                              ),
                            ),
                            Text(
                              '${model.semester!} semester',
                              style: GoogleFonts.lobsterTwo(
                                fontSize: 17,
                                color:altTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
