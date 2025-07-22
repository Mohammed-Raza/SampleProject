import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/mixins/language_mixin.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/presentation/pages/dashboard/cart.dart';
import '../../../../config/routes/routes.dart';
import '../../../../generated/assets.dart';
import '../../widgets/home_widgets.dart';
import 'orders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  static const List<Widget> widgets = <Widget>[
    DashboardScreen(),
    OrdersScreen(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text('Home Page'),
            actions: [
              IconButton(
                  onPressed: () => context.goNamed(Routes.profile),
                  icon: const Icon(Icons.person, size: 30))
            ],
            backgroundColor: Theme.of(context).colorScheme.inversePrimary),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
              backgroundColor: Colors.amber.shade200,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                _bottomNavigationItem(label: 'Home', icon: Icons.home),
                _bottomNavigationItem(
                    label: 'Orders', icon: Icons.assignment_outlined),
                _bottomNavigationItem(
                    label: 'Cart', icon: Icons.shopping_cart_outlined)
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped),
        ),
        body: widgets[selectedIndex]);
  }

  BottomNavigationBarItem _bottomNavigationItem(
      {required String label, required IconData icon}) {
    return BottomNavigationBarItem(
        backgroundColor: Colors.white,
        activeIcon: BuildActiveItemView(label: label, icon: icon),
        icon: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.teal.shade200),
                shape: BoxShape.circle,
                color: Colors.teal.shade50),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: Colors.teal)),
        label: '');
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with LanguageMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              childAspectRatio: 0.9,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                GroceryCard(
                    name: translate(context).vegetables,
                    assetPath: Assets.imagesVeggies,
                    groceryType: GroceryType.veggies),
                GroceryCard(
                    name: translate(context).fruits,
                    assetPath: Assets.imagesFruits,
                    groceryType: GroceryType.fruits),
                GroceryCard(
                    name: translate(context).milkProducts,
                    assetPath: Assets.imagesMilk,
                    groceryType: GroceryType.milkProducts),
                GroceryCard(
                    name: translate(context).cookies,
                    assetPath: Assets.imagesCakes,
                    groceryType: GroceryType.cookies)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
