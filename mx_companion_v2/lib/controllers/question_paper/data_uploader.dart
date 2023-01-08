import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/models/questions_model.dart';

import '../../firebase_ref/loading_status.dart';
import '../../firebase_ref/references.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading;

    final fireStore = FirebaseFirestore.instance;
    //Load json files
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final assetsPapers = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();

    //Read json content
    List<QuestionsModel> questionPapers = [];
    for(var paper in assetsPapers){
      String paperContent = await rootBundle.loadString(paper);
      questionPapers.add(QuestionsModel.fromJson(json.decode(paperContent)));
    }

    var batch = fireStore.batch();
    for(var papers in questionPapers){
      batch.set(questionPaperRF.doc(papers.id), {
        "course_code": papers.courseCode,
        "image_url": papers.imageUrl,
        "course_title": papers.courseTitle,
        "credit_unit": papers.creditUnit,
        "semester": papers.semester,
        "time_seconds": papers.timeSeconds,
        "questions_count": papers.questions == null ? 0 : papers.questions!.length
      });

      for (var questions in papers.questions!){
        final questionPath = questionsRef(paperId: papers.id!, questionId: questions.id);
        batch.set(questionPath, {
          "question" : questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var answer in questions.answers){
          batch.set(questionPath.collection('answers').doc(answer.identifier), {
                "identifier": answer.identifier,
                "answer": answer.answer
              });
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed;
  }
}
