# Sample Project

A Flutter sample app that collects several production-style mobile patterns in one codebase: Firebase-backed groceries, push notifications, deep links, localization, theming, PDF sharing, SQLite CRUD, isolates, scroll demos, and WebSocket messaging.

The app supports Android, iOS, macOS, web, Windows, and Linux project shells, with Firebase options currently configured for Android, iOS, macOS, web, and Windows.

## Features

- Material 3 light, dark, and system theme support.
- Runtime branding through app flavors: `defaultFlavor`, `farmersMarket`, and `healthyFood`.
- Declarative navigation with `go_router`.
- Localization for English, Hindi, Telugu, and Urdu.
- Clean Architecture-inspired feature structure with data, domain, and presentation layers.
- State management with `bloc`, `flutter_bloc`, and `provider`.
- Firebase Core, Realtime Database, Cloud Messaging, and local notification handling.
- Android and iOS deep-link support for `https://farmers-market-c591f.web.app`.
- Grocery category and product browsing from Firebase Realtime Database.
- Product quantity adjustment and calculated totals.
- Dynamic PDF table creation and sharing with optional captured/gallery images.
- Image compression and watermarking demos using short-lived and long-lived isolates.
- Local SQLite CRUD using `sqflite`.
- Scroll examples: custom scroll, nested scroll, carousel, and infinite pagination.
- WebSocket echo-style messaging demo.
- Responsive layouts for mobile, tablet, and desktop widths.

## Main Screens

- `Home`: dashboard entry point for all demos.
- `Groceries`: category grid, product list, orders placeholder, and cart placeholder.
- `Push Notifications`: retrieves the FCM token and sends a Firebase Cloud Messaging request.
- `Share PDF`: builds a custom table, adds images, and shares a generated PDF.
- `SqfLite`: adds, edits, deletes, and groups local grocery data.
- `Isolates`: image compression with `compute` and repeated watermark generation with `Isolate.spawn`.
- `Scrolls`: examples for custom, nested, carousel, and pagination scrolling.
- `Web Socket`: sends text to a WebSocket channel and displays stream responses.
- `Profile`: theme and language preferences.

## Project Structure

```text
lib/
  config/               App routing and theme configuration
  core/                 Shared database, device, environment, Firebase, mixin, utility, and extension code
  features/
    data/               Remote/local data sources, models, repository implementations
    domain/             Entities, repository contracts, use cases
    presentation/       BLoCs, cubits, providers, pages, widgets, and UI components
  generated/            Generated asset references
  l10n/                 ARB files and generated localizations
assets/
  gifs/                 Error and empty-state animations
  images/               Grocery sample images
  logos/                Flavor logos
  splash/               Flavor splash images
android/ ios/ macos/    Platform flavor and Firebase configuration
web/ public/            Web app, Firebase messaging service worker, and hosting files
```

## Requirements

- Flutter SDK compatible with Dart `^3.5.4`.
- Android Studio or Xcode for mobile platform builds.
- CocoaPods for iOS/macOS dependency installation.
- Firebase project access if you want to replace the existing Firebase configuration.

## Setup

```sh
flutter pub get
flutter gen-l10n
```

Run static analysis:

```sh
flutter analyze
```

## Testing

The project is set up with three types of tests:

### 1. Unit Tests
Unit tests are used to test individual functions, methods, or classes in isolation.
Located in: `test/unit/`

Run unit tests:
```sh
flutter test test/unit
```

### 2. Widget Tests
Widget tests are used to test individual widgets or small UI components.
Located in: `test/widget/`

Run widget tests:
```sh
flutter test test/widget
```

### 3. Integration Tests
Integration tests are used to test the app as a whole, running on a real device or emulator.
Located in: `integration_test/`

Run integration tests:
```sh
flutter test integration_test
```
Note: Ensure a device or emulator is connected before running integration tests.

## Running The App

Default branding:

```sh
flutter run
```

Farmers Market flavor:

```sh
flutter run --flavor farmersMarket --dart-define=FLUTTER_APP_FLAVOR=farmersMarket
```

Healthy Food flavor:

```sh
flutter run --flavor healthyFood --dart-define=FLUTTER_APP_FLAVOR=healthyFood
```

For platforms without native Flutter flavor support, pass only the Dart define:

```sh
flutter run -d chrome --dart-define=FLUTTER_APP_FLAVOR=farmersMarket
```

## Build Examples

```sh
flutter build apk --flavor farmersMarket --dart-define=FLUTTER_APP_FLAVOR=farmersMarket
flutter build apk --flavor healthyFood --dart-define=FLUTTER_APP_FLAVOR=healthyFood
flutter build ios --flavor farmersMarket --dart-define=FLUTTER_APP_FLAVOR=farmersMarket
flutter build web --dart-define=FLUTTER_APP_FLAVOR=farmersMarket
```

iOS and macOS include shared schemes for `Runner`, `farmersMarket`, and `healthyFood`.

## Firebase

The app initializes Firebase from `lib/firebase_options.dart`.

Current Firebase-related files:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `macos/Runner/GoogleService-Info.plist`
- `web/firebase-messaging-sw.js`
- `assets/service_account.json`

`assets/service_account.json` is used by the push notification demo to obtain a Firebase Messaging OAuth token through `googleapis_auth`. For a real app, replace it with your own Firebase Admin SDK service account and avoid shipping production private keys in client assets.

Realtime Database endpoints are configured in `lib/features/data/data_sources/remote/urls.dart`.

## Deep Links And Hosting

The app routes from `/home` and supports nested paths such as:

- `/home/groceryHome`
- `/home/groceryHome/groceries/:type`
- `/home/pushNotificationsMain`
- `/home/dynamicPdfMain`
- `/home/sqfLiteMain`
- `/home/scrollsMain`
- `/home/webSocket`

Android app links are configured in `android/app/src/main/AndroidManifest.xml` for `farmers-market-c591f.web.app`.

Firebase Hosting is configured in `firebase.json` with SPA rewrites to `index.html` and JSON content-type headers for app-link association files.

Live reference:

```text
https://farmers-market-c591f.web.app/#/home
```

## Assets And Generated Files

Regenerate app icons:

```sh
dart run flutter_launcher_icons -f flutter_launcher_icons-farmersMarket.yaml
dart run flutter_launcher_icons -f flutter_launcher_icons-healthyFood.yaml
```

Regenerate splash screens:

```sh
dart run flutter_native_splash:create --path=flutter_native_splash-farmersMarket.yaml
dart run flutter_native_splash:create --path=flutter_native_splash-healthyFood.yaml
```

Regenerate JSON model files after editing annotated models:

```sh
dart run build_runner build --delete-conflicting-outputs
```

## Notes

- Linux Firebase options are not configured in `lib/firebase_options.dart`.
- The WebSocket demo connects to `wss://ws.ifelse.io`.
- The push notification flow uses local notifications for foreground display and navigates using the `path` value in notification data.
- ARB localization files live in `lib/l10n`; `l10n.yaml` uses `app_en.arb` as the template.
