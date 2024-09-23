import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../language/locale.dart';

void showErrorAlertDialog(BuildContext context, String content) {
  final locale = AppLocalizations.of(context);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber,
              color: Colors.red,
            ),
            SizedBox(width: 8.0),
            Text(
              locale!.isDirectionRTL(context) ? "خطأ" : "Error",
              style: TextStyle(color: Colors.red, fontSize: 18.sp),
            ),
          ],
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Color(0xffffffff),
      );
    },
  );
}
