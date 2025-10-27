import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_project/core/extensions/string_extensions.dart';
import '../../../../core/error/exception_handler.dart';
import '../../../../core/utils/enums.dart';
import '../../pages/pdf/pdf_creator.dart';
import '../../providers/media_provider.dart';

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

  final ImagePicker _picker = ImagePicker();

  String? processedImage;

  final ExceptionHandler _exceptionHandler = ExceptionHandler();

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

    PdfCreator(headersList, tableDataList, MediaQuery.of(context).size,
            capturedImages: processedImage != null ? [processedImage!] : [])
        .buildPdf();
  }

  /// Method is to capture picture / upload from gallery
  Future<void> onClickOfCamera({bool isCamera = true}) async {
    try {
      emit(ImageCaptureLoadingState());

      final XFile? capturedImage = await _picker.pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);

      if (capturedImage != null) {
        processedImage = await compute(processImage, capturedImage.path);
      }

      emit(SharePdfMainState());
    } catch (e) {
      _exceptionHandler.handleExceptionWithToastNotifier(e);
    }
  }

  void deleteProcessedImage() {
    processedImage = null;
    emit(SharePdfMainState());
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
