import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mx_companion/Services/Authentication/initial_screen_controller.dart';
import 'package:samsung_ui_scroll_effect/samsung_ui_scroll_effect.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with AutomaticKeepAliveClientMixin{
  final CollectionReference _userHistory = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthController().getCurrentUID())
      .collection('history');

  void _alert() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.black,
        content: SmallText(
          text: 'History Deleted successfully',
          color: Colors.white,
          align: TextAlign.center,
        ),
      ),
    );
  }

  Future<void> _delete(String historyId) async {
    await _userHistory.doc(historyId).delete();
    _alert();
  }

  Future<void> _deleteAll() async {
    final WriteBatch batch = FirebaseFirestore.instance.batch();
    final collection = _userHistory;
    var snapShots = await collection.get();
    for (var doc in snapShots.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
    _alert();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
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
                      children: const [
                        Icon(Icons.history_rounded, size: 150, color: Colors.white,),
                        Text(
                          'Your practice history will appear here when you start practicing. Tap on the practice tab in the bottom navigation to start.',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
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
                        children: const [
                          BigText(
                            text: 'Practice History',
                            size: 40,
                            color: Colors.white,
                          ),
                          Text(
                            'Swipe left or right to delete any of the items in the history or use the delete Icon to delete all history list.',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
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
                      child: const BigText(text: 'History', size: 24)),
                  actions: [
                    Container(
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                        ),
                        onPressed: () async {
                          return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: AlertDialog(
                                    backgroundColor:
                                        CupertinoColors.darkBackgroundGray,
                                    title: const BigText(
                                      text: 'Delete All?',
                                    ),
                                    content: const Text(
                                        'Are you sure you want to delete all? This action is irreversible.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _deleteAll();
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('Delete', style: TextStyle(color: Colors.blue.shade800,),),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child:Text('Cancel', style: TextStyle(color: Colors.blue.shade800,),),
                                      ),
                                    ],
                                  ),
                                );
                              });
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
                                      color: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          SmallText(
                                              text: 'Delete ${documentSnapShot['courseCode']} From History'),
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
                                      color: Colors.red,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                          SmallText(
                                              text: 'Delete ${documentSnapShot['courseCode']} From History'),
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
                                    setState((){
                                      streamSnapshot.data!.docs.removeAt(index);
                                    });
                                  },
                                  confirmDismiss:
                                      (DismissDirection direction) async {
                                    return await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return BackdropFilter(
                                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                            child: AlertDialog(
                                              backgroundColor: CupertinoColors
                                                  .darkBackgroundGray,
                                              title: BigText(
                                                text:
                                                    'Delete ${documentSnapShot['courseCode']}?',
                                              ),
                                              content: Text(
                                                  'Are you sure you want to delete ${documentSnapShot['courseCode']} from history list? This action is irreversible.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child:Text('Delete' , style: TextStyle(color: Colors.blue.shade800),),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.of(context)
                                                          .pop(false),
                                                  child: Text('Cancel', style: TextStyle(color: Colors.blue.shade800),),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 80,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: CupertinoColors.secondaryLabel,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 5,
                                              bottom: 5,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                BigText(
                                                    text: documentSnapShot[
                                                            'marks']
                                                        .toString(),
                                                    color: Colors.white, size: 25,),
                                                const BigText(
                                                  text: 'marks',
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        documentSnapShot[
                                                            'courseCode'],
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        documentSnapShot['created']
                                                            .toDate()
                                                            .toString()
                                                            .substring(11, 16),
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.blue.shade800,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    documentSnapShot[
                                                        'courseName'],
                                                    style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    documentSnapShot['created']
                                                        .toDate()
                                                        .toString()
                                                        .substring(0, 10),
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
                              }),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20,),
                  ],
                );
              }
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
