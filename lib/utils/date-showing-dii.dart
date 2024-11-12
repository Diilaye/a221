import 'package:intl/intl.dart';

String showDate(String date) {
  // Parse the input date string to a DateTime object
  DateTime parsedDate = DateTime.parse(date);

  // Set the locale to French
  DateFormat customFormat = DateFormat("EEEE, d MMMM yyyy, HH:mm:ss", 'fr');

  // Format the parsed DateTime object
  String customFormatted = customFormat.format(parsedDate);

  return '${customFormatted.split(',')[0]},${customFormatted.split(',')[1]}';
}
