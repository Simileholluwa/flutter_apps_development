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
    const double customPadding = 10;
    return Container(
      decoration: BoxDecoration(
        borderRadius: UIParameters.cardBorderRadius,
        color: transparentColor,
      ),
      child: InkWell(
        onTap: (){
          controller.navigateToQuestions(paper: model);
        },
        child: Padding(
          padding: const EdgeInsets.all(customPadding),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: altBackgroundColor,
                      child: SizedBox(
                        width: 70,
                        height: 70,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(model.creditUnit!,
                              style: GoogleFonts.jost(
                                //color: altTextColor,
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                              ),
                              ),
                              const SizedBox(width: 5,),
                              Text('units',
                                style: GoogleFonts.jost(
                                  fontSize: 10,
                                  fontFeatures: [const FontFeature.subscripts()],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.courseCode!,
                          style: cardTitles(context),
                        ),
                        const SizedBox(height: 20,),
                        Text(model.courseTitle!,
                          style: GoogleFonts.jost(
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            AppIconText(
                              icon: const Icon(Icons.help_outline_sharp,
                                color: altTextColor,
                                size: 20,
                              ),
                              text: Text('${model.questionCount} questions',
                                style: GoogleFonts.jost(
                                  fontSize: 15,
                                  color: altTextColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            AppIconText(
                              icon: const Icon(Icons.timer,
                                color: altTextColor,
                                size: 20,
                              ),
                              text: Text(model.timeInMinutes(),
                                style: GoogleFonts.jost(
                                  fontSize: 15,
                                  color: altTextColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: -customPadding,
                right: -customPadding,
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20 ),
                    decoration: BoxDecoration(
                      //border: Border.all(width: 2, color: transparentColor,),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(cardBorderRadius),
                        bottomLeft: Radius.circular(cardBorderRadius),
                      ),
                      color: altBackgroundColor,
                    ),
                    child: const Icon(AppIcons.trophyOutLine),
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
