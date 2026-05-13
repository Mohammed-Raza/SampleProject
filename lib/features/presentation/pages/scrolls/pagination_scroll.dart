import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/widgets/responsive_page.dart';

class PaginationScrollScreen extends StatefulWidget {
  const PaginationScrollScreen({super.key});

  @override
  State<PaginationScrollScreen> createState() => _PaginationScrollScreenState();
}

class _PaginationScrollScreenState extends State<PaginationScrollScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<int> _items = List.generate(20, (index) => index + 1);
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadMoreWhenNeeded);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsivePage(
      title: "Pagination Scroll",
      scrollable: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ResponsiveHeroPanel(
            icon: Icons.format_list_numbered_rounded,
            title: "Pagination Scroll",
            description:
                "A responsive list that appends a small batch as you approach the end.",
            trailing: [MetricPill(label: "Items", value: '${_items.length}')],
          ),
          const SizedBox(height: 18),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _items.length + (_loading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _items.length) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ResponsivePanel(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(child: Text('${_items[index]}')),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Paged list item ${_items[index]}',
                            style: context.titleMedium,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_right_rounded),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _loadMoreWhenNeeded() {
    final position = _scrollController.position;
    if (_loading || position.pixels < position.maxScrollExtent - 240) return;
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      final start = _items.length + 1;
      _items.addAll(List.generate(10, (index) => start + index));
      setState(() => _loading = false);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
