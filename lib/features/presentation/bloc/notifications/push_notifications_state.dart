part of 'push_notifications_bloc.dart';

@immutable
sealed class PushNotificationsState {}

final class PushNotificationsInitial extends PushNotificationsState {}

final class NotificationsMainState extends PushNotificationsState {}
