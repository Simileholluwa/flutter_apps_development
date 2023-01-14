import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../config/themes/app_dark_theme.dart';
import '../../config/themes/custom_text.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/text_button_with_icon.dart';
import '../config/themes/ui_parameters.dart';
import '../widgets/AppIconText.dart';
import '../widgets/custom_icon_button.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/history";

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();

    final CollectionReference _userHistory = FirebaseFirestore.instance
        .collection('users')
        .doc(controller.getUser()!.uid)
        .collection('user_tests');

    Future<void> _delete(String historyId) async {
      await _userHistory.doc(historyId).delete();
      _showSnackBar();
    }

    Future<void> _deleteAll() async {
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      final collection = _userHistory;
      var snapShots = await collection.get();
      for (var doc in snapShots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      _showSnackBar();
    }

    return Scaffold(
      body: StreamBuilder(
          stream: _userHistory.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              if (streamSnapshot.data!.docs.isEmpty) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.history_rounded,
                          size: 150,
                          color: altTextColor,
                        ),
                        Text(
                          'Your practice history will appear here when you start practicing.',
                          style: smallestLobster,
                          textAlign: TextAlign.center,
                        ),
                        TextButtonWithIcon(
                          onTap: () {
                            controller.navigateToHome();
                          },
                          text: 'Start',
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SamsungUiScrollEffect(
                  expandedTitle: Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Practice History',
                            style: heading,
                          ),
                          Text(
                            'Swipe left or right to delete any of the items in the history or use the delete Icon to delete all history list.',
                            style: smallestLobster,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                  collapsedTitle: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Text('History', style: appHeading),
                  ),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: CustomIconButton(
                        icon: Icons.delete,
                          size: 30,
                        onPressed: () {
                          controller.showDeleteAllHistory(() {
                            _deleteAll();
                            Get.back();
                          });
                        },
                      ),
                    ),
                  ],
                  expandedHeight: 350,
                  backgroundColor: primaryDarkColor1,
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
                                return const SizedBox(height: 5,);
                              },
                              itemCount: streamSnapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot documentSnapShot =
                                    streamSnapshot.data!.docs[index];
                                return Dismissible(
                                  key: UniqueKey(),
                                  secondaryBackground: Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: maroonColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Delete ${documentSnapShot['question_id']} From History',
                                            textAlign: TextAlign.center,
                                            style: smallJost,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  background: Container(
                                    height: 80,
                                    margin: const EdgeInsets.only(
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: maroonColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Delete ${documentSnapShot['question_id']} From History',
                                            textAlign: TextAlign.center,
                                            style: smallJost,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  onDismissed: (DismissDirection direction) {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      _delete(documentSnapShot.id);
                                    } else {
                                      _delete(documentSnapShot.id);
                                    }
                                    setState(() {
                                      streamSnapshot.data!.docs.removeAt(index);
                                    });
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 10, sigmaY: 10),
                                            child: AlertDialog(
                                              backgroundColor:
                                                  moreTransparent.withAlpha(
                                                50,
                                              ),
                                              title: Text(
                                                'Delete ${documentSnapShot['question_id']}?',
                                                style: GoogleFonts.lobsterTwo(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                  color: textColor,
                                                ),
                                              ),
                                              content: Text(
                                                'Are you sure you want to delete ${documentSnapShot['question_id']} from history list? This action is irreversible.',
                                                style: GoogleFonts.jost(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  height: 1.3,
                                                  color: altTextColor,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: GoogleFonts
                                                          .lobsterTwo(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.grey,
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(true),
                                                  child: Text(
                                                    'Delete',
                                                    style:
                                                        GoogleFonts.lobsterTwo(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: textColor,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
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
                                                width: 130,
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
                                                      documentSnapShot['points'],
                                                      style: appHeading,
                                                    ),
                                                    Text(
                                                      'points',
                                                      style: GoogleFonts.jost(
                                                        fontSize: 10,
                                                        color: textColor,
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        documentSnapShot['question_id'],
                                                        style: cardTitles,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          AppIconText(
                                                            icon: const Icon(
                                                              Icons.timer,
                                                              color: orangeColor,
                                                              size: 17,
                                                            ),
                                                            text: Text(
                                                              '${(documentSnapShot['time_spent'] / 60).toStringAsFixed(2)}min',
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
                                                  Text(
                                                    documentSnapShot['correct_answer_count'],
                                                    style: GoogleFonts.lobsterTwo(
                                                      fontSize: 17,
                                                      color:altTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'MX Companion',
                    style: heading,
                  ),
                  const SizedBox(height: 10),
                  LoadingAnimationWidget.fourRotatingDots(
                      color: altTextColor, size: 80),
                ],
              ),
            );
          }),
    );
  }
}

void _showSnackBar() {
  Get.snackbar(
    'History',
    'History successfully deleted!',
    padding: const EdgeInsets.only(
      left: 25,
    ),
    icon: Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: const Icon(
        Icons.check_circle,
        size: 30,
      ),
    ),
    margin: const EdgeInsets.only(
      left: 25,
      right: 25,
      top: 50,
    ),
    borderRadius: 10,
    snackPosition: SnackPosition.TOP,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: primaryDark,
    duration: const Duration(
      seconds: 2,
    ),
  );
}
