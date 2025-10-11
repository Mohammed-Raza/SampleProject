import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sample_project/core/error/exception_handler.dart';

import '../../../../core/firebase/firebase_messaging.dart';

part 'push_notifications_event.dart';
part 'push_notifications_state.dart';

class PushNotificationsBloc
    extends Bloc<PushNotificationsEvent, PushNotificationsState> {
  PushNotificationsBloc() : super(PushNotificationsInitial()) {
    on<GetAccessTokenEvent>(_getAccessTokenEvent);
  }

  TextEditingController tokenCtrl = TextEditingController();

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

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
}
