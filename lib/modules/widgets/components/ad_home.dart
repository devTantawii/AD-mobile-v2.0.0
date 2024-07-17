import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/layout_screan/layout_screan.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';

import '../../home/all_bookings/presentaion/page/all_booking_screen.dart';

class AdHomeButton extends StatelessWidget {
  final bool isBackHandled;
  final VoidCallback? onPressed;

  const AdHomeButton({Key? key, this.onPressed, this.isBackHandled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: isBackHandled ? onPressed : () =>
            navigateAndFinish(context, LayoutScreen()),
        child: Container(
          padding: EdgeInsets.only(
              left: locale!.isDirectionRTL(context) ? 8 : 8,
              right: locale.isDirectionRTL(context) ? 8 : 8
          ),
          decoration: BoxDecoration(
              color: Color(0xff505AC9),
              borderRadius: BorderRadius.circular(8),
              ),
          child: Center(
              child: Icon(
                Icons.home_outlined,
                size: 22,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
