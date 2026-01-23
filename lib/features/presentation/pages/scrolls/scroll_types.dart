import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/utils/constants.dart';
import '../../../../config/routes/routes.dart';
import '../../../../core/device/adaptive_layout_builder.dart';
import '../../../../core/mixins/common_mixin.dart';
import '../../../../core/utils/enums.dart';

class ScrollTypesMainScreen extends StatefulWidget {
  const ScrollTypesMainScreen({super.key});

  @override
  State<ScrollTypesMainScreen> createState() => _ScrollTypesMainScreenState();
}

class _ScrollTypesMainScreenState extends State<ScrollTypesMainScreen> {
  List<(String, String, String)> homeCards = [
    ('Custom Scroll', Constants.customScrollDesc, Routes.customScrollFullPath),
    ('Nested Scroll', Constants.nestedScrollDesc, Routes.nestedScrollFullPath),
    ('Carousel', Constants.carouselDesc, Routes.carouselScrollFullPath),
    ('Pagination', Constants.paginationDesc, Routes.paginationScrollFullPath)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Scroll Types")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: AdaptiveLayoutBuilder(
            builder: (context, deviceType) => GridView.builder(
                itemCount: homeCards.length,
                addAutomaticKeepAlives: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.9,
                    crossAxisCount: switch (deviceType) {
                      DeviceResolutionType.mobile => 2,
                      DeviceResolutionType.tab => 3,
                      DeviceResolutionType.desktop => 6
                    }),
                itemBuilder: (_, index) {
                  var details = homeCards[index];
                  return _BuildScrollTypeCard(
                      title: details.$1,
                      description: details.$2,
                      route: details.$3);
                }),
          ),
        ));
  }
}

class _BuildScrollTypeCard extends StatelessWidget {
  final String title, description, route;
  const _BuildScrollTypeCard(
      {required this.title, required this.description, required this.route});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => context.go(route),
        customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              Text(title, style: context.headlineSmall),
              Text(description,
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              GestureDetector(
                onTap: () => CommonMixin.showFullDescription(
                    context, title, description),
                child: const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    "Read More...",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
