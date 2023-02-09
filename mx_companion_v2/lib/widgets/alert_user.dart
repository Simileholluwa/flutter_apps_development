import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dialogs {
  static final Dialogs _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget appDialog({
    required VoidCallback onTap,
    required VoidCallback onPressed,
    required String text,
    required String message,
    required String action,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        text,
      ),
      titlePadding: const EdgeInsets.only(top: 20, left: 20, bottom: 10,),
      content: Text(
        message,
        style: TextStyle(
          color: Theme.of(Get.context!).hintColor,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Cancel',
          )
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            action,
          ),
        ),
      ],
    );
  }

  static Widget updateDetailsDialog({
    required Widget title,
    required Widget content,
  }) {
    return AlertDialog(
      //scrollable: true,
      contentPadding: const EdgeInsets.all(5,),
      titlePadding: const EdgeInsets.all(0,),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: title,
      content: content,
    );
  }
}
