import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../language/locale.dart';
class CountdownTimerWidget extends StatefulWidget {
  final DateTime targetDate;

  const CountdownTimerWidget({required this.targetDate});

  @override
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}
class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.targetDate.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _duration = widget.targetDate.difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final days = _duration.inDays;
    final hours = _duration.inHours.remainder(24);
    final minutes = _duration.inMinutes.remainder(60);
    final seconds = _duration.inSeconds.remainder(60);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/6.5,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme
                  .primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.sp)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.0.sp,horizontal: MediaQuery.of(context).size.width*0.01),
            child: Column(
              children: [
                Text(
                  '${NumberFormat('00').format(seconds)}',
                  style: TextStyle(fontSize: 16.sp,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                ),
                Text(
                  '${locale!.seconds}',
                  style: TextStyle(fontSize: 13.sp,color: Theme.of(context).colorScheme.primary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/6.5,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.sp)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.0.sp,horizontal: MediaQuery.of(context).size.width*0.01),
            child: Column(
              children: [
                Text(
                  '${NumberFormat('00').format(minutes)}',
                  style: TextStyle(fontSize: 16.sp,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                ),
                Text(
                  '${locale.minutes}',
                  style: TextStyle(fontSize: 13.sp,color: Theme.of(context).colorScheme.primary),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,

                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/6.5,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.sp)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.0.sp,horizontal: MediaQuery.of(context).size.width*0.01),
            child: Column(
              children: [
                Text(
                  '${NumberFormat('00').format(hours)}',
                  style: TextStyle(fontSize: 16.sp,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                ),
                Text(
                  '${locale.hour}',
                  style: TextStyle(fontSize: 12.sp,color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width/6.5,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6.sp)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(vertical: 5.0.sp,horizontal: MediaQuery.of(context).size.width*0.01),
            child: Column(
              children: [
                Text(
                  '${NumberFormat('00').format(days)}',
                  style: TextStyle(fontSize: 16.sp,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                ),
                Text(
                  '${locale.day}',
                  style: TextStyle(fontSize: 13.sp,color: Theme.of(context).colorScheme.primary),
                ),
              ],
            ),
          ),
        ),


        ///




      ],
    );
  }
}