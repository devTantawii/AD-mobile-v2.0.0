import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ADBackButton extends StatelessWidget {
  final bool isBackHandled;
  final VoidCallback? onPressed;

  const ADBackButton({Key? key, this.onPressed, this.isBackHandled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return InkWell(
      onTap: isBackHandled ? onPressed : () => Navigator.of(context).pop(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.only(
                    left: locale!.isDirectionRTL(context) ? 6 : 10,
                    right: locale.isDirectionRTL(context) ? 20 : 6
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(
                  left: locale.isDirectionRTL(context) ? 0 : 10,
                  right: locale.isDirectionRTL(context) ? 10.sp: 0
              ),
              child: Text(locale.back.toString(),style: defaultTextStyle(14, FontWeight.w600, Theme.of(context).colorScheme.onPrimary),),
            )
          ],
        ),
      ),
    );
  }
}
