import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/question_paper/data_uploader.dart';

import '../firebase_ref/loading_status.dart';

class DataUploaderScreen extends StatelessWidget {
  const DataUploaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataUploader controller = Get.put(DataUploader());
    return Scaffold(
        body: Center(
      child: Obx(
        () => Text(
          controller.loadingStatus.value == LoadingStatus.completed
              ? 'Uploading Complete'
              : 'uploading...',
        ),
      ),
    ));
  }
}
