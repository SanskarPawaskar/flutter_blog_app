import 'package:intl/intl.dart';

String formatDateDDMMMYYYY(DateTime dateTime) {
  return DateFormat("d MMM, yyyy").format(dateTime);
}
