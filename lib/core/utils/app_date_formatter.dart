import 'package:intl/intl.dart';

class AppDateFormatter {
  AppDateFormatter._();

  static String formatReviewDate(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy | hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }
}