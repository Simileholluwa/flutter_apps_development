import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import 'package:mx_companion_v2/models/questions_model.dart';

import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';
import '../../screens/questions_page/questions_page.dart';

class QuestionPaperController extends GetxController {
  final allPapers = <QuestionsModel>[].obs;
  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    loadingStatus.value = LoadingStatus.loading;
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList =
          data.docs.map((paper) => QuestionsModel.fromSnapshot(paper)).toList();
      allPapers.assignAll(paperList);
      loadingStatus.value = LoadingStatus.completed;
    } catch (e) {
      return;
    }
    loadingStatus.value = LoadingStatus.completed;
  }

  void navigateToQuestions({required QuestionsModel paper, bool tryAgain = false}){
    AuthController _authController = Get.find();
    if(_authController.isLoggedIn()){
      if(tryAgain){
        Get.toNamed(QuestionsPage.routename, arguments: paper, preventDuplicates:false, );
      } else {
        Get.toNamed(QuestionsPage.routename, arguments: paper,);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
