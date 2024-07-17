import 'package:flutter/material.dart';

class DateRangeWidget extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final dynamic child;

  DateRangeWidget({required this.startDate, required this.endDate, required this.child});

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();

    if (currentDate.isAfter(startDate)
        && currentDate.isBefore(endDate)) {
      return child;
    } else {
      return Container();// Return an empty container if the date is outside the range
    }
  }
}