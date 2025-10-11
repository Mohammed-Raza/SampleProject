part of 'push_notifications_bloc.dart';

@immutable
sealed class PushNotificationsEvent {}

final class GetAccessTokenEvent extends  PushNotificationsEvent{}
