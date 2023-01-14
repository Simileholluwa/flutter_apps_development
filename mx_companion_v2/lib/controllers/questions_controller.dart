import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/question_paper/question_paper_controller.dart';
import 'package:mx_companion_v2/firebase_ref/loading_status.dart';
import 'package:mx_companion_v2/models/questions_model.dart';
import '../firebase_ref/references.dart';
import '../screens/home/main_screen.dart';
import '../widgets/questions/result_screen.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionsModel questionModel;
  final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;
  Rxn<Questions> currentQuestion = Rxn<Questions>();

  //Timer
  Timer? _timer;
  int secondsLeft = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionsModel;
    loadData(_questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionsModel questionPaper) async {
    questionModel = questionPaper;
    loadingStatus.value = LoadingStatus.loading;
    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();

      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;

      for (Questions _question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answerQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(_question.id)
                .collection("answers")
                .get();

        final answers = answerQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        _question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds!);
      if (kDebugMode) {
        print(questionPaper.questions![0].question);
      }
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review_list']);
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  void jumpToQuestion(int index, {bool goBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if(goBack) {
      Get.back();
    }
  }
  
  void submit(){
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }
  

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) {
      return;
    } else {
      questionIndex.value++;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) {
      return;
    } else {
      questionIndex.value--;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  void tryAgain() {
    Get.find<QuestionPaperController>()
        .navigateToQuestions(paper: questionModel, tryAgain: true,
    );
    _startTimer(questionModel.timeSeconds!);
  }

  void navigateToHome() {
    _timer!.cancel();
    Get.offNamedUntil(MainScreen.routeName, (route) => false);
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    secondsLeft = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (secondsLeft == 0) {
        timer.cancel();
      } else {
        int minutes = secondsLeft ~/ 60;
        int seconds = secondsLeft % 60;
        time.value =
            "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
        secondsLeft--;
      }
    });
  }
}
