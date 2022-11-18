import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/questions_controller.dart';

import '../../firebase_ref/references.dart';
import '../auth_controller.dart';

extension QuestionsControllerExtension on QuestionsController {
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of ${allQuestions.length} are correct';
  }

  String get points {
    var points = (correctQuestionCount / allQuestions.length) *
        100 *
        (questionModel.timeSeconds! - secondsLeft) /
        questionModel.timeSeconds! *
        100;
    return points.toStringAsFixed(2);
  }

  Future<void> saveTestResult() async {
    var batch = fireStore.batch();
    User? _user = Get.find<AuthController>().getUser();
    if (_user == null) return;

    batch.set(
        userRF.doc(_user.email)
            .collection('user_tests')
            .doc(questionModel.id),
        {
          "points": points,
          "correct_answer_count":
              "$correctQuestionCount/${allQuestions.length}",
          "question_id": questionModel.id,
          "time_spent": questionModel.timeSeconds! - secondsLeft,
        });
    batch.commit();
    navigateToHome();
  }
}
