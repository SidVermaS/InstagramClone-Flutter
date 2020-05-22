import 'package:intl/intl.dart';

class DateModifiers {
  String dateTimeToddMMyyyy(DateTime dateTime)  {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
  String dateTimeToHHmmaddMMyyyy(DateTime dateTime)  {
    return DateFormat('hh:mm a\t\t\tdd/MM/yyyy').format(dateTime);
  }
  String timestampToddMMMyyyyHHmm(int timestamp)  {
    return DateFormat('dd MMM yyyy HH:mm').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
  String timestampToddMMMyyyy(int timestamp)  {
    return DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }
  String dateTimeToEddMMMyyyy(DateTime dateTime) {
    return DateFormat('E, dd MMM yyyy').format(dateTime);
  }
  String dateTimeToEddMMMyQQQQ(DateTime dateTime) {
    return DateFormat('E, dd MMM y').format(dateTime);
  }
  DateTime timestampToDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  DateTime ddMMyyyyToDateTime(String dateTimeString) {
    return DateFormat('dd-MM-yyyy').parse(dateTimeString);
  }
}