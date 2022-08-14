import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_course_data.dart';
import 'big_text.dart';

class CourseListWidget extends StatelessWidget {
  final String courseName;
      final String courseCode;
  final String semester;
      final String creditUnit;
  const CourseListWidget({Key? key, required this.courseName, required this.courseCode, required this.semester, required this.creditUnit,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.blue.shade800,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            courseAndPracticeInfo(
              context,
              courseName,
              courseCode,
              semester,
              creditUnit,
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //image container
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CupertinoColors.secondaryLabel,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(text: creditUnit, color: Colors.white, size: 25,),
                      const BigText(
                        text: 'units',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),

              //text container
              Expanded(
                child: Container(
                  height: 80,
                  margin: const EdgeInsets.only(
                    left: 5,
                    right: 10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          courseCode,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          courseName,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          semester,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
