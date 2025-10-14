class Urls {
  static const String baseUrl =
      'https://farmers-market-c591f-default-rtdb.firebaseio.com/';

  /// end points
  static const String groceryCategory = 'groceryCategory';
  static const String getGroceries = 'groceries';

  /// fire base push notifications
  static const String fcmBaseUrl = 'https://fcm.googleapis.com/';
  static const String fcmEndPoint =
      'v1/projects/farmers-market-c591f/messages:send';
}
