import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/environments/environment.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/firebase/firebase_messaging.dart';
import 'package:sample_project/core/utils/enums.dart';
import '../../../config/routes/routes.dart';
import '../../../core/device/adaptive_layout_builder.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    FirebasePushNotifications()
      ..initiateTheFirebaseListeners()
      ..clearNotificationBadge();
    FirebasePushNotifications.initializeLocalPushNotifications();
    super.initState();
  }

  final List<(IconData, String, String, String, {bool isFaIcon})> homeCards = [
    (
      Icons.dashboard,
      'groceries',
      'groceriesHomeDescription',
      Routes.groceryHomePath,
      isFaIcon: false
    ),
    (
      Icons.code,
      'isolates',
      'isolatesDescription',
      Routes.isolatesMainPath,
      isFaIcon: false
    ),
    (
      Icons.notifications_active,
      'pushNotifications',
      'pushNotificationsDescription',
      Routes.pushNotificationsMainPath,
      isFaIcon: false
    ),
    (
      Icons.share,
      'sharePdf',
      'sharePdfDescription',
      Routes.dynamicPdfMainPath,
      isFaIcon: false
    ),
    (
      FontAwesomeIcons.database,
      'sqfLite',
      'sqfLiteDescription',
      Routes.sqfLiteMainPath,
      isFaIcon: true
    ),
    (
      FontAwesomeIcons.scroll,
      'scrolls',
      'scrollsDescription',
      Routes.scrollsMainPath,
      isFaIcon: true
    ),
    (
      FontAwesomeIcons.cloudflare,
      'webSocket',
      'webSocketDescription',
      Routes.webSocketPath,
      isFaIcon: true
    )
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 76,
        title: Text(Environment().configuration.orgName),
        leadingWidth: 76,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest.withValues(alpha: 0.92),
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                Environment().configuration.logoPath,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton.filledTonal(
              onPressed: () => context.goNamed(Routes.profile),
              icon: const Icon(Icons.person_outline_rounded),
            ),
          )
        ],
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
        child: SafeArea(
          top: false,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  context.width < 600 ? 16 : 24,
                  8,
                  context.width < 600 ? 16 : 24,
                  20,
                ),
                child: AdaptiveLayoutBuilder(
                  builder: (context, deviceType) => CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: _HomeHeroCard(homeCardsCount: homeCards.length),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 24),
                        sliver: SliverGrid.builder(
                          itemCount: homeCards.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: switch (deviceType) {
                              DeviceResolutionType.mobile => 0.78,
                              DeviceResolutionType.tab => 1.0,
                              DeviceResolutionType.desktop => 0.95
                            },
                            crossAxisCount: switch (deviceType) {
                              DeviceResolutionType.mobile => 2,
                              DeviceResolutionType.tab => 3,
                              DeviceResolutionType.desktop => 4
                            },
                          ),
                          itemBuilder: (_, index) {
                            final details = homeCards[index];
                            return _BuildHomeCard(
                              icon: details.$1,
                              title: _localizedValue(context, details.$2),
                              description: _localizedValue(context, details.$3),
                              route: details.$4,
                              isFaIcon: details.isFaIcon,
                              index: index,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _localizedValue(BuildContext context, String key) {
  final l10n = context.l10n;
  return switch (key) {
    'groceries' => l10n.groceries,
    'groceriesHomeDescription' => l10n.groceriesHomeDescription,
    'isolates' => l10n.isolates,
    'isolatesDescription' => l10n.isolatesDescription,
    'pushNotifications' => l10n.pushNotifications,
    'pushNotificationsDescription' => l10n.pushNotificationsDescription,
    'sharePdf' => l10n.sharePdf,
    'sharePdfDescription' => l10n.sharePdfDescription,
    'sqfLite' => l10n.sqfLite,
    'sqfLiteDescription' => l10n.sqfLiteDescription,
    'scrolls' => l10n.scrolls,
    'scrollsDescription' => l10n.scrollsDescription,
    'webSocket' => l10n.webSocket,
    'webSocketDescription' => l10n.webSocketDescription,
    _ => key,
  };
}

class _HomeHeroCard extends StatelessWidget {
  final int homeCardsCount;

  const _HomeHeroCard({required this.homeCardsCount});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary,
            colorScheme.primary.withValues(alpha: isDark ? 0.74 : 0.82),
            colorScheme.secondary.withValues(alpha: isDark ? 0.34 : 0.16),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.28),
            blurRadius: 32,
            offset: const Offset(0, 20),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              context.l10n.exploreSampleApp,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            context.l10n.beautifulDemosOnePolishedEntryPoint,
            style: context.displaySmall?.copyWith(
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n
                .browseGroceriesNotificationsPdfsSocketsStorageDemosAndMore,
            style: context.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _StatChip(value: '$homeCardsCount', label: context.l10n.modules),
              const SizedBox(width: 12),
              _StatChip(value: '1', label: context.l10n.homeHub),
            ],
          )
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String value;
  final String label;

  const _StatChip({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(8),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$value ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            TextSpan(
              text: label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildHomeCard extends StatelessWidget {
  final String title;
  final String description;
  final String route;
  final IconData icon;
  final bool isFaIcon;
  final int index;

  const _BuildHomeCard(
      {required this.title,
      required this.description,
      required this.icon,
      required this.route,
      required this.isFaIcon,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final accentColors = <Color>[
      colorScheme.primary,
      const Color(0xFFBC6C25),
      const Color(0xFF588157),
      const Color(0xFF4361EE),
      const Color(0xFFE76F51),
      const Color(0xFF6D597A),
      const Color(0xFF2A9D8F),
    ];
    final accent = accentColors[index % accentColors.length];

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.18),
            colorScheme.surfaceContainerLowest.withValues(alpha: 0.96),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.14),
            blurRadius: 20,
            offset: const Offset(0, 14),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.go(route),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: isFaIcon
                        ? FaIcon(icon, size: 24, color: accent)
                        : Icon(icon, size: 26, color: accent),
                  ),
                ),
                const Spacer(),
                Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontSize: 18,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.bodyMedium?.copyWith(
                    height: 1.35,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Text(
                      context.l10n.open,
                      style: textTheme.labelLarge?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.arrow_forward_rounded, color: accent, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
