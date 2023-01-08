import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mx_companion/Services/Authentication/initial_screen_controller.dart';
import 'package:mx_companion/models/history_model.dart';
import 'package:mx_companion/screens/tab_view/tab_view.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class QuizPage extends StatefulWidget {
  final String courseCode;
  final String courseName;
  final List myData;
  const QuizPage(
      {Key? key,
      required this.myData,
      required this.courseCode,
      required this.courseName})
      : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Color colorToShow = Colors.transparent;
  Color wrongAnswerColor = Colors.red;
  Color rightAnswerColor = Colors.green;
  int marks = 0;
  int i = 1;
  int j = 1;
  List randomArray = [];
  List<Icon> progressIcons = [];

  static const int maxSeconds = 45;
  int seconds = maxSeconds;
  Timer? practiceTimer;

  int timer = 45;
  String showTimer = '45';
  bool disableAnswer = false;
  bool isAlreadySelected = false;
  History _history = History();

  Map<String, Color> btnColor = {
    "a": Colors.transparent,
    "b": Colors.transparent,
    "c": Colors.transparent,
    "d": Colors.transparent,
  };

  bool cancelTimer = false;

  @override
  void initState() {
    startPracticeTimer();
    generateRandomArray();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void getHistoryDetails() async {
    _history.courseCode = widget.courseCode;
    _history.courseName = widget.courseName;
    _history.marks = marks.toString();
    _history.created = DateTime.now();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthController().getCurrentUID())
        .collection('history')
        .add(_history.toJson());
  }

  generateRandomArray(){
    List distinctIds = [];
    var rand = Random();
    for(int i = 0; ;){
      distinctIds.add(rand.nextInt(20));
      randomArray = distinctIds.toSet().toList();
      if(randomArray.length < 10){
        continue;
      } else {
        break;
      }
    }
  }

  void nextQuestion() async {
    stopTimer(reset: true);
    startPracticeTimer(reset: true);
    setState(() {
      if (j < 10) {
        i = randomArray[j];
        j++;
      } else {
        stopTimer(reset: true);
        _practiceCompleteInfo(
          context,
          widget.courseName,
          widget.courseCode,
        );
        getHistoryDetails();
      }
      btnColor["a"] = Colors.transparent;
      btnColor["b"] = Colors.transparent;
      btnColor["c"] = Colors.transparent;
      btnColor["d"] = Colors.transparent;
      disableAnswer = false;
    });
  }

  void checkAnswer(String k) {
    if (widget.myData[2][i.toString()] == widget.myData[1][i.toString()][k]) {
      marks = marks + 1;
      colorToShow = rightAnswerColor;
      progressIcons.add(
        const Icon(Icons.check, color: Colors.green,)
      );
    } else {
      colorToShow = wrongAnswerColor;
      progressIcons.add(
          const Icon(Icons.clear, color: Colors.red,)
      );
    }
    setState(() {
      btnColor[k] = colorToShow;
      stopTimer(reset: false);
      disableAnswer = true;
    });

    Timer(const Duration(seconds: 1), nextQuestion);
  }

  void startPracticeTimer({bool reset = true}) async {
    if (reset) {
      resetTimer();
    }
    practiceTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        stopTimer(reset: false);
        nextQuestion();
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() {
      practiceTimer?.cancel();
    });
  }

  void resetTimer() => setState(() {
        seconds = maxSeconds;
      });

  Future<void> _practiceCompleteInfo(
    BuildContext context,
    String courseName,
    String courseCode,
  ) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AlertDialog(
              contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
              actionsPadding: const EdgeInsets.only(
                bottom: 10,
              ),
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
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.green,
                          child: ClipOval(
                            child: SizedBox(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  FontAwesomeIcons.solidThumbsUp,
                                  color: Colors.white,
                                  size: 60,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: BigText(
                        text: 'PRACTICE COMPLETED!',
                        color: Colors.white,
                      ),
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.blue.shade800,
                      endIndent: 30,
                      indent: 30,
                    ),
                    Text(
                      'You have successfully completed your practice and you scored $marks.',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.offAll(() => const ScreensTabView());
                      },
                      child: Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue.shade800,
                        ),
                        child: const Center(
                          child: SmallText(text: 'Home'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget optionsContainer(String k,) {
    return InkWell(
      onTap: () {
        checkAnswer(k);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: btnColor[k]!,
            width: 4.0,
          ),
          color: Colors.white.withAlpha(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.myData[1][i.toString()][k],
              style: const TextStyle(
                fontFamily: '',
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRunning = practiceTimer == null ? false : practiceTimer!.isActive;

    return WillPopScope(
      onWillPop: () {
        return showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AlertDialog(
                elevation: 4,
                backgroundColor: CupertinoColors.darkBackgroundGray,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: BigText(
                    text: 'Quit ${widget.courseCode} Practice?',
                    color: Colors.white),
                content: Text(
                  'Are you sure you want to quit practicing ${widget.courseCode}?',
                  style: const TextStyle(color: Colors.white),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      'Quit',
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                    onPressed: () {
                      if (isRunning) {
                        stopTimer(reset: false);
                      }
                      Get.offAll(
                        () => const ScreensTabView(),
                        transition: Transition.leftToRightWithFade,
                      );
                    },
                  ),
                  TextButton(
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.blue.shade800),
                    ),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(false);
                    },
                  ),
                ],
              ),
            );
          },
        ).then((value) => value ?? false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 70,
          title: BigText(text: widget.courseCode, size: 30,),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  splashRadius: 20,
                  onPressed: (){
                    if(isRunning){
                      stopTimer(reset: false);
                    } else {
                      startPracticeTimer(reset: false);
                    }
                  },
                  icon: isRunning ? const Icon(Icons.pause_circle_filled_sharp, size: 50,) : const Icon(Icons.play_circle_sharp, size: 50,),
                ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20,),
          child: const Text(
            'We recommend that you practice without having to depend on pausing the timer!',
            style: TextStyle(
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(
            top: 150,
          ),
          child: FloatingActionButton.large(
            backgroundColor: Colors.black,
            onPressed: () {  },
            elevation: 20,
            child: SizedBox(
              width: 100,
              height: 100,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: 1 - seconds / maxSeconds,
                    strokeWidth: 10,
                    valueColor: seconds == 0
                        ? const AlwaysStoppedAnimation(
                      Colors.red,
                    )
                        : const AlwaysStoppedAnimation(
                      Colors.white,
                    ),
                    backgroundColor: Colors.blue.shade800,
                  ),
                  Center(
                    child: seconds == 0
                        ? const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 60,
                    )
                        : BigText(
                      text: '$seconds',
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 75,
            bottom: 50,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            color: CupertinoColors.darkBackgroundGray,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70, left: 10, right: 10,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(
                        text: 'Question $j/10',
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(height: 5,),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20,),
                        child: LinearProgressIndicator(
                          minHeight: 7,
                          backgroundColor: Colors.white,
                          value: (j / 10),
                          valueColor: j == 10 ?
                          const AlwaysStoppedAnimation(
                            Colors.green,
                          )
                              : AlwaysStoppedAnimation(
                            Colors.blue.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (progressIcons.isEmpty)
                              const SizedBox(),
                            if(progressIcons.isNotEmpty)
                              ...progressIcons,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Questions container
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    widget.myData[0][i.toString()],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: '',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                AbsorbPointer(
                  absorbing: disableAnswer,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10, left: 10,),
                    child: Column(
                      children: [
                        //Options container
                        optionsContainer('a',),
                        const SizedBox(height: 20),
                        optionsContainer('b'),
                        const SizedBox(height: 20),
                        optionsContainer('c'),
                        const SizedBox(height: 20),
                        optionsContainer('d'),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
