import 'package:abudiyab/modules/widgets/components/ad_dialog.dart';
import 'package:abudiyab/modules/widgets/components/constants.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelperFunctions {
  static void showFlashBar({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
    Color? color,
    Color? titlcolor,
    Color? iconColor,
    bool showProgressIndicator = true,
  }) {
    showFlash(
      context: context,
      duration: const Duration(milliseconds: 3000),
      builder: (context, controller) {
        return FlashBar(
          controller: controller,
          position: FlashPosition.top,
          // horizontalDismissDirection: HorizontalDismissDirection.startToEnd,
          margin: EdgeInsets.symmetric(horizontal: 10.0.sp),
          forwardAnimationCurve: Curves.easeOutBack,
          reverseAnimationCurve: Curves.slowMiddle,
          // borderRadius: BorderRadius.circular(4),
          backgroundColor: color ?? Colors.blue,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: titlcolor, fontSize: 14.sp),
          ),
          content: Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: titlcolor, fontSize: 14.sp),
          ),
          icon: Icon(icon, color: iconColor),
        );
      },
    );
  }
  static dialog({
    required BuildContext context,
    required String title,
    required String body,
  }) => showDialog(context: context,
          builder: (context) => ADErrorDialog(title: title, body: body));

  static statusDialog({
    required BuildContext context,
    required bool status,
  }) => showDialog(context: context,
          builder: (context) => ADStatusDialog(status: status));
}
