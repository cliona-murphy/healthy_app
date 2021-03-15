import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService2 {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    _fcm.configure(
      //called when app is in foreground and we receive notification
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      //called when app is closed completely and it's opened
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      //called when app is in background and it's opened from the
      //push notification
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
      onBackgroundMessage: (Map<String, dynamic> message) async {
        print("onBackgroundMessage: $message");
      }
    );
  }
}