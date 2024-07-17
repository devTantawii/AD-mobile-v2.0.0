import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/layout_screan/layout_screan.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/style/colors.dart';

class ADHomeButton extends StatelessWidget {
  final bool isBackHandled;
  final VoidCallback? onPressed;

  const ADHomeButton({Key? key, this.onPressed, this.isBackHandled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return InkWell(
      onTap: isBackHandled ? onPressed : () => navigateAndFinish(context,LayoutScreen()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: Text(locale!.goHome.toString(),style: defaultTextStyle(14, FontWeight.w600, Theme.of(context).colorScheme.onPrimary),))],
      ),
    );
  }
}
