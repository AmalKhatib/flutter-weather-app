import 'package:intl/intl.dart';

String getCurrentDate(){
  String date;

  var now = new DateTime.now();
  var formatter = new DateFormat('EEE, MMM d, yyyy');
  //var dayOfWeek = DateFormat('EEEE').format(now);
  date = formatter.format(now);

  return date;
}