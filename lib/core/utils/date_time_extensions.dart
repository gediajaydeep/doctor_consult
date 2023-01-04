import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String format(String format) {
    try {
      return DateFormat(format).format(this);
    } catch (e) {
      return '';
    }
  }
}
