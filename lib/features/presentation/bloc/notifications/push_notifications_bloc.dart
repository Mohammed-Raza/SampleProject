import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
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

      if (credentials == null) return;

      var headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            '${credentials.credentials.accessToken.type} ${credentials.credentials.accessToken.data}'
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
  Future<AuthClient?> obtainAuthenticatedClient() async {
    /// https://console.firebase.google.com/project/farmers-market-c591f/settings/serviceaccounts/adminsdk
    /// Generate New private key
    try {
      final serviceAccountJson =
          await rootBundle.loadString('assets/service_account.json');

      final accountCredentials =
          ServiceAccountCredentials.fromJson(json.decode(serviceAccountJson));

      List<String> scopes = [
        'https://www.googleapis.com/auth/firebase.messaging'
      ];

      AuthClient client =
          await clientViaServiceAccount(accountCredentials, scopes);

      return client; // Remember to close the client when you are finished with it.
    } catch (e) {
      _exceptionHandler.handleException(e);
      return null;
    }
  }
}
