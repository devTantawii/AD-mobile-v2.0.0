import 'package:flutter/material.dart';

class DateHandler {
  static mixDateWithHours(DateTime date, String hour) =>
      DateTime.parse(date.toString().replaceRange(11, 16, hour))
          .toString()
          .substring(0, 19);

  static mixDateWithHoursToUnix(DateTime date, String hour) =>
      DateTime.parse(date.toString().replaceRange(11, 16, hour))
          .microsecondsSinceEpoch
          .toString()
          .substring(0, 10);

  static timeOfDayToHour(TimeOfDay timeOfDay) => timeOfDay
      .toString()
      .replaceAll("TimeOfDay", "")
      .replaceAll("(", "")
      .replaceAll(")", "");
}
