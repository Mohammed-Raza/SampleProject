import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';

class CustomScrollScreen extends StatefulWidget {
  const CustomScrollScreen({super.key});

  @override
  State<CustomScrollScreen> createState() => _CustomScrollScreenState();
}

class _CustomScrollScreenState extends State<CustomScrollScreen> {
  List<int> top = <int>[];
  List<int> bottom = <int>[0];

  @override
  Widget build(BuildContext context) {
    // Slivers before this key scroll "up" from the center.
    // Slivers at/after this key scroll "down" from the center.
    const Key centerKey = ValueKey<String>('top-content-anchor');

    return Scaffold(
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          // 2. PINNED APP BAR
          // We use the centerKey here so it is the start of the "positive" flow
          const SliverAppBar(
            key: centerKey,
            pinned: true,
            expandedHeight: 210.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Custom Scroll View"),
              background: _ScrollHero(
                icon: Icons.view_stream_outlined,
                description:
                    "Pinned app bars, persistent headers, and slivers.",
              ),
            ),
          ),

          // 3. PINNED DATA HEADER
          // This will stack/pin underneath the SliverAppBar
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              minHeight: 60.0,
              maxHeight: 60.0,
              child: Container(
                color: Theme.of(context).colorScheme.primary,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  "Pinned Section: Main Data",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),

          // 4. MAIN LIST DATA
          SliverList.builder(
            itemCount: bottom.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
                ),
                height: 100,
                child: Text('Bottom Item: ${bottom[index]}',
                    style: context.titleMedium),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          setState(() {
            top.add(-top.length - 1);
            bottom.add(bottom.length);
          });
        },
      ),
    );
  }
}

class _ScrollHero extends StatelessWidget {
  final IconData icon;
  final String description;

  const _ScrollHero({
    required this.icon,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary,
            colorScheme.tertiary.withValues(alpha: 0.74),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 44, 20, 60),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 42),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                description,
                style: context.bodyLarge?.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_StickyHeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
