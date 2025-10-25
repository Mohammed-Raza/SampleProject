import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/string_extensions.dart';
import '../../../../core/utils/enums.dart';
import '../../pages/pdf/pdf_creator.dart';

part 'share_pdf_state.dart';

class SharePdfCubit extends Cubit<SharePdfState> {
  SharePdfCubit() : super(SharePdfInitial());

  final List<TableColumData> tableColumns = [
    TableColumData('Name', TableColumnType.name),
    TableColumData('Price', TableColumnType.price),
    TableColumData('Quantity', TableColumnType.quantity),
    TableColumData('Date', TableColumnType.date)
  ];

  int rowsCount = 0;

  List<List<TableRowData>> tableRows = [];

  void onChangeOfCheckBox(TableColumData cellData) {
    cellData.status = !cellData.status;
    setTable();
  }

  void subtractRow() {
    if (rowsCount <= 0) return;
    --rowsCount;
    emit(SharePdfMainState());
  }

  void addRow() {
    if (rowsCount >= 15) return;
    ++rowsCount;
    emit(SharePdfMainState());
  }

  void setTable() {
    tableRows.clear();
    var filteredColumns = tableColumns.where((e) => e.status).toList();
    tableRows = List.generate(rowsCount, (_) {
      return List.generate(
          filteredColumns.length,
          (index) => TableRowData(TextEditingController(),
              filteredColumns[index].type, DateTime.now()));
    });
    emit(SharePdfMainState());
  }

  void onChangeDate(BuildContext context, TextEditingController ctrl,
      int rowIndex, int columnIndex) {
    var tableCell = tableRows[rowIndex][columnIndex];
    FocusScope.of(context).requestFocus(FocusNode());
    showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      initialDate: tableCell.dateTime,
    ).then((date) {
      if (date != null) {
        tableCell.dateTime = date;
        ctrl.text = date.toString().getHalfMonthDateFormat();
        emit(SharePdfMainState());
      }
    });
  }

  void onClickOfSharePdf(BuildContext context) {
    var filteredColumns = tableColumns.where((e) => e.status).toList();
    List<String> headersList = filteredColumns.map((e) => e.name).toList();

    var tableDataList = List.generate(tableRows.length, (index) {
      var tableCell = tableRows[index];
      return tableCell.map((e) => e.ctrl.text.trim()).toList();
    }).toList();

    PdfCreator(headersList, tableDataList, MediaQuery.of(context).size)
        .buildPdf();
  }
}

class TableColumData {
  final String name;
  final TableColumnType type;
  bool status;
  TableColumData(this.name, this.type, {this.status = false});
}

class TableRowData {
  final TextEditingController ctrl;
  final TableColumnType type;
  DateTime dateTime;
  TableRowData(this.ctrl, this.type, this.dateTime);
}
