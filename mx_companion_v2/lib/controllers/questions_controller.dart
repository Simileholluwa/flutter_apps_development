import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/firebase_ref/loading_status.dart';
import 'package:mx_companion_v2/models/questions_model.dart';

import '../firebase_ref/references.dart';

class QuestionsController extends GetxController {
  final loadingStatus = LoadingStatus.loading.obs;
  late QuestionsModel questionModel;
  final allQuestions = <Questions>[];
  Rxn<Questions> currentQuestion = Rxn<Questions>();
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

        final answers = answerQuery.docs.map((answer) => Answers.fromSnapshot(answer))
        .toList();

        _question.answers = answers;
        if(questionPaper.questions != null && questionPaper.questions!.isNotEmpty){
          allQuestions.assignAll(questionPaper.questions!);
          currentQuestion.value = questionPaper.questions![0];
          if(kDebugMode){
            print(questionPaper.questions![0].question);
          }
          loadingStatus.value = LoadingStatus.completed;
        } else {
          loadingStatus.value = LoadingStatus.error;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
