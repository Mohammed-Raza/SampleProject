import 'package:go_router/go_router.dart';
import 'package:sample_project/config/routes/routes.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/presentation/pages/dashboard/home.dart';
import 'package:sample_project/features/presentation/pages/groceries_main.dart';
import 'package:sample_project/features/presentation/pages/profile/profile.dart';

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
  ]);
}
