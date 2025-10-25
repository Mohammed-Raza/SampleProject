import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:sample_project/core/extensions/build_extensions.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/pages/pdf/animated_fab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/enums.dart';
import '../../bloc/dynamic_pdf/share_pdf_cubit.dart';

class ShareDynamicPdfScreen extends StatefulWidget {
  const ShareDynamicPdfScreen({super.key});

  @override
  State<ShareDynamicPdfScreen> createState() => _ShareDynamicPdfScreenState();
}

class _ShareDynamicPdfScreenState extends State<ShareDynamicPdfScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Share PDF')),
      body: BlocBuilder<SharePdfCubit, SharePdfState>(
        builder: (context, state) {
          return SizedBox(
            width: context.width,
            height: context.height,
            child: const Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(20),
                      Expanded(child: SharePdfTableView()),
                    ],
                  ),
                ),
                AnimatedFloatingActionButtons()
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
        return [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))];
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
