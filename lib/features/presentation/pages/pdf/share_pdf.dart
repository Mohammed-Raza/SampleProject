import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_project/core/extensions/build_extensions.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/pages/pdf/animated_fab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../bloc/dynamic_pdf/share_pdf_cubit.dart';
import 'create_table.dart';

class ShareDynamicPdfScreen extends StatefulWidget {
  const ShareDynamicPdfScreen({super.key});

  @override
  State<ShareDynamicPdfScreen> createState() => _ShareDynamicPdfScreenState();
}

class _ShareDynamicPdfScreenState extends State<ShareDynamicPdfScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation,
      rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0)
    ]).animate(animationController);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0)
    ]).animate(animationController);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0)
    ]).animate(animationController);

    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<SharePdfCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Share PDF')),
      body: BlocBuilder<SharePdfCubit, SharePdfState>(
        builder: (context, state) {
          return SizedBox(
            width: context.width,
            height: context.height,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // const Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Expanded(child: SharePdfTableView()),
                //   ],
                // ),
                Positioned(
                    bottom: 30,
                    right: 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Transform(
                          transform: Matrix4.rotationZ(
                              getRadiansFromDegree(rotationAnimation.value)),
                          alignment: Alignment.center,
                          child: CircularActionButton(
                              height: 60,
                              width: 60,
                              icon: Icons.menu,
                              color: Colors.deepOrangeAccent,
                              onClick: () {
                                if (animationController.isCompleted) {
                                  animationController.reverse();
                                } else {
                                  animationController.forward();
                                }
                              }),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(270),
                              degOneTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(getRadiansFromDegree(
                                    rotationAnimation.value)) *
                                Matrix4.diagonal3Values(
                                  degOneTranslationAnimation.value,
                                  degOneTranslationAnimation.value,
                                  1.0,
                                ),
                            alignment: Alignment.center,
                            child: CircularActionButton(
                                height: 52,
                                width: 52,
                                icon: Icons.backup_table,
                                color: Colors.cyan,
                                onClick: () {
                                  debugPrint('table create');
                                }),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(225),
                              degTwoTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(getRadiansFromDegree(
                                    rotationAnimation.value)) *
                                Matrix4.diagonal3Values(
                                  degTwoTranslationAnimation.value,
                                  degTwoTranslationAnimation.value,
                                  1.0,
                                ),
                            alignment: Alignment.center,
                            child: CircularActionButton(
                                height: 52,
                                width: 52,
                                icon: Icons.share,
                                color: Colors.amberAccent,
                                onClick: () {
                                  debugPrint('share pdf');
                                }),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset.fromDirection(
                              getRadiansFromDegree(180),
                              degThreeTranslationAnimation.value * 100),
                          child: Transform(
                            transform: Matrix4.rotationZ(getRadiansFromDegree(
                                    rotationAnimation.value)) *
                                Matrix4.diagonal3Values(
                                  degThreeTranslationAnimation.value,
                                  degThreeTranslationAnimation.value,
                                  1.0,
                                ),
                            alignment: Alignment.center,
                            child: CircularActionButton(
                                height: 52,
                                width: 52,
                                icon: Icons.add,
                                color: Colors.teal,
                                onClick: () {
                                  debugPrint('add image');
                                }),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }
}

class SharePdfTableView extends StatelessWidget {
  const SharePdfTableView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharePdfCubit, SharePdfState>(
      builder: (context, state) {
        final cubit = context.read<SharePdfCubit>();
        final filteredColumns =
            cubit.tableColumns.where((e) => e.status).toList();

        if (filteredColumns.isEmpty) {
          return const SizedBox();
        }

        return Visibility(
          visible: filteredColumns.isNotEmpty,
          child: Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 50,
                  border: TableBorder.all(
                      borderRadius: BorderRadius.circular(8),
                      color: context.tableBorderColor),
                  columns: filteredColumns
                      .map((col) =>
                          DataColumn(label: Center(child: Text(col.name))))
                      .toList(),
                  rows: List.generate(cubit.tableRows.length, (rowIndex) {
                    final rowItems = cubit.tableRows[rowIndex];
                    return DataRow(
                      cells: List.generate(rowItems.length, (colIndex) {
                        final dataCell = rowItems[colIndex];

                        return DataCell(SizedBox.expand(
                          child: dataCell.type == TableColumnType.date
                              ? TextFieldWithDate(
                                  ctrl: dataCell.ctrl,
                                  onTap: () => cubit.onChangeDate(context,
                                      dataCell.ctrl, rowIndex, colIndex))
                              : TextFormField(
                                  controller: dataCell.ctrl,
                                  maxLength: 10,
                                  keyboardType: _getKeyboardType(dataCell.type),
                                  inputFormatters:
                                      _getInputFormatter(dataCell.type),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    counterText: '',
                                    fillColor: Colors.transparent,
                                    border: _border,
                                    focusedBorder: _border,
                                    enabledBorder: _border,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                  ),
                                ),
                        ));
                      }),
                    );
                  }),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder get _border => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));

  TextInputType _getKeyboardType(TableColumnType type) {
    switch (type) {
      case TableColumnType.name:
        return TextInputType.text;
      case TableColumnType.price:
        return const TextInputType.numberWithOptions(decimal: true);
      case TableColumnType.quantity:
        return TextInputType.number;
      case TableColumnType.date:
        return TextInputType.datetime;
    }
  }

  List<TextInputFormatter>? _getInputFormatter(TableColumnType type) {
    switch (type) {
      case TableColumnType.name:
      case TableColumnType.date:
        return null;
      case TableColumnType.price:
        return [FilteringTextInputFormatter.allow(RegExp(r'[0-9]+'))];
      case TableColumnType.quantity:
        return [FilteringTextInputFormatter.digitsOnly];
    }
  }
}

class TextFieldWithDate extends StatelessWidget {
  final TextEditingController ctrl;
  final Function()? onTap;
  const TextFieldWithDate({super.key, required this.ctrl, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: AlwaysDisabledFocusNode(),
      controller: ctrl,
      onTap: onTap,
      maxLines: 1,
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
          hintText: ctrl.text.isNotEmpty ? ctrl.text : 'Select Date',
          suffixIcon: const Icon(Icons.calendar_month),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border),
    );
  }

  get _border => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class CircularActionButton extends StatelessWidget {
  final double width, height;
  final Color color;
  final IconData icon;
  final Function() onClick;

  const CircularActionButton(
      {super.key,
      required this.height,
      required this.width,
      required this.icon,
      required this.color,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: IconButton(
            onPressed: onClick,
            enableFeedback: true,
            icon: Icon(icon, color: Colors.white)),
      ),
    );
  }
}


