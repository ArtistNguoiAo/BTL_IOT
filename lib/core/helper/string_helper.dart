import 'package:intl/intl.dart';

class StringHelper {
  static String convertTimeToString(String time) {
    DateTime dateTime = DateTime.parse(time).toLocal();
    return DateFormat('dd-MM-yyyy\nHH:mm:ss').format(dateTime);
  }

  static String convertStringToOffsetDateTime(String dateTimeString) {
    return DateFormat('dd-MM-yyyy HH:mm:ss').parse(dateTimeString).toUtc().toIso8601String();
  }

}