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

  static const String scrollsMain = 'scrollsMain';
  static const String scrollsMainPath = '$homePath/$scrollsMain';

  static const String webSocket = 'webSocket';
  static const String webSocketPath = '$homePath/$webSocket';

  /// Profile Paths
  static const String profile = 'profile';
  static const String profilePath = '$homePath/$profile';

  /// Different Types of Scroll Paths
  static const String customScroll = 'customScroll';
  static const String customScrollFullPath = '$scrollsMainPath/$customScroll';

  static const String nestedScroll = 'nestedScroll';
  static const String nestedScrollFullPath = '$scrollsMainPath/$nestedScroll';

  static const String carouselScroll = 'carouselScroll';
  static const String carouselScrollFullPath =
      '$scrollsMainPath/$carouselScroll';

  static const String paginationScroll = 'paginationScroll';
  static const String paginationScrollFullPath =
      '$scrollsMainPath/$paginationScroll';
}
