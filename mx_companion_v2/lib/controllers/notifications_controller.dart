import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mx_companion_v2/controllers/auth_controller.dart';
import '../firebase_ref/references.dart';
import 'package:http/http.dart' as http;

class HelperNotification {
  static Future<void> initInfo(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {

    var androidInitialize =
    const AndroidInitializationSettings('@mipmap/launcher_icon');
    const DarwinInitializationSettings iOSInitialize =
    DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iOSInitialize,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final String? payload = notificationResponse.payload;
        try {
          if (notificationResponse.payload != null) {
            if( Get.find<AuthController>().getUser() != null) {
              Get.find<AuthController>().navigateToNotifications();
            } else {
              Get.find<AuthController>().navigateToHome();
            }
          }
        } catch (e) {
          return;
        }
        return;
      },
    );

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      showNotification(message, flutterLocalNotificationsPlugin);

      if(Get.find<AuthController>().getUser() != null) {
        sendNotificationToFirebase(
          message.notification?.title,
          message.notification?.body,
            Get.find<AuthController>().getUser()!.uid
        );
      }

    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        if (message.notification?.title != null &&
            message.notification?.body != null) {
          if (Get.find<AuthController>().getUser() != null) {
            Get.find<AuthController>().navigateToNotifications();
          } else {
            Get.find<AuthController>().navigateToHome();
          }
        }
      } catch(e){
        return;
      }
    });

  }

  static Future<void> sendNotificationToFirebase(String? title, String? body, String uid) async {
    var batch = FirebaseFirestore.instance.batch();

      batch.set(
          userRF.doc(uid).collection(
              'user_notifications').doc(), {
        'notification_title': title,
        'notification_body': body,
        'created': DateTime.now(),
      });
      batch.commit();

  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin flp) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContentTitle: true,
    );

    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'MX Companion',
      'MX Companion',
      importance: Importance.high,
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      playSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      //iOS: IOSNotificationDetails(),
    );

    await flp.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
      payload: message.data['body'],
    );
  }

  static Future<void> sendRegisterSuccessMessage(
      String userId, String body, String title) async {
    DocumentSnapshot snap = await userRF
        .doc(userId)
        .collection('user_details')
        .doc('device_token')
        .get();
    String token = snap['device_token'];
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=${dotenv.env['MESSAGING_API_KEY']}'
        },
        body: jsonEncode(
          <String, dynamic>{
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title
            },
            'notification': <String, dynamic>{
              'title': title,
              'body': body,
              'android_channel_id': 'Mx Companion'
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      return;
    }
  }

}