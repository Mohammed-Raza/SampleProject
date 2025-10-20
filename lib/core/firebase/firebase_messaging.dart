import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/mixins/notifier_mixin.dart';

import '../../global_variables.dart';

class FirebasePushNotifications {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  static AuthClient? authClient;

  static final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static String logo = '@mipmap/ic_launcher';

  NotificationSettings? notificationSettings;

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

  final _androidChannel = const AndroidNotificationChannel(
      'sp_channel', "SP Notifications",
      description: 'This channel is used for Groceries SP',
      importance: Importance.defaultImportance);

  Future<void>? requestPermissions() async {
    // if (notificationSettings != null &&
    //     notificationSettings?.authorizationStatus ==
    //         AuthorizationStatus.authorized) {
    //
    // }
    final settings = await messaging.requestPermission();

    if (kDebugMode) {
      print('Permission granted: ${settings.authorizationStatus}');
    }
    notificationSettings = settings;
  }

  Future<String?> get registrationToken async {
    try {
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
    } catch (e) {
      _exceptionHandler.handleException(e);
      return null;
    }
  }

  final String webVapidKey =
      'BMeaVyGopUp2WHKKSJTuxch6z8i-4lo744Iqo7jTuSnM2BLgjFKhOQx4kCzJ8_A11nmVuZSqDm1fcDXCdEHnMes';

  void initiateTheFirebaseListeners() async {
    await messaging.setForegroundNotificationPresentationOptions(
        alert: true, sound: true, badge: true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Handling a foreground message: ${message.messageId}');
      debugPrint('Message data: ${message.data}');
      debugPrint('Message notification: ${message.notification?.title}');
      debugPrint('Message notification: ${message.notification?.body}');
      debugPrint('Message notification: ${message.data}');

      showNotification(
          title: '${message.notification?.title}',
          body: '${message.notification?.body}',
          payLoad: message.data);
    }).onError((e) => debugPrint('Failed to on message ${e.toString()}'));

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // FirebaseMessaging.onMessageOpenedApp
    //     .listen(Routing.onPushNotificationOpened);

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // Routing.onPushNotificationOpened(initialMessage);
    }
  }

  Future showNotification(
      {int id = 0,
      String? title,
      String? body,
      Map<dynamic, dynamic>? payLoad}) async {
    if (kIsWeb && navigatorKey.currentState?.context != null) {
      ToastNotifier.showNewToast(title ?? 'Title Missing', body ?? 'No Body');
    } else {
      await localNotificationsPlugin.show(id, title, body, notificationDetails,
          payload: payLoad?['path']);

      if (Platform.isIOS || Platform.isMacOS) {
        Future.delayed(const Duration(milliseconds: 800),
            () => localNotificationsPlugin.cancel(0));
      }
    }
  }

  static void initializeLocalPushNotifications() async {
    final androidInitialSetting = AndroidInitializationSettings(logo);

    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: androidInitialSetting,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsIOS);

    await localNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: handleLocalPushNotification,
        onDidReceiveBackgroundNotificationResponse:
            handleLocalPushNotification);
  }

  get notificationDetails {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            _androidChannel.id, _androidChannel.name,
            channelDescription: _androidChannel.description,
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
            icon: logo),
        iOS: const DarwinNotificationDetails(
            presentSound: true,
            presentBadge: true,
            interruptionLevel: InterruptionLevel.timeSensitive,
            badgeNumber: 1));
  }

  static void deleteToken() async =>
      await FirebaseMessaging.instance.deleteToken();
}

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  if (message.notification == null) return;
  handleMessage(message);
}

void handleLocalPushNotification(NotificationResponse response) {
  final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
  handleMessage(message);
}

void handleMessage(RemoteMessage? message) async {
  if (message == null || message.notification == null) return;
  try {
    if (message.notification != null) {}
  } catch (e) {
    ExceptionHandler().handleExceptionWithToastNotifier(e);
  }
}
