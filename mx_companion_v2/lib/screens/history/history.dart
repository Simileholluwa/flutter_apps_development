import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../config/themes/custom_text.dart';
import '../../config/themes/ui_parameters.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/content_area.dart';
import '../../widgets/text_button_with_icon.dart';

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
      controller.showSnackBar('History successfully deleted', icon: Icons.check_circle, containerColor: Colors.green,);
    }

    Future<void> _deleteAll() async {
      final WriteBatch batch = FirebaseFirestore.instance.batch();
      final collection = _userHistory;
      var snapShots = await collection.get();
      for (var doc in snapShots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
      controller.showSnackBar('History successfully deleted', icon: Icons.check_circle, containerColor: Colors.green,);
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: FlexColorScheme.themedSystemNavigationBar(
        context,
        systemNavBarStyle: FlexSystemNavBarStyle.scaffoldBackground,
        useDivider: false,
        opacity: 1,),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          leading:
          Container(
            margin: const EdgeInsets.only(
              left: 15,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined, size: 30,),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          title: Text(
            'History',
            style: Theme.of(context).textTheme.titleLarge!.merge(
              const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: const Icon(Icons.delete, size: 30,),
                onPressed: () {
                  controller.showDeleteAllHistory(() {
                    _deleteAll();
                    Get.back();
                  });
                },
              ),
            ),
          ],
        ),
        body: StreamBuilder(
            stream: _userHistory.orderBy('created', descending: true,).snapshots(),
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
                  return Column(
                    children: [
                      Flexible(
                        child: Padding(
                          padding:
                          const EdgeInsets.only(left: 10, right: 10),
                          child: ContentAreaCustom(
                            addRadius: true,
                            addColor: true,
                            addPadding: false,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ListView.separated(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      separatorBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return Divider(
                                          height: 5,
                                          thickness: 3,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        );
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
                                              borderRadius: UIParameters.cardBorderRadius,
                                              //color: maroonColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: const [
                                                  Icon(
                                                    Icons.delete,
                                                    //color: Colors.white,
                                                    size: 30,
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
                                              borderRadius: UIParameters.cardBorderRadius,
                                              //color: maroonColor,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: const [
                                                  Icon(
                                                    Icons.delete,
                                                    //color: Colors.white,
                                                    size: 30,
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
                                              (DismissDirection direction) {
                                            return controller.showDeleteHistory(() {
                                              Navigator.of(context)
                                                  .pop(true);
                                            }, 'Delete ${documentSnapShot['question_id']}?', 'Are you sure you want to delete ${documentSnapShot['question_id']} from history list? This action is irreversible.',);
                                          },
                                          child: Ink(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 20,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              UIParameters.cardBorderRadius,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                  Container(
                                                    padding: const EdgeInsets.only(
                                                        right: 10,
                                                      left: 10,
                                                    ),
                                                        width: 100,
                                                        height: 80,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                          const BorderRadius.all(
                                                            Radius.circular(10),
                                                          ),
                                                          color: Theme.of(context).highlightColor
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              documentSnapShot[
                                                              'points'],
                                                              style: Theme.of(context).textTheme.titleLarge!.merge(
                                                                const TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 30,
                                                                ),
                                                              ),
                                                            ),
                                                            Text(
                                                              'points',
                                                              style: Theme.of(context).textTheme.labelSmall,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 60,
                                                      child: VerticalDivider(
                                                        width: 30,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Text(
                                                                documentSnapShot[
                                                                'question_id'],
                                                                style: Theme.of(context).textTheme.titleLarge!.merge(
                                                                  const TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize: 18,
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(height: 2,),
                                                              Text(
                                                                documentSnapShot[
                                                                'created'].toDate()
                                                                    .toString()
                                                                    .substring(0, 16),
                                                                style: Theme.of(context).textTheme.subtitle1!.merge( TextStyle(color: Theme.of(context).hintColor),
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
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ),
                        ),
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
                    LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.blue,
                      size: 70,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Loading Database...',
                      style: bigLobster,
                    ),
                    Text(
                      'Ensure you have an active internet connection',
                      style: smallestLobster,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}


