class Routes {
  static const String home = 'home';
  static const String homePath = '/home';

  static const String groceryHome = 'groceryHome';
  static const String groceryHomePath = '$homePath/$groceryHome';

  static const String groceriesMain = 'groceries';
  static const String groceriesMainPath = '$groceryHomePath/$groceriesMain';

  static const String isolatesMain = 'isolatesMain';
  static const String isolatesMainPath = '$homePath/$isolatesMain';

  static const String pushNotificationsMain = 'pushNotificationsMain';
  static const String pushNotificationsMainPath =
      '$homePath/$pushNotificationsMain';

  static const String dynamicPdfMain = 'dynamicPdfMain';
  static const String dynamicPdfMainPath = '$homePath/$dynamicPdfMain';

  static const String sqfLiteMain = 'sqfLiteMain';
  static const String sqfLiteMainPath = '$homePath/$sqfLiteMain';

  /// Profile Paths
  static const String profile = 'profile';
  static const String profilePath = '$homePath/$profile';
}
