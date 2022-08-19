import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';

import '../../firebase_ref/references.dart';

class QuestionPaperController extends GetxController {
  final allPapers = <QuestionsModel>[].obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList =
          data.docs.map((paper) => QuestionsModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);
    } catch (e) {
      return;
    }
  }

  void navigateToQuestions({required QuestionsModel paper, bool tryAgain = false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.back();
        //Get.offNamed(page);
      } else {
        //Get.toNamed(page);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
