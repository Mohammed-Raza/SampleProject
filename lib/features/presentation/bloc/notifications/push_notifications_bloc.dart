import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:sample_project/features/domain/repository/firebase_repo.dart';
import '../../../../core/firebase/firebase_messaging.dart';
import '../../../../core/mixins/notifier_mixin.dart';

part 'push_notifications_event.dart';
part 'push_notifications_state.dart';

class PushNotificationsBloc
    extends Bloc<PushNotificationsEvent, PushNotificationsState> {
  PushNotificationsBloc(this._repository) : super(PushNotificationsInitial()) {
    on<GetAccessTokenEvent>(_getAccessTokenEvent);
    on<RequestNotificationEvent>(_requestPushNotification);
  }

  TextEditingController tokenCtrl = TextEditingController();

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

  final FirebaseRepository _repository;

  final _globalKey = GlobalKey<ScaffoldState>();

  void _getAccessTokenEvent(
      GetAccessTokenEvent event, Emitter<PushNotificationsState> emit) async {
    try {
      await FirebasePushNotifications().requestPermissions();

      String? token = await FirebasePushNotifications().registrationToken;

      if (token != null) {
        tokenCtrl.text = token;
      }
      emit(NotificationsMainState());
    } catch (e) {
      _exceptionHandler.handleExceptionWithToastNotifier(e);
    }
  }

  void _requestPushNotification(RequestNotificationEvent event,
      Emitter<PushNotificationsState> emit) async {
    try {
      // if (!(formKey.currentState?.validate() ?? true)) return;

      Map body = {
        "message": {
          "token": tokenCtrl.text.trim(),
          "notification": {
            "title": "Good Morning",
            "body": "Hii, Have a nice day"
          },
          "data": {"path": ""}
        }
      };

      AuthClient? credentials;
      if (FirebasePushNotifications.authClient == null ||
          (FirebasePushNotifications
                  .authClient?.credentials.accessToken.hasExpired ??
              true)) {
        FirebasePushNotifications.authClient =
            credentials = await obtainAuthenticatedClient();
      } else {
        credentials = FirebasePushNotifications.authClient;
      }

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            '${credentials?.credentials.accessToken.type} ${credentials?.credentials.accessToken.data}'
      };

      var result = await _repository.fcmPushNotification(body, headers);
      if (!event.context.mounted) return;

      if (result) {
        ToastNotifier.showSnackBar(
            'Notification send successfully', _globalKey, event.context);
      } else {
        ToastNotifier.showSnackBar(
            'Unable to send notification', _globalKey, event.context,
            color: Colors.red);
      }
    } catch (e) {
      _exceptionHandler.handleExceptionWithToastNotifier(e);
    }
  }

  /// Obtain Authenticated client using private key from firebase admin sdk
  Future<AuthClient> obtainAuthenticatedClient() async {
    /// https://console.firebase.google.com/project/farmers-market-c591f/settings/serviceaccounts/adminsdk
    /// Generate New private key
    final accountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "farmers-market-c591f",
      "private_key_id": "f2619fc8927dbce53188758a72debb5febbef132",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDINBJ408hIiwsg\nxNwZ3Mz3iMbflBjDjric/uHmS2HSsPDoBHe0aKNG8jw/oft67zF1fboO1Jin6WS+\nuQXNnuPV0UZCNZ6ZaIa87XIN4w4DkNj2TprCPbUWQuxScJmtdSJtG2CvSjp9ynlN\nnfPcmNPcsVBmT1thwKGv4yMkAMeF08+LlT5q9f7R8EbUBTGwLsT2MgiPYeVVKrZp\n5TQ6oVR0B6yDSWnXpiGI3XFKgLuyJUtEdQBJFnXp3Zm8hl9qcJDe8xz/whz3bl6K\n+iVVPjkJs78oXMsk1TDKH9a262VVti+25gi+at7pqcjgxncumqtXlgA52xZ2QG1x\nbi0GstrtAgMBAAECggEARG/gfKNQzNOTG0GQR9r9ygRcj2Mtz/PC0hAjIrlUGFTa\nFUYpsWcvoXn+9HWn5M9NZe9zocw03vlesf/HpxGQqq/eR5XSwHhFzuGQYoTibn+e\nWxxltM6pT5HS/R92uR/Yg9mfBGzob8W+D7VV/mvTyJZoeIDaKSFTZC/N/GmzyuAQ\nw9JM9SMZC6oL3xURL6dZg89/D/TfWJnDobOySj7XziyXswP2R011IrjOUWEiwUAb\nLDSbKBODf9+G33bcycZvqtEDeSSkHAMcEAbVPI9XrfMxCyfSSKXuOcSTKBSNG2Hy\nhiYrNEK/r6+vvL6uROrI0AlbbZjKSxOAgxkz8yBaFQKBgQD1W7ErVNkmz94hawrU\neieGpYf9BjeafbUNf8XHIjaRJDJYdMGTOPHnHRgoR5aiL/afqJt7RM1YaFblUbNk\nktplW5j7V3TVkN/FBgck9RzljtngbMKPUoe2Bpuh+PfMWMFSBrARgBeuDfVC7BZh\nnJ8e4RBFXent/+IYLW23whAo8wKBgQDQ4wJQItSQzxUWk4hx4sDZ1dW4fYWUW5nE\nQQ5R6T6kfjAyl2hXkjHFqEzjsnaAjZxmPjr/4khR+Xm860o6xOacfUbLKhPVEMtp\n3fSk2hKshBvCKUffvK4kb5ZLv6J5k3BHccnT4h7mvMpvfD32VVPHqyRX5simg/3q\nmUj5OUvknwKBgQCtGkSz2ofd7xe7ogahA5GxWEXKCMHf+EJtRLEnnga7fbsbVzxe\n/vUD5i3t9RvcT1SDLfSMEm2BqxNrdKnJEiaNDgOvh/NA3ZZSLb+KnngFqTQkNvdJ\nIKPok17n9nv1KsUxdtBveFy8itJ3pZLgyRwmMAlHt0tcg4RjJGHdHEhEawKBgDO/\nyZboyhiF9Qd+zVLJhlVxMF1gW3OBrfp803tfeXFvAanG8MahJUt+gm32jH0UmCaM\nTDmQabJFR++RqvYcSbWDI8K5Teh/HKXBoxYkIHQ01luntnKrX8kPDAEAHNRZvns0\nqXegkV9AbjZoZUFdqj/RGlPcjOET2hgAmZ+EnlSpAoGAKqNDsIxWLs0xVVRiNLKQ\nh4ahcpGxnOf7XxrxvZB76dn5OqhVP6k3ge45moqosqpwOWTk54UZFWqO+EPWU49H\ncwIq3keemMNwJ+Gry7gCOWJCv3vb1sScEtv/jllftYHmjW3Qoawe3bj16NzAxiLL\nZP5IRdwsMyvNJCfLxuQInGI=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-fbsvc@farmers-market-c591f.iam.gserviceaccount.com",
      "client_id": "112615187189922028403",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40farmers-market-c591f.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });
    List<String> scopes = [
      'https://www.googleapis.com/auth/firebase.messaging'
    ];

    AuthClient client =
        await clientViaServiceAccount(accountCredentials, scopes);

    return client; // Remember to close the client when you are finished with it.
  }
}
