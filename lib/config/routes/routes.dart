class Routes {
  static const String home = 'home';
  static const String homePath = '/home';

  static const String groceryHome = 'groceryHome';
  static const String groceryHomePath = '$homePath/$groceryHome';

  static const String groceriesMain = 'groceries';
  static const String groceriesMainPath = '$groceryHomePath/$groceriesMain';

  static const String isolatesMain = 'isolatesMain';
  static const String isolatesMainPath = '$homePath/$isolatesMain';

  /// Profile Paths
  static const String profile = 'profile';
  static const String profilePath = '$homePath/$profile';
}
