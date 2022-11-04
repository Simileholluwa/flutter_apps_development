import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../widgets/AppIconText.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_button_small.dart';
import '../../widgets/icon_with_name.dart';

class QuestionsCard extends GetView<QuestionPaperController> {
  final QuestionsModel model;
  const QuestionsCard({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: BorderRadius.circular(30),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashFactory: InkRipple.splashFactory,
          splashColor: altBackgroundColor,
          highlightColor: altBackgroundColor,
        ),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.zero,
          child: ExpansionTile(
            tilePadding: EdgeInsets.zero,
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            trailing: const SizedBox(),
            title: Container(
              padding: const EdgeInsets.only(
                left: 25,
                top: 5,
                bottom: 5,
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
                                  style: cardTitles(context),
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
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButtonSmall(
                            onTap: () {  },
                            buttonWidget: const Text(
                              'Course Outline',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: altTextColor,
                              ),
                            ),
                            btnColor: maroonColor.withOpacity(.5),
                            icon: Icons.info_outline,
                          ),
                          AppButtonSmall(
                            onTap: () {
                              controller.navigateToQuestions(paper: model, tryAgain: false,);
                            },
                            buttonWidget: const Text(
                              'Start Practice',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: altTextColor,
                              ),
                            ),
                            btnColor: maroonColor.withOpacity(.5),
                            icon: Icons.send_sharp,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
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
