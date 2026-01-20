import 'package:go_router/go_router.dart';
import 'package:sample_project/config/routes/routes.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/presentation/pages/fcm/push_notifications.dart';
import 'package:sample_project/features/presentation/pages/groceries/grocery_home.dart';
import 'package:sample_project/features/presentation/pages/home.dart';
import 'package:sample_project/features/presentation/pages/groceries/grocery.dart';
import 'package:sample_project/features/presentation/pages/isolates/isolates_main.dart';
import 'package:sample_project/features/presentation/pages/pdf/share_pdf.dart';
import 'package:sample_project/features/presentation/pages/profile/profile.dart';
import 'package:sample_project/features/presentation/pages/sqflite/sqflite_main.dart';
import 'package:sample_project/global_variables.dart';

class Routing {
  static final GoRouter router =
      GoRouter(initialLocation: Routes.homePath, routes: <RouteBase>[
    GoRoute(
        name: Routes.home,
        path: Routes.homePath,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              name: Routes.profile,
              path: Routes.profilePath,
              builder: (context, state) => const ProfileScreen()),
          GoRoute(
              name: 'Grocery Home',
              path: Routes.groceryHome,
              builder: (context, state) => const GroceriesHomePage(),
              routes: [
                GoRoute(
                    name: 'Groceries Main',
                    path: '/${Routes.groceriesMain}/:type',
                    builder: (context, state) {
                      final typeStr = state.pathParameters['type']!;
                      final type = GroceryType.values.firstWhere(
                          (e) => e.name == typeStr,
                          orElse: () => GroceryType.veggies);
                      return GroceriesMainScreen(groceryType: type);
                    })
              ]),
          GoRoute(
              name: 'Isolates',
              path: Routes.isolatesMain,
              builder: (context, state) => const IsolatesMainScreen()),
          GoRoute(
              name: 'PN',
              path: Routes.pushNotificationsMain,
              builder: (context, state) => const PushNotificationsScreen()),
          GoRoute(
              name: 'DynamicPdf',
              path: Routes.dynamicPdfMain,
              builder: (context, state) => const ShareDynamicPdfScreen()),
          GoRoute(
              name: 'LocalDB',
              path: Routes.sqfLiteMain,
              builder: (context, state) => const SqfLiteMain()),
        ]),
  ]);

  static redirectToHome({int index = 0}) {
    var context = navigatorKey.currentContext!;
    while (GoRouter.of(context).canPop()) {
      GoRouter.of(context).pop();
    }

    GoRouter.of(context).pushReplacement(Routes.home, extra: index);
  }
}
