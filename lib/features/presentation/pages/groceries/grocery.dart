import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/common_mixin.dart';
import 'package:sample_project/core/utils/constants.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/domain/entities/groceries_entity.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import '../../widgets/add_qty_field.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/page_error.dart';

class GroceriesMainScreen extends StatefulWidget {
  final GroceryType groceryType;

  const GroceriesMainScreen({super.key, required this.groceryType});

  @override
  State<GroceriesMainScreen> createState() => _GroceriesMainScreenState();
}

class _GroceriesMainScreenState extends State<GroceriesMainScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterTheBuild());
    super.initState();
  }

  void afterTheBuild() => context
      .read<GroceriesBloc>()
      .add(LoadGroceriesEvent(widget.groceryType.name));

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroceriesBloc>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(CommonMixin.getGroceryName(context, widget.groceryType)),
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
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Padding(
              padding: EdgeInsets.fromLTRB(context.width < 600 ? 14 : 24, 6,
                  context.width < 600 ? 14 : 24, context.bottomPadding),
              child: BlocBuilder<GroceriesBloc, GroceriesState>(
                bloc: bloc,
                builder: (context, state) {
                  switch (state.runtimeType) {
                    case const (GroceriesInitial):
                    case const (GroceryItemsLoading):
                      return const CircularIndicator();
                    case const (GroceryItemsSuccess):
                      final successState = state as GroceryItemsSuccess;
                      if (successState.groceries.isEmpty) {
                        return Center(
                          child:
                              Text(context.l10n.noGroceryItemsAvailableToShow),
                        );
                      }
                      return RefreshIndicator(
                        onRefresh: () async => afterTheBuild(),
                        child: CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          slivers: [
                            SliverToBoxAdapter(
                              child: _GroceriesHero(
                                  groceryType: widget.groceryType),
                            ),
                            SliverPadding(
                              padding:
                                  const EdgeInsets.only(top: 18, bottom: 12),
                              sliver: SliverLayoutBuilder(
                                builder: (context, constraints) {
                                  final crossAxisExtent =
                                      constraints.crossAxisExtent;
                                  final deviceType = switch (crossAxisExtent) {
                                    < 600 => DeviceResolutionType.mobile,
                                    < 1024 => DeviceResolutionType.tab,
                                    _ => DeviceResolutionType.desktop,
                                  };
                                  final childAspectRatio = switch (deviceType) {
                                    DeviceResolutionType.mobile => 0.83,
                                    DeviceResolutionType.tab => 0.9,
                                    DeviceResolutionType.desktop => 0.84
                                  };
                                  final crossAxisCount = switch (deviceType) {
                                    DeviceResolutionType.mobile => 1,
                                    DeviceResolutionType.tab => 2,
                                    DeviceResolutionType.desktop => 3
                                  };

                                  return SliverGrid.builder(
                                    itemCount: successState.groceries.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 20,
                                      crossAxisSpacing: 20,
                                      childAspectRatio: childAspectRatio,
                                      crossAxisCount: crossAxisCount,
                                    ),
                                    itemBuilder: (_, index) => _GroceryItemCard(
                                      grocery: successState.groceries[index],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    case const (GroceryItemsError):
                      final errorState = state as GroceryItemsError;
                      return PageErrorWidget(
                        errorText: errorState.pageErrorDetails.$1,
                        errorImage: errorState.pageErrorDetails.$2,
                        retry: afterTheBuild,
                      );
                    default:
                      return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GroceriesHero extends StatelessWidget {
  final GroceryType groceryType;

  const _GroceriesHero({required this.groceryType});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withValues(alpha: isDark ? 0.72 : 0.92),
            colorScheme.secondary.withValues(alpha: isDark ? 0.28 : 0.82),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${CommonMixin.getGroceryName(context, groceryType).toUpperCase()} ${context.l10n.collectionSuffix}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            context.l10n.freshPicksCleanerShoppingExperience,
            style: context.headlineMedium?.copyWith(
              color: Colors.white,
              height: 1.08,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.swipeScanAdjustDescription,
            style: context.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroceryItemCard extends StatelessWidget {
  final GroceriesEntity grocery;

  const _GroceryItemCard({required this.grocery});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroceriesBloc>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.surfaceContainerLowest.withValues(alpha: 0.98),
            colorScheme.surfaceContainerLow.withValues(alpha: 0.96),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BuildImagesCarousel(images: grocery.images!),
              const SizedBox(height: 14),
              Text(
                grocery.name!,
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  grocery.content!,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    height: 1.42,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainer.withValues(alpha: 0.72),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.price,
                            style: textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${Constants.rupee} ${CommonMixin.getNumberWithCommas(grocery.totalAmount.toStringAsFixed(2))}',
                            style: textTheme.titleLarge?.copyWith(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AddQtyTextField(
                      controller: grocery.controller,
                      onAdd: () => bloc.add(AddOutQtyEvent(grocery)),
                      onSubtract: () => bloc.add(SubtractOutQtyEvent(grocery)),
                      onClickOfTextField: (val) =>
                          bloc.add(ChangeOutQtyEvent(grocery, val)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildImagesCarousel extends StatelessWidget {
  final List<String> images;

  const _BuildImagesCarousel({required this.images});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            _buildImageFullView(context, images[itemIndex]),
        options: CarouselOptions(
          aspectRatio: 1.5,
          viewportFraction: 1,
          autoPlay: images.length > 1,
          autoPlayInterval: const Duration(seconds: 4),
          initialPage: 0,
          scrollDirection: Axis.horizontal,
          reverse: false,
        ),
      ),
    );
  }

  Widget _buildImageFullView(BuildContext context, String imgUrl) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: context.width,
      height: context.height / 4.2,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.75),
        ),
      ),
      child: BuildCachedNetworkImage(
        imageUrl: imgUrl,
        borderRadius: 8,
      ),
    );
  }
}
