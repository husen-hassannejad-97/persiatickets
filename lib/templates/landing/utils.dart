import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

String formatDate(DateTime date) {
  // Get the current year
  int currentYear = DateTime.now().year;

  // Map month numbers to their abbreviated names
  const List<String> monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Get day and month abbreviation
  String day = date.day.toString();
  String month = monthNames[date.month];

  // Combine into a formatted string
  String formattedDate = "$day. $month";

  // Append the year if it's not the current year
  if (date.year != currentYear) {
    formattedDate += " ${date.year}";
  }

  return formattedDate;
}

String formatFullDate(DateTime date) {
  const List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  const List<String> monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Get day of week, day, month abbreviation, and year
  String dayOfWeek = weekDays[date.weekday - 1];
  String day = date.day.toString();
  String month = monthNames[date.month];
  String year = date.year.toString();

  return "$dayOfWeek, $day. $month $year";
}

String formatTimeWithoutYear(DateTime date) {
  const List<String> weekDays = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  const List<String> monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  // Get day of week, day, month abbreviation, and year
  String dayOfWeek = weekDays[date.weekday - 1];
  String day = date.day.toString();
  String month = monthNames[date.month];

  return "$dayOfWeek, $day. $month";
}

String formatTimeHourMinutes(DateTime date) {
  String formattedTime = DateFormat('HH:mm').format(date);

  return formattedTime;
}

String formatPrice(double price) {
  final formatter = NumberFormat('#,##0');
  String formattedPrice = formatter.format(price);

  return formattedPrice;
}

String formatTime(DateTime date) {
  // Pad hours and minutes to ensure two digits
  String hour = date.hour.toString().padLeft(2, '0');
  String minute = date.minute.toString().padLeft(2, '0');

  return "$hour:$minute";
}

int indexLoopMapper(int index, int loopSize) =>
    index < 0 ? loopSize - 1 : index % loopSize;

// Function to launch the URL
Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);

  // Check if the device can launch the URL
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
