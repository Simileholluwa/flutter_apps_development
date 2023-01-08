import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mx_companion/widgets/big_text.dart';
import 'getJsonData.dart';
import 'models/data_model.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'models/social_model.dart';
import 'models/support_model.dart';

List<IconData> supportIcon = [
  FontAwesomeIcons.whatsapp,
  Icons.call,
  Icons.email,
];

List<String> supportText = [
  '+2347087840509',
  '+2349130698239',
  'Maxoluwatosin@gmail.com'
];

List<IconData> socialIcon = [
  FontAwesomeIcons.whatsapp,
  FontAwesomeIcons.telegram,
];

List<String> socialText = [
  'chat.whatsapp.com',
  't.me/fl9DkTFt2QxiM2U0',
];

List<String> textToCopy = [
  'chat.whatsapp.com/7xfgEmaKMLt1HfJFnuUu8k',
  't.me/fl9DkTFt2QxiM2U0',
];

List<String> copyIconText = [
  'Whatsapp link copied to clipboard',
  'Telegram link copied to clipboard',
];

Future<void> courseAndPracticeInfo(
  BuildContext context,
  String courseName,
  String courseCode,
  String semester,
  String creditUnit,
) {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            scrollable: true,
            backgroundColor: CupertinoColors.darkBackgroundGray,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: BigText(
                      text: 'COURSE DETAILS',
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  Text('Course Code: $courseCode',
                      style: const TextStyle(
                        color: Colors.grey,
                      )),
                  Text(
                    'Course Name: $courseName',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text('Credit Unit: $creditUnit',
                      style: const TextStyle(
                        color: Colors.grey,
                      )),
                  Text(
                    'Semester: $semester',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: BigText(
                      text: 'PRACTICE INSTRUCTIONS',
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.blue.shade800,
                    endIndent: 30,
                    indent: 30,
                  ),
                  const Text(
                    'Each question is timed to last for 45 SECONDS. The system automatically submits if the time for each question elapses and displays the total score after the practice is completed.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(
                        () => GetJsonData(
                            courseCode: courseCode, courseName: courseName),
                        transition: Transition.rightToLeftWithFade,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      width: double.maxFinite,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue.shade800,
                      ),
                      child: const Center(
                        child: BigText(text: 'Tap to Start'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

List<Support> supportList = [
  Support(
    supportText: supportText[0],
    supportIcon: supportIcon[0],
    supportFunction: openWhatsapp,
  ),
  Support(
    supportText: supportText[1],
    supportIcon: supportIcon[1],
    supportFunction: callMe,
  ),
  Support(
    supportText: supportText[2],
    supportIcon: supportIcon[2],
    supportFunction: openEmail,
  ),
];

List<Social> socialList = [
  Social(
    socialText: socialText[0],
    socialIcon: socialIcon[0],
    copyIconText: copyIconText[0],
    textToCopy: textToCopy[0],
  ),
  Social(
    socialText: socialText[1],
    socialIcon: socialIcon[1],
    copyIconText: copyIconText[1],
    textToCopy: textToCopy[1],
  ),
];

List<CourseListModel> courseList = [
  CourseListModel(
      creditUnit: creditUnit[0],
      courseCode: courseCode[0],
      semester: semester[0],
      courseName: courseName[0]),
  CourseListModel(
      creditUnit: creditUnit[1],
      courseCode: courseCode[1],
      semester: semester[1],
      courseName: courseName[1]),
  CourseListModel(
      creditUnit: creditUnit[2],
      courseCode: courseCode[2],
      semester: semester[2],
      courseName: courseName[2]),
  CourseListModel(
      creditUnit: creditUnit[3],
      courseCode: courseCode[3],
      semester: semester[3],
      courseName: courseName[3]),
  CourseListModel(
      creditUnit: creditUnit[4],
      courseCode: courseCode[4],
      semester: semester[4],
      courseName: courseName[4]),
  CourseListModel(
      creditUnit: creditUnit[5],
      courseCode: courseCode[5],
      semester: semester[5],
      courseName: courseName[5]),
  CourseListModel(
      creditUnit: creditUnit[6],
      courseCode: courseCode[6],
      semester: semester[6],
      courseName: courseName[6]),
  CourseListModel(
      creditUnit: creditUnit[7],
      courseCode: courseCode[7],
      semester: semester[7],
      courseName: courseName[7]),
  CourseListModel(
      creditUnit: creditUnit[8],
      courseCode: courseCode[8],
      semester: semester[8],
      courseName: courseName[8]),
  CourseListModel(
      creditUnit: creditUnit[9],
      courseCode: courseCode[9],
      semester: semester[9],
      courseName: courseName[9]),
  CourseListModel(
      creditUnit: creditUnit[10],
      courseCode: courseCode[10],
      semester: semester[10],
      courseName: courseName[10]),
  CourseListModel(
      creditUnit: creditUnit[11],
      courseCode: courseCode[11],
      semester: semester[11],
      courseName: courseName[11]),
  CourseListModel(
      creditUnit: creditUnit[12],
      courseCode: courseCode[12],
      semester: semester[12],
      courseName: courseName[12]),
  CourseListModel(
      creditUnit: creditUnit[13],
      courseCode: courseCode[13],
      semester: semester[13],
      courseName: courseName[13]),
  CourseListModel(
      creditUnit: creditUnit[14],
      courseCode: courseCode[14],
      semester: semester[14],
      courseName: courseName[14]),
  CourseListModel(
      creditUnit: creditUnit[15],
      courseCode: courseCode[15],
      semester: semester[15],
      courseName: courseName[15]),
  CourseListModel(
      creditUnit: creditUnit[16],
      courseCode: courseCode[16],
      semester: semester[16],
      courseName: courseName[16]),
  CourseListModel(
      creditUnit: creditUnit[17],
      courseCode: courseCode[17],
      semester: semester[17],
      courseName: courseName[17]),
];

List courseName = [
  'General Chemistry I',
  'Physical Chemistry',
  'General Chemistry II',
  'Introduction to Computer Science',
  'Introduction to Problem Solving',
  'Nigerian People and Culture',
  'Use of English I and Library',
  'Use of English II',
  'History and Philosophy of Science',
  'Elementary Mathematics I',
  'Elementary Mathematics III (Vectors, Geometry and Dynamics)',
  'Elementary Mathematics II (Calculus)',
  'Experimental Physics I',
  'General Physics I (Mechanics, Thermal Physics and Waves)',
  'General Physics II (Electricity, Magnetism and Modern Physics)',
  'General Physics III',
  'Descriptive Statistics',
  'Probability I',
];

List courseCode = [
  'CHM 111',
  'CHM 112',
  'CHM 121',
  'CPT 111',
  'CPT 121',
  'GST 103',
  'GST 110',
  'GST 121',
  'GST 124',
  'MAT 111',
  'MAT 112',
  'MAT 121',
  'PHY 100',
  'PHY 113',
  'PHY 123',
  'PHY 126',
  'STA 117',
  'STA 127',
];

List creditUnit = [
  '3',
  '2',
  '3',
  '3',
  '3',
  '2',
  '3',
  '2',
  '2',
  '3',
  '3',
  '3',
  '2',
  '3',
  '3',
  '2',
  '4',
  '4',
];

List semester = [
  'First Semester',
  'First Semester',
  'Second Semester',
  'First Semester',
  'Second Semester',
  'First Semester',
  'First Semester',
  'Second Semester',
  'Second Semester',
  'First Semester',
  'First Semester',
  'Second Semester',
  'First Semester',
  'First Semester',
  'Second Semester',
  'First Semester',
  'First Semester',
  'Second Semester',
];

_alert(
  String text,
) {
  const SnackBar(
    backgroundColor: Colors.black,
    content: Text(
      'text',
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Future<void> openFacebook() async {
  String fbProtocolUrl;
  if (Platform.isIOS) {
    fbProtocolUrl = 'fb://profile/100018248824645';
  } else {
    fbProtocolUrl = 'fb://page/100018248824645';
  }
  String fallBackUrl = 'https://www.facebook.com/100018248824645';
  try {
    Uri fbBundleUri = Uri.parse(fbProtocolUrl);
    var canLaunchNatively = await canLaunchUrl(fbBundleUri);
    if (canLaunchNatively) {
      launchUrl(fbBundleUri);
    } else {
      await launchUrl(Uri.parse(fallBackUrl),
          mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    _alert('Facebook application could not be opened.');
  }
}

Future<void> openTelegram() async {
  String telegramPage =
      'https://t.me/fl9DkTFt2QxiM2U0';
  try {
    Uri telegramBundleUri = Uri.parse(telegramPage);
    var canLaunchNatively = await canLaunchUrl(telegramBundleUri);
    if (canLaunchNatively) {
      launchUrl(telegramBundleUri);
    } else {
      await launchUrl(Uri.parse(telegramPage),
          mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    _alert('Could not open twitter.');
  }
}

Future<void> callMe() async {
  // Android
  var uri = Uri.parse('tel:+234 708 784 0509');
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // iOS
      var uri = Uri.parse('tel:070-8784-0509');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  } catch (e) {
    _alert('Phone application could not be opened.');
  }
}

Future<void> textMe() async {
  // Android
  var uri = Uri.parse('smsto:+234 708 784 0509');
  try {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // iOS
      var uri = Uri.parse('smsto:+234-708-784-0509');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  } catch (e) {
    _alert('Messaging application could not be opened.');
  }
}

Future<void> openEmail() async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  try {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'ajanaku.m1703761@st.futminna.edu.ng',
      query: encodeQueryParameters(
          <String, String>{'subject': 'I have an enquiry.'}),
    );
    launchUrl(emailLaunchUri);
  } catch (e) {
    const SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        'text',
        style: TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

Future<void> openWhatsapp() async {
  var whatsappURlAndroid =
      "whatsapp://send?phone=+2347087840509&text=Hi, send us your enquiry, we will be sure to respond as soon as possible.";
  var whatsappURLIos =
      "https://wa.me/+2347087840509?text=${Uri.tryParse('Hi, send us your enquiry, we will be sure to respond as soon as possible.')}";
  try {
    if (Platform.isIOS) {
      await launchUrl(
        Uri.parse(
          whatsappURLIos,
        ),
      );
    } else {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    }
  } catch (e) {
    _alert('Whatsapp is not installed.');
  }
}

Future<void> openWhatsappGroup() async {
  var whatsappURlAndroid =
      "https://chat.whatsapp.com/7xfgEmaKMLt1HfJFnuUu8k";
  var whatsappURLIos =
      "https://chat.whatsapp.com/7xfgEmaKMLt1HfJFnuUu8k";
  try {
    if (Platform.isIOS) {
      await launchUrl(
        Uri.parse(
          whatsappURLIos,
        ),
      );
    } else {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    }
  } catch (e) {
    _alert('Whatsapp is not installed.');
  }
}
