import 'package:time_machine/time_machine.dart';

class Common {
  static String formatDate(DateTime dt) {
    return "${dt.day.toString()}/${dt.month.toString()}/${dt.year.toString()}";
  }

  static int getAge(DateTime dob) {
    LocalDate today = LocalDate.today();
    LocalDate dobLocal = LocalDate.dateTime(dob);

    return today.periodSince(dobLocal).years;
  }
}
