import 'package:intl/intl.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/extensions/integer_extension.dart';

extension StringFormat on String {
  String getHalfMonthDateFormat({isTimeRequired = false}) {
    try {
      DateTime? dateTime = this.getDateFromString();
      var day = dateTime?.day;
      var month = dateTime?.month;
      var year = dateTime?.year;

      if (isTimeRequired) {
        return '${day?.getNumberWithName()} ${month?.getShortMonthNames().toUpperCase()} $year, ${this.getTime()}';
      }
      return '$day ${month?.getShortMonthNames()} $year';
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
      return '';
    }
  }

  String getTime() {
    try {
      var dateTime = this.getDateFromString();
      return dateTime != null ? DateFormat.jm().format(dateTime) : '';
    } on Exception catch (e, stackTrace) {
      ExceptionHandler().handleException(e);
      return '';
    }
  }

  DateTime? getDateFromString() {
    if (this.trim().isEmpty) return null;
    try {
      var dateTime = DateTime.tryParse(this)?.toLocal();
      return dateTime;
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
      return null;
    }
  }
}
