abstract class FirebaseRepository {
  Future<bool> fcmPushNotification(Map body, Map<String, String>? headers);
}
