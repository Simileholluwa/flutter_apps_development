import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/widgets/alert_widget.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../Services/Authentication/initial_screen_controller.dart';
import '../../app_course_data.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../update_details/update_details.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final CollectionReference _userDetails = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthController().getCurrentUID())
      .collection('userDetails');

  Widget customWidget(
    supportIcon,
    supportText,
    supportFunction,
  ) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(10),
        onTap: supportFunction,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    Icon(
                      supportIcon,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            //text container
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          SmallText(
                            text: supportText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customWidgetUser(detailIcon, text) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    Icon(
                      detailIcon,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            //text container
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 20,
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          SmallText(
                            text: text,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customWidgetSocial(detailIcon, text, copyIconText, textToCopy) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue.shade800,
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    Icon(
                      detailIcon,
                      size: 35,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),

            //text container
            Expanded(
              child: SizedBox(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(
                                text: text,
                                overFlow: TextOverflow.ellipsis,
                              ),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                          ClipboardData(text: textToCopy))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.black,
                                        content: SmallText(
                                          text: copyIconText,
                                          color: Colors.white,
                                          align: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: StreamBuilder(
          stream: _userDetails.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return SamsungUiScrollEffect(
                expandedTitle: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 120,
                              backgroundColor: Colors.white.withAlpha(30),
                              child: ClipOval(
                                child: SizedBox(
                                  height: 220,
                                  width: 220,
                                  child: Image.network(
                                    '${streamSnapshot.data!.docs[0]['url']}',
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: LoadingAnimationWidget
                                            .fourRotatingDots(
                                                color: Colors.white, size: 80),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        CupertinoIcons.person_alt_circle,
                                        size: 220,
                                        color: Colors.white,
                                      );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                collapsedTitle: Row(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white.withAlpha(30),
                        child: ClipOval(
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: Image.network(
                              '${streamSnapshot.data!.docs[0]['url']}',
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Center(
                                  child:
                                      LoadingAnimationWidget.fourRotatingDots(
                                          color: Colors.white, size: 20),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  CupertinoIcons.person_alt_circle,
                                  size: 40,
                                  color: Colors.white,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const BigText(text: 'Profile', size: 24),
                  ],
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.mode_edit_sharp,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.to(
                        () => const UpdateDetailsScreen(),
                        transition: Transition.downToUp,
                        fullscreenDialog: true,
                      );
                      //_update(streamSnapshot.data!.docs[0]);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.email,
                      size: 30,
                    ),
                    onPressed: () {
                      openEmail();
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        size: 24,
                      ),
                      onPressed: () {
                        logoutInfo(
                          context,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
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
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapShot =
                                  streamSnapshot.data!.docs[index];
                              return Column(
                                children: [
                                  customWidgetUser(
                                    Icons.person,
                                    documentSnapShot['userName'],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: const Divider(
                                      height: 30,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                  customWidgetUser(
                                    Icons.phone_android_sharp,
                                    documentSnapShot['phoneNumber'],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: const Divider(
                                      height: 30,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                  customWidgetUser(
                                    Icons.school,
                                    documentSnapShot['department'],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 5,
                                      right: 10,
                                    ),
                                    child: const Divider(
                                      height: 30,
                                      color: CupertinoColors.inactiveGray,
                                    ),
                                  ),
                                  customWidgetUser(
                                    Icons.join_full_sharp,
                                    'Member since ${documentSnapShot['created'].toDate().toString().substring(0, 10)}',
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SmallText(
                          text: 'Join our social groups',
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
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
                            itemCount: socialIcon.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  customWidgetSocial(
                                    socialList[index].socialIcon,
                                    socialList[index].socialText,
                                    socialList[index].copyIconText,
                                    socialList[index].textToCopy,
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SmallText(
                          text: 'Contact us via the platforms below',
                          color: Colors.grey.shade500,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) {
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
                            itemCount: supportIcon.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  customWidget(
                                    supportList[index].supportIcon,
                                    supportList[index].supportText,
                                    supportList[index].supportFunction,
                                  ),
                                ],
                              );
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const BigText(
                      text: 'MX Companion', color: Colors.white, size: 40),
                  const SizedBox(height: 10),
                  LoadingAnimationWidget.fourRotatingDots(
                      color: Colors.white, size: 80),
                ],
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
