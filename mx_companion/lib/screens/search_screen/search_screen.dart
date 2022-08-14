import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion/screens/tab_view/tab_view.dart';
import '../../app_course_data.dart';
import '../../models/data_model.dart';
import '../../widgets/courseList_design_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<CourseListModel> popularCourse = List.from(courseList);
  void updateList(String value) {
    setState(() {
      popularCourse = courseList
          .where((element) =>
              element.courseCode!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 4,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Container(
          margin: const EdgeInsets.only(
            top: 10,
            bottom: 10,
          ),
          width: double.maxFinite,
          child: TextField(
            cursorColor: Colors.blue.shade800,
            showCursor: true,
            enabled: true,
            autofocus: true,
            onChanged: (value) => updateList(value),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'Jost',
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: CupertinoColors.darkBackgroundGray,
              prefixIcon: IconButton(
                splashRadius: 10,
                onPressed: () {
                  Get.offAll(
                    () => const ScreensTabView(),
                    transition: Transition.leftToRightWithFade,
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: "Search by course code",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontFamily: "Jost",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (popularCourse.isEmpty)
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.search,
                            size: 150,
                            color: Colors.white,
                          ),
                          Text(
                            'No result found. Kindly ensure you search by the Course Code, or send in your suggestions in the support tab.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: popularCourse.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CourseListWidget(
                              courseName: popularCourse[index].courseName!,
                              courseCode: popularCourse[index].courseCode!,
                              semester: popularCourse[index].semester!,
                              creditUnit: popularCourse[index].creditUnit!,
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                            right: 10,
                          ),
                          child: const Divider(
                            height: 30,
                            color: CupertinoColors.inactiveGray,
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
