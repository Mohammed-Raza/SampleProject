import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/mixins/helper_mixin.dart';
import 'package:sample_project/core/mixins/language_mixin.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import 'package:sample_project/features/presentation/pages/groceries/cart.dart';
import 'package:sample_project/features/presentation/widgets/common_widgets.dart';
import 'package:sample_project/features/presentation/widgets/page_error.dart';
import '../../../../core/device/adaptive_layout_builder.dart';
import '../../widgets/home_widgets.dart';
import '../groceries/orders.dart';

class GroceriesHomePage extends StatefulWidget {
  const GroceriesHomePage({super.key});

  @override
  State<GroceriesHomePage> createState() => _GroceriesHomePageState();
}

class _GroceriesHomePageState extends State<GroceriesHomePage> {
  int selectedIndex = 0;
  static const List<Widget> widgets = <Widget>[
    GroceriesMainBody(),
    OrdersScreen(),
    CartPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Groceries Home')),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
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

class GroceriesMainBody extends StatefulWidget {
  const GroceriesMainBody({super.key});

  @override
  State<GroceriesMainBody> createState() => _GroceriesMainBodyState();
}

class _GroceriesMainBodyState extends State<GroceriesMainBody>
    with LanguageMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuildTheView());
    super.initState();
  }

  afterBuildTheView() =>
      context.read<GroceriesBloc>().add(LoadGroceryCategoryEvent());
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GroceriesBloc>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: BlocBuilder<GroceriesBloc, GroceriesState>(
          bloc: bloc,
          buildWhen: (p, c) => c is CategoriesMainState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (GroceriesInitial):
              case const (CategoriesLoading):
                return const CircularIndicator();
              case const (CategoriesSuccess):
                var successState = state as CategoriesSuccess;
                if (successState.categories.isEmpty) {
                  return const Center(
                      child: Text('No categories are available to show'));
                }
                return Column(
                  children: [
                    Expanded(
                      child: AdaptiveLayoutBuilder(
                        builder: (context, deviceType) => GridView.builder(
                            itemCount: successState.categories.length,
                            addAutomaticKeepAlives: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 20,
                                    childAspectRatio: 0.9,
                                    crossAxisCount: switch (deviceType) {
                                      DeviceResolutionType.mobile => 2,
                                      DeviceResolutionType.tab => 3,
                                      DeviceResolutionType.desktop => 5
                                    }),
                            itemBuilder: (_, index) {
                              var category = successState.categories[index];
                              return GroceryCard(
                                  id: category.id,
                                  groceryKey: category.key,
                                  groceryType: HelperMixin.enumFromString(
                                          GroceryType.values, category.key) ??
                                      GroceryType.veggies);
                            }),
                      ),
                    ),
                  ],
                );
              case const (CategoriesError):
                var errorState = state as CategoriesError;
                return PageErrorWidget(
                    errorText: errorState.errorDetails.$1,
                    errorImage: errorState.errorDetails.$2);
              default:
                return Container();
            }
          }),
    );
  }
}
