import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebasePushNotifications {
  final messaging = FirebaseMessaging.instance;

  Future<String>? requestPermissions() async {
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
    return settings.authorizationStatus.name;
  }

  Future<String?> get registrationToken async {
    if (kIsWeb) {
      return await messaging.getToken(vapidKey: webVapidKey);
    } else {
      if (Platform.isIOS || Platform.isMacOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          return await messaging.getToken();
        }
      }
      return await messaging.getToken();
    }
  }

  final String webVapidKey =
      'BMeaVyGopUp2WHKKSJTuxch6z8i-4lo744Iqo7jTuSnM2BLgjFKhOQx4kCzJ8_A11nmVuZSqDm1fcDXCdEHnMes';
}
