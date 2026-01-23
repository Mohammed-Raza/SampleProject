class Constants {
  static const String rupee = '₹';

  static const String success = 'success';

  /// Language codes
  static const String english = 'en';
  static const String hindi = 'hi';
  static const String telugu = 'te';
  static const String urdu = 'ur';

  static const List<String> languages = [english, hindi, telugu, urdu];

  static const String customScrollDesc =
      '''The CustomScrollView in Flutter is a powerful scrolling widget that 
builds custom scroll effects using special, low-level widgets called slivers. 
Unlike ListView or SingleChildScrollView, which are designed for simple 
lists or single-screen content, CustomScrollView provides fine-grained control 
to combine different scrollable areas (like lists, grids, and expanding app bars) 
into a single, cohesive scrolling experience. ''';

  static const String nestedScrollDesc =
      '''The Flutter NestedScrollView is a widget designed to coordinate scrolling 
between multiple nested scrollable areas, making them behave as a single,
unified scrolling experience. It is commonly used in UIs that feature a 
flexible app bar (like a SliverAppBar) with a TabBar and a TabBarView. ''';

  static const String paginationDesc =
      '''Pagination in Flutter is a technique for efficiently loading and displaying 
large datasets in small, manageable chunks, which improves performance and 
user experience. The most common approach is infinite scrolling, where new 
data loads automatically as the user scrolls to the end of a list. ''';

  static const String carouselDesc =
      '''In Flutter, a carousel is a UI widget that displays a series of items 
(like images or cards) in a horizontally or vertically scrolling format, 
typically showing one item at a time with smooth transitions. Developers 
can use the built-in CarouselView widget (available since Flutter 3.24) or 
popular third-party packages like carousel_slider for implementation. ''';
}
