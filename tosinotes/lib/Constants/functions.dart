//logout function
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


//logout
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure yo want to Log out?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              Navigator.of(dialogContext).pop(true); // Dismiss alert dialog
            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(dialogContext).pop(false); // Dismiss alert dialog
            },
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}


//show error
Future<void> showErrorDialog(BuildContext context, String text) {
  return Alert(
    context: context,
    type: AlertType.error,
    style: const AlertStyle(
      animationType: AnimationType.fromTop,
      isOverlayTapDismiss: false,
    ),
    title: "An error occurred",
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 15, ),
        ),
        const Divider(thickness: 2, color: Colors.deepPurple),
      ],
    ),
    buttons: [
      DialogButton(
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
        color: Colors.deepPurple,
      )
    ],
  ).show();
}


