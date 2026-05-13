import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sample_project/core/extensions/context_extension.dart';

class CarouselScrollScreen extends StatefulWidget {
  const CarouselScrollScreen({super.key});

  @override
  State<CarouselScrollScreen> createState() => _CarouselScrollScreenState();
}

class _CarouselScrollScreenState extends State<CarouselScrollScreen> {
  final List<String> imageUrls = [
    'https://i0.wp.com/picjumbo.com/wp-content/uploads/digital-art-dark-natural-scenery-with-a-large-sun-and-another-planet-free-image.jpeg?w=600&quality=80',
    'https://static.vecteezy.com/system/resources/thumbnails/001/978/310/small/beautiful-dusk-at-mountains-scenery-free-vector.jpg',
    'https://images.vexels.com/media/users/3/152233/raw/d1c25eeb5eb601bc9f9603291ae6b3c9-christmas-winter-scenery-background.jpg',
    'https://img.freepik.com/premium-vector/flat-minimalistic-design-panorama-mountain-landscape-easy-change-colors_653461-2483.jpg?semt=ais_hybrid&w=740&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    // The anchor for the scroll view
    const Key centerKey = ValueKey<String>('carousel-anchor');

    return Scaffold(
      body: CustomScrollView(
        center: centerKey,
        slivers: <Widget>[
          // 1. PINNED APP BAR WITH CAROUSEL PLUGIN
          SliverAppBar(
            key: centerKey,
            pinned: true,
            expandedHeight: 280.0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            // title: const Text("Carousel Scroll View"),
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider(
                options: CarouselOptions(
                  height: 320,
                  autoPlay: true,
                  viewportFraction: 1.0, // Full width images
                  enlargeCenterPage: false,
                ),
                items: imageUrls.map((url) {
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, progress) =>
                        progress == null
                            ? child
                            : const Center(child: CircularProgressIndicator()),
                  );
                }).toList(),
              ),
            ),
          ),

          // 2. THE PINNED DATA HEADER
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
                  "Pinned Data Section",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),

          // 3. SCROLLABLE LIST CONTENT
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: ListTile(
                    title: Text("List Item ${index + 1}",
                        style: context.titleMedium),
                    subtitle: const Text("Scroll to see headers pin"),
                  ),
                ),
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

// Delegate for the Sticky Header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _StickyHeaderDelegate(
      {required this.minHeight, required this.maxHeight, required this.child});

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
