import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static const String _displayFormat = 'dd MMM yyyy';
  static const String _apiFormat = 'yyyy-MM-dd';
  static const String _displayWithTimeFormat = 'dd MMM yyyy, HH:mm';
  static const String _timeFormat = 'HH:mm';

  static String toDisplay(DateTime date) =>
      DateFormat(_displayFormat).format(date);

  static String toApi(DateTime date) => DateFormat(_apiFormat).format(date);

  static String toDisplayWithTime(DateTime date) =>
      DateFormat(_displayWithTimeFormat).format(date);

  static String toTime(DateTime date) => DateFormat(_timeFormat).format(date);

  static DateTime fromApi(String date) =>
      DateFormat(_apiFormat).parse(date);
}
