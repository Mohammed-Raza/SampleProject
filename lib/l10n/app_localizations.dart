import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_te.dart';
import 'app_localizations_ur.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('te'),
    Locale('ur')
  ];

  /// No description provided for @vegetables.
  ///
  /// In en, this message translates to:
  /// **'Vegetables'**
  String get vegetables;

  /// No description provided for @fruits.
  ///
  /// In en, this message translates to:
  /// **'Fruits'**
  String get fruits;

  /// No description provided for @milkProducts.
  ///
  /// In en, this message translates to:
  /// **'Milk Products'**
  String get milkProducts;

  /// No description provided for @cookies.
  ///
  /// In en, this message translates to:
  /// **'Cookies'**
  String get cookies;

  /// No description provided for @groceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get groceries;

  /// No description provided for @isolates.
  ///
  /// In en, this message translates to:
  /// **'Isolates'**
  String get isolates;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @getAccessToken.
  ///
  /// In en, this message translates to:
  /// **'Get Access Token'**
  String get getAccessToken;

  /// No description provided for @sharePdf.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdf;

  /// No description provided for @sqfLite.
  ///
  /// In en, this message translates to:
  /// **'SqfLite'**
  String get sqfLite;

  /// No description provided for @scrolls.
  ///
  /// In en, this message translates to:
  /// **'Scrolls'**
  String get scrolls;

  /// No description provided for @webSocket.
  ///
  /// In en, this message translates to:
  /// **'Web Socket'**
  String get webSocket;

  /// No description provided for @groceriesHome.
  ///
  /// In en, this message translates to:
  /// **'Groceries Home'**
  String get groceriesHome;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profileAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get profileAppearance;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @saveAppearance.
  ///
  /// In en, this message translates to:
  /// **'Save Appearance'**
  String get saveAppearance;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @useDeviceTheme.
  ///
  /// In en, this message translates to:
  /// **'Use device theme'**
  String get useDeviceTheme;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @automatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get automatic;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More...'**
  String get readMore;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @uploadImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get uploadImage;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @tapToTakeImage.
  ///
  /// In en, this message translates to:
  /// **'Tap to take image'**
  String get tapToTakeImage;

  /// No description provided for @deleteImage.
  ///
  /// In en, this message translates to:
  /// **'Delete Image'**
  String get deleteImage;

  /// No description provided for @deleteAllImages.
  ///
  /// In en, this message translates to:
  /// **'Delete All Images'**
  String get deleteAllImages;

  /// No description provided for @sendMessage.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get sendMessage;

  /// No description provided for @sendAMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get sendAMessage;

  /// No description provided for @modules.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get modules;

  /// No description provided for @homeHub.
  ///
  /// In en, this message translates to:
  /// **'Home Hub'**
  String get homeHub;

  /// No description provided for @exploreSampleApp.
  ///
  /// In en, this message translates to:
  /// **'Explore the sample app'**
  String get exploreSampleApp;

  /// No description provided for @beautifulDemosOnePolishedEntryPoint.
  ///
  /// In en, this message translates to:
  /// **'Beautiful demos, one polished entry point.'**
  String get beautifulDemosOnePolishedEntryPoint;

  /// No description provided for @browseGroceriesNotificationsPdfsSocketsStorageDemosAndMore.
  ///
  /// In en, this message translates to:
  /// **'Browse groceries, notifications, PDFs, sockets, storage demos and more from one cleaner dashboard.'**
  String get browseGroceriesNotificationsPdfsSocketsStorageDemosAndMore;

  /// No description provided for @groceriesHomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse shopping categories with a cleaner retail-style entry point.'**
  String get groceriesHomeDescription;

  /// No description provided for @isolatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Performance-focused demo for background work on mobile.'**
  String get isolatesDescription;

  /// No description provided for @pushNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Firebase Cloud Messaging flows in one polished space.'**
  String get pushNotificationsDescription;

  /// No description provided for @sharePdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Create and share dynamic PDF documents with images.'**
  String get sharePdfDescription;

  /// No description provided for @sqfLiteDescription.
  ///
  /// In en, this message translates to:
  /// **'Local database operations across Android, iOS, and macOS.'**
  String get sqfLiteDescription;

  /// No description provided for @scrollsDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore scrolling patterns and UI behaviors in Flutter.'**
  String get scrollsDescription;

  /// No description provided for @webSocketDescription.
  ///
  /// In en, this message translates to:
  /// **'Realtime client and server communication examples.'**
  String get webSocketDescription;

  /// No description provided for @freshPicksAndEverydayEssentials.
  ///
  /// In en, this message translates to:
  /// **'Fresh picks and everyday essentials'**
  String get freshPicksAndEverydayEssentials;

  /// No description provided for @freshGroceriesThoughtfullyPresented.
  ///
  /// In en, this message translates to:
  /// **'Fresh groceries, thoughtfully presented.'**
  String get freshGroceriesThoughtfullyPresented;

  /// No description provided for @pickCategoryBrowseHandpickedEssentials.
  ///
  /// In en, this message translates to:
  /// **'Pick a category to browse handpicked essentials with a cleaner shopping flow.'**
  String get pickCategoryBrowseHandpickedEssentials;

  /// No description provided for @collectionSuffix.
  ///
  /// In en, this message translates to:
  /// **'COLLECTION'**
  String get collectionSuffix;

  /// No description provided for @freshPicksCleanerShoppingExperience.
  ///
  /// In en, this message translates to:
  /// **'Fresh picks with a cleaner shopping experience.'**
  String get freshPicksCleanerShoppingExperience;

  /// No description provided for @swipeScanAdjustDescription.
  ///
  /// In en, this message translates to:
  /// **'Swipe through imagery, scan descriptions, and adjust quantity from beautifully organized product cards.'**
  String get swipeScanAdjustDescription;

  /// No description provided for @yourCartIsReadyForGlowUp.
  ///
  /// In en, this message translates to:
  /// **'Your cart is ready for a glow-up.'**
  String get yourCartIsReadyForGlowUp;

  /// No description provided for @cartDescription.
  ///
  /// In en, this message translates to:
  /// **'Items you add from the grocery catalog can be highlighted here with totals, offers, and a clearer checkout summary.'**
  String get cartDescription;

  /// No description provided for @ordersCanFeelMorePremium.
  ///
  /// In en, this message translates to:
  /// **'Orders can feel more premium here.'**
  String get ordersCanFeelMorePremium;

  /// No description provided for @ordersDescription.
  ///
  /// In en, this message translates to:
  /// **'This tab now has a designed placeholder instead of a blank screen, ready for order tracking, status chips, and purchase history.'**
  String get ordersDescription;

  /// No description provided for @noCategoriesAvailableToShow.
  ///
  /// In en, this message translates to:
  /// **'No categories are available to show'**
  String get noCategoriesAvailableToShow;

  /// No description provided for @noGroceryItemsAvailableToShow.
  ///
  /// In en, this message translates to:
  /// **'No grocery items are available to show'**
  String get noGroceryItemsAvailableToShow;

  /// No description provided for @sharePdfInstructionsIntro.
  ///
  /// In en, this message translates to:
  /// **'Here on click of floating action menu button, you can'**
  String get sharePdfInstructionsIntro;

  /// No description provided for @sharePdfInstructionCreateTable.
  ///
  /// In en, this message translates to:
  /// **'1. Create customized table with Rows & Columns'**
  String get sharePdfInstructionCreateTable;

  /// No description provided for @sharePdfInstructionSharePdf.
  ///
  /// In en, this message translates to:
  /// **'2. Share PDF with customized table data and added images'**
  String get sharePdfInstructionSharePdf;

  /// No description provided for @sharePdfInstructionAddImages.
  ///
  /// In en, this message translates to:
  /// **'3. Capture image or upload from gallery'**
  String get sharePdfInstructionAddImages;

  /// No description provided for @createTable.
  ///
  /// In en, this message translates to:
  /// **'Create Table'**
  String get createTable;

  /// No description provided for @sharePdfAction.
  ///
  /// In en, this message translates to:
  /// **'Share PDF'**
  String get sharePdfAction;

  /// No description provided for @addImages.
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get addImages;

  /// No description provided for @columns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get columns;

  /// No description provided for @rowsCount.
  ///
  /// In en, this message translates to:
  /// **'Rows Count'**
  String get rowsCount;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @removeImage.
  ///
  /// In en, this message translates to:
  /// **'Remove Image'**
  String get removeImage;

  /// No description provided for @isolation.
  ///
  /// In en, this message translates to:
  /// **'Isolation'**
  String get isolation;

  /// No description provided for @shortLived.
  ///
  /// In en, this message translates to:
  /// **'Short-Lived'**
  String get shortLived;

  /// No description provided for @longLived.
  ///
  /// In en, this message translates to:
  /// **'Long-Lived'**
  String get longLived;

  /// No description provided for @shortLivedIntroPrefix.
  ///
  /// In en, this message translates to:
  /// **'Here '**
  String get shortLivedIntroPrefix;

  /// No description provided for @shortLivedIntroHighlight.
  ///
  /// In en, this message translates to:
  /// **'Isolate.run / compute '**
  String get shortLivedIntroHighlight;

  /// No description provided for @shortLivedIntroSuffix.
  ///
  /// In en, this message translates to:
  /// **'method is used. This method spawns an isolate, passes a callback to the spawned isolate to start some computation, returns a value from the computation, and then shuts the isolate down when the computation is complete.'**
  String get shortLivedIntroSuffix;

  /// No description provided for @shortLivedImageCompressionDescription.
  ///
  /// In en, this message translates to:
  /// **'Here after capturing the image it will be compressed with compute method'**
  String get shortLivedImageCompressionDescription;

  /// No description provided for @longLivedIntroPrefix.
  ///
  /// In en, this message translates to:
  /// **'Here '**
  String get longLivedIntroPrefix;

  /// No description provided for @longLivedIntroHighlight.
  ///
  /// In en, this message translates to:
  /// **'Isolate.spawn, SendPort & ReceivePort '**
  String get longLivedIntroHighlight;

  /// No description provided for @longLivedIntroSuffix.
  ///
  /// In en, this message translates to:
  /// **'are used. Long-lived isolates are useful when you have a specific process that either needs to be run repeatedly throughout the lifetime of your application.'**
  String get longLivedIntroSuffix;

  /// No description provided for @longLivedImageGenerationDescription.
  ///
  /// In en, this message translates to:
  /// **'Here after capturing the image, 50 images are generated with index number as water-mark on image and with compression.'**
  String get longLivedImageGenerationDescription;

  /// No description provided for @unableToLoadImage.
  ///
  /// In en, this message translates to:
  /// **'Unable to load image'**
  String get unableToLoadImage;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @grocery.
  ///
  /// In en, this message translates to:
  /// **'Grocery'**
  String get grocery;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data is available'**
  String get noDataAvailable;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong !!'**
  String get somethingWentWrong;

  /// No description provided for @fullDescription.
  ///
  /// In en, this message translates to:
  /// **'Full Description'**
  String get fullDescription;

  /// No description provided for @scrollTypes.
  ///
  /// In en, this message translates to:
  /// **'Scroll Types'**
  String get scrollTypes;

  /// No description provided for @customScroll.
  ///
  /// In en, this message translates to:
  /// **'Custom Scroll'**
  String get customScroll;

  /// No description provided for @nestedScroll.
  ///
  /// In en, this message translates to:
  /// **'Nested Scroll'**
  String get nestedScroll;

  /// No description provided for @carousel.
  ///
  /// In en, this message translates to:
  /// **'Carousel'**
  String get carousel;

  /// No description provided for @pagination.
  ///
  /// In en, this message translates to:
  /// **'Pagination'**
  String get pagination;

  /// No description provided for @customScrollDescription.
  ///
  /// In en, this message translates to:
  /// **'The CustomScrollView in Flutter is a powerful scrolling widget that builds custom scroll effects using special, low-level widgets called slivers. Unlike ListView or SingleChildScrollView, which are designed for simple lists or single-screen content, CustomScrollView provides fine-grained control to combine different scrollable areas like lists, grids, and expanding app bars into a single, cohesive scrolling experience.'**
  String get customScrollDescription;

  /// No description provided for @nestedScrollDescription.
  ///
  /// In en, this message translates to:
  /// **'The Flutter NestedScrollView is a widget designed to coordinate scrolling between multiple nested scrollable areas, making them behave as a single, unified scrolling experience. It is commonly used in UIs that feature a flexible app bar with a TabBar and a TabBarView.'**
  String get nestedScrollDescription;

  /// No description provided for @paginationDescription.
  ///
  /// In en, this message translates to:
  /// **'Pagination in Flutter is a technique for efficiently loading and displaying large datasets in small, manageable chunks, which improves performance and user experience. The most common approach is infinite scrolling, where new data loads automatically as the user scrolls to the end of a list.'**
  String get paginationDescription;

  /// No description provided for @carouselDescription.
  ///
  /// In en, this message translates to:
  /// **'In Flutter, a carousel is a UI widget that displays a series of items like images or cards in a horizontally or vertically scrolling format, typically showing one item at a time with smooth transitions.'**
  String get carouselDescription;

  /// No description provided for @getLocalDbData.
  ///
  /// In en, this message translates to:
  /// **'Get Local DB Data'**
  String get getLocalDbData;

  /// No description provided for @noLocalDataAvailableToShow.
  ///
  /// In en, this message translates to:
  /// **'No local data is available to show'**
  String get noLocalDataAvailableToShow;

  /// No description provided for @addGroceryData.
  ///
  /// In en, this message translates to:
  /// **'Add Grocery Data'**
  String get addGroceryData;

  /// No description provided for @groceryName.
  ///
  /// In en, this message translates to:
  /// **'Grocery Name'**
  String get groceryName;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @grocerySavedLocally.
  ///
  /// In en, this message translates to:
  /// **'Grocery saved locally!'**
  String get grocerySavedLocally;

  /// No description provided for @pleaseSelectCategoryType.
  ///
  /// In en, this message translates to:
  /// **'Please select a category type'**
  String get pleaseSelectCategoryType;

  /// No description provided for @editGroceryItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Grocery Item'**
  String get editGroceryItem;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @itemUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Item updated successfully'**
  String get itemUpdatedSuccessfully;

  /// No description provided for @deleteItemQuestion.
  ///
  /// In en, this message translates to:
  /// **'Delete Item?'**
  String get deleteItemQuestion;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteItemConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \'{itemName}\'?'**
  String deleteItemConfirmation(Object itemName);

  /// No description provided for @itemDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'{itemName} deleted successfully'**
  String itemDeletedSuccessfully(Object itemName);

  /// No description provided for @selectField.
  ///
  /// In en, this message translates to:
  /// **'Select {label}'**
  String selectField(Object label);

  /// No description provided for @enterField.
  ///
  /// In en, this message translates to:
  /// **'Enter {label}'**
  String enterField(Object label);

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get enterValue;

  /// No description provided for @dotNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Dot is not allowed'**
  String get dotNotAllowed;

  /// No description provided for @spacesAreNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'Spaces are not allowed'**
  String get spacesAreNotAllowed;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// No description provided for @checkInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get checkInternetConnection;

  /// No description provided for @checkInternetConnectionLoud.
  ///
  /// In en, this message translates to:
  /// **'Check your Internet connection!!!'**
  String get checkInternetConnectionLoud;

  /// No description provided for @unableToConnectServerWithCode.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Unable to connect the Server!!!'**
  String unableToConnectServerWithCode(Object statusCode);

  /// No description provided for @unknownExceptionOccurred.
  ///
  /// In en, this message translates to:
  /// **'Unknown exception occurred'**
  String get unknownExceptionOccurred;

  /// No description provided for @unknownExceptionOccurredLoud.
  ///
  /// In en, this message translates to:
  /// **'Unknown Exception occurred!!!'**
  String get unknownExceptionOccurredLoud;

  /// No description provided for @somethingWentWrongLoud.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong !!'**
  String get somethingWentWrongLoud;

  /// No description provided for @unknownExceptionWithCode.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Unknown Exception occurred!!!'**
  String unknownExceptionWithCode(Object statusCode);

  /// No description provided for @notAuthorizedWithCode.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Not Authorized!!!'**
  String notAuthorizedWithCode(Object statusCode);

  /// No description provided for @timeoutException.
  ///
  /// In en, this message translates to:
  /// **'Timeout Exception !!!'**
  String get timeoutException;

  /// No description provided for @timeoutExceptionLoud.
  ///
  /// In en, this message translates to:
  /// **'Timeout Exception!!!'**
  String get timeoutExceptionLoud;

  /// No description provided for @pageNotFoundErrorWithCode.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Page not found error'**
  String pageNotFoundErrorWithCode(Object statusCode);

  /// No description provided for @unableToConnectServerShort.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Unable to connect server'**
  String unableToConnectServerShort(Object statusCode);

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Bad request'**
  String get badRequest;

  /// No description provided for @badRequestWithCode.
  ///
  /// In en, this message translates to:
  /// **'{statusCode} : Bad request'**
  String badRequestWithCode(Object statusCode);

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFound;

  /// No description provided for @internalServerError.
  ///
  /// In en, this message translates to:
  /// **'Internal server error'**
  String get internalServerError;

  /// No description provided for @unauthorizedNoAccess.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized, you don\'t have access'**
  String get unauthorizedNoAccess;

  /// No description provided for @dontWorryTeamIsWorkingOnIt.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry, team is working on it'**
  String get dontWorryTeamIsWorkingOnIt;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'te', 'ur'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'te':
      return AppLocalizationsTe();
    case 'ur':
      return AppLocalizationsUr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
