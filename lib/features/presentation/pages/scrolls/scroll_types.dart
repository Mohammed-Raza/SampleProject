import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/device/adaptive_layout_builder.dart';
import '../../../../core/mixins/common_mixin.dart';
import '../../../../core/utils/enums.dart';
import '../../widgets/responsive_page.dart';

class ScrollTypesMainScreen extends StatefulWidget {
  const ScrollTypesMainScreen({super.key});

  @override
  State<ScrollTypesMainScreen> createState() => _ScrollTypesMainScreenState();
}

class _ScrollTypesMainScreenState extends State<ScrollTypesMainScreen> {
  @override
  Widget build(BuildContext context) {
    final homeCards = [
      (
        context.l10n.customScroll,
        context.l10n.customScrollDescription,
        Routes.customScrollFullPath
      ),
      (
        context.l10n.nestedScroll,
        context.l10n.nestedScrollDescription,
        Routes.nestedScrollFullPath
      ),
      (
        context.l10n.carousel,
        context.l10n.carouselDescription,
        Routes.carouselScrollFullPath
      ),
      (
        context.l10n.pagination,
        context.l10n.paginationDescription,
        Routes.paginationScrollFullPath
      )
    ];
    return ResponsivePage(
        title: context.l10n.scrollTypes,
        scrollable: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ResponsiveHeroPanel(
              icon: Icons.view_day_outlined,
              title: context.l10n.scrollTypes,
              description: context.l10n.scrollsDescription,
              trailing: [
                MetricPill(
                    label: context.l10n.modules, value: '${homeCards.length}')
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: AdaptiveLayoutBuilder(
                builder: (context, deviceType) => GridView.builder(
                    itemCount: homeCards.length,
                    addAutomaticKeepAlives: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: switch (deviceType) {
                          DeviceResolutionType.mobile => 0.95,
                          DeviceResolutionType.tab => 1.0,
                          DeviceResolutionType.desktop => 1.08
                        },
                        crossAxisCount: switch (deviceType) {
                          DeviceResolutionType.mobile => 1,
                          DeviceResolutionType.tab => 3,
                          DeviceResolutionType.desktop => 4
                        }),
                    itemBuilder: (_, index) {
                      var details = homeCards[index];
                      return _BuildScrollTypeCard(
                          title: details.$1,
                          description: details.$2,
                          route: details.$3);
                    }),
              ),
            ),
          ],
        ));
  }
}

class _BuildScrollTypeCard extends StatelessWidget {
  final String title, description, route;
  const _BuildScrollTypeCard(
      {required this.title, required this.description, required this.route});

  @override
  Widget build(BuildContext context) {
    return ResponsivePanel(
      onTap: () => context.go(route),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Icon(Icons.auto_awesome_motion_rounded,
              color: Theme.of(context).colorScheme.primary),
          Text(title, style: context.titleLarge),
          Text(description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: context.bodyMedium),
          const Spacer(),
          GestureDetector(
            onTap: () =>
                CommonMixin.showFullDescription(context, title, description),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                context.l10n.readMore,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
