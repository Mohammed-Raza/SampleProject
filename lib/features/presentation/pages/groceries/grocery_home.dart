import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.groceriesHome)),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            _bottomNavigationItem(label: context.l10n.home, icon: Icons.home),
            _bottomNavigationItem(
              label: context.l10n.orders,
              icon: Icons.assignment_outlined,
            ),
            _bottomNavigationItem(
              label: context.l10n.cart,
              icon: Icons.shopping_cart_outlined,
            )
          ],
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withValues(alpha: 0.08),
              colorScheme.surfaceContainerLow,
              colorScheme.surface,
            ],
          ),
        ),
        child: widgets[selectedIndex],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationItem(
      {required String label, required IconData icon}) {
    final colorScheme = Theme.of(context).colorScheme;

    return BottomNavigationBarItem(
      backgroundColor: colorScheme.surfaceContainerLowest,
      activeIcon: BuildActiveItemView(label: label, icon: icon),
      icon: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: colorScheme.outlineVariant),
          shape: BoxShape.circle,
          color: colorScheme.surfaceContainerLowest,
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: colorScheme.primary),
      ),
      label: '',
    );
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

  void afterBuildTheView() =>
      context.read<GroceriesBloc>().add(LoadGroceryCategoryEvent());

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroceriesBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withValues(alpha: isDark ? 0.68 : 0.88),
                  colorScheme.secondary.withValues(alpha: isDark ? 0.34 : 0.78),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 16),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.freshGroceriesThoughtfullyPresented,
                  style: context.headlineMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10n.pickCategoryBrowseHandpickedEssentials,
                  style: context.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<GroceriesBloc, GroceriesState>(
              bloc: bloc,
              buildWhen: (p, c) => c is CategoriesMainState,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case const (GroceriesInitial):
                  case const (CategoriesLoading):
                    return const CircularIndicator();
                  case const (CategoriesSuccess):
                    final successState = state as CategoriesSuccess;
                    if (successState.categories.isEmpty) {
                      return Center(
                        child: Text(context.l10n.noCategoriesAvailableToShow),
                      );
                    }
                    return AdaptiveLayoutBuilder(
                      builder: (context, deviceType) => GridView.builder(
                        itemCount: successState.categories.length,
                        addAutomaticKeepAlives: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: switch (deviceType) {
                            DeviceResolutionType.mobile => 0.76,
                            DeviceResolutionType.tab => 0.94,
                            DeviceResolutionType.desktop => 0.96
                          },
                          crossAxisCount: switch (deviceType) {
                            DeviceResolutionType.mobile => 2,
                            DeviceResolutionType.tab => 3,
                            DeviceResolutionType.desktop => 5
                          },
                        ),
                        itemBuilder: (_, index) {
                          final category = successState.categories[index];
                          return GroceryCard(
                            id: category.id,
                            groceryKey: category.key,
                            groceryType: HelperMixin.enumFromString(
                                  GroceryType.values,
                                  category.key,
                                ) ??
                                GroceryType.veggies,
                          );
                        },
                      ),
                    );
                  case const (CategoriesError):
                    final errorState = state as CategoriesError;
                    return PageErrorWidget(
                      errorText: errorState.errorDetails.$1,
                      errorImage: errorState.errorDetails.$2,
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
