import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRF = fireStore.collection('questionPapers');
final userRF = fireStore.collection('users');

DocumentReference questionsRef({
  required String paperId,
  required String questionId,
}) => questionPaperRF.doc(paperId).collection('questions').doc(questionId);

CollectionReference userDetailsRef({
  required String email,
}) => userRF.doc(email).collection('user_details');