import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../app_course_data.dart';
import '../../widgets/big_text.dart';
import '../../widgets/courseList_design_widget.dart';
import '../search_screen/search_screen.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen( {Key? key,}) : super(key: key);

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SamsungUiScrollEffect(
              expandedTitle: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const BigText(
                      text: 'Choose A Course',
                      size: 40,
                      color: Colors.white,
                    ),
                    Container(
                    margin: const EdgeInsets.only(
                    left: 20,
                      right: 20,
                    ),
                      child: const Text(
                        'Welcome! To start practicing, select a course from the list below.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              collapsedTitle: Container(
                  margin: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: const BigText(text: 'All Courses', size: 24)),
              actions: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 15,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(() => const SearchScreen(),
                      transition: Transition.downToUp,
                        fullscreenDialog: true,
                      );
                    },
                  ),
                ),
              ],
              expandedHeight: 350,
              backgroundColor: Colors.black,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 10,
                  ),
                  child: Column(
                    children: [
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(left: 5, right: 10,),
                              child: const Divider(
                                height: 30,
                                color: CupertinoColors.inactiveGray,
                              ),
                            );
                          },
                          itemCount: courseList.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                CourseListWidget(
                                  courseName: courseName[index],
                                  courseCode: courseCode[index],
                                  semester: semester[index],
                                  creditUnit: creditUnit[index],
                                ),
                              ],
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
