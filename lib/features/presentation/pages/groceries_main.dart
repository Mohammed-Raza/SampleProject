import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/extensions/widget_extensions.dart';
import 'package:sample_project/core/mixins/common_mixin.dart';
import 'package:sample_project/core/utils/constants.dart';
import 'package:sample_project/core/utils/enums.dart';
import 'package:sample_project/features/data/models/groceries_model.dart';
import 'package:sample_project/features/presentation/bloc/groceries/groceries_bloc.dart';
import '../widgets/add_qty_field.dart';
import '../widgets/common_widgets.dart';
import '../widgets/page_error.dart';

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

  afterTheBuild() =>
      context.read<GroceriesBloc>().add(LoadGroceriesEvent(widget.groceryType));
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GroceriesBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade200,
        title: Text(widget.groceryType.name.toUpperCase()),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, context.bottomPadding),
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
                    return const Center(
                        child: Text('No grocery items are available to show'));
                  }
                  return RefreshIndicator(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: successState.groceries.length,
                          itemBuilder: (context, index) {
                            GroceriesModel grocery =
                                successState.groceries[index];
                            return _GroceryItemCard(grocery: grocery);
                          }),
                      onRefresh: () async => afterTheBuild());
                case const (GroceryItemsError):
                  var errorState = state as GroceryItemsError;
                  return PageErrorWidget(
                      errorText: errorState.pageErrorDetails.$1,
                      errorImage: errorState.pageErrorDetails.$2,
                      retry: afterTheBuild);
                default:
                  return Container();
              }
            }),
      ),
    );
  }
}

class _GroceryItemCard extends StatelessWidget {
  final GroceriesModel grocery;
  const _GroceryItemCard({required this.grocery});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<GroceriesBloc>();
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BuildImagesCarousel(images: grocery.images!),
          Text(grocery.name!,
              style: GoogleFonts.poppins(
                  fontSize: 17, fontWeight: FontWeight.bold)),
          Text(grocery.content!, style: GoogleFonts.poppins(fontSize: 14)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  '${Constants.rupee} ${CommonMixin.getNumberWithCommas(grocery.totalAmount.toStringAsFixed(2))}',
                  style: GoogleFonts.alatsi(
                      fontWeight: FontWeight.w500, fontSize: 20, color: Colors.teal)),
              AddQtyTextField(
                controller: grocery.controller,
                onAdd: () => bloc.add(AddOutQtyEvent(grocery)),
                onSubtract: () => bloc.add(SubtractOutQtyEvent(grocery)),
                onClickOfTextField: (val) =>
                    bloc.add(ChangeOutQtyEvent(grocery, val)),
              )
            ],
          )
        ],
      ).mainDecorations(),
    );
  }
}

class _BuildImagesCarousel extends StatelessWidget {
  final List<String> images;
  const _BuildImagesCarousel({required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: CarouselSlider.builder(
          itemCount: images.length,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
                  _buildImageFullView(context, images[itemIndex]),
          options: CarouselOptions(
            aspectRatio: 1.8,
            viewportFraction: 1,
            autoPlay: images.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            initialPage: 0,
            scrollDirection: Axis.horizontal,
            reverse: false,
          )),
    );
  }

  Widget _buildImageFullView(BuildContext context, String imgUrl) {
    return Container(
        width: context.width,
        height: context.height / 4.2,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: Colors.grey, width: 0.7)),
        child: BuildCachedNetworkImage(imageUrl: imgUrl));
  }
}
