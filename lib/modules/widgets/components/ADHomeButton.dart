import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/home_screen/home_screen.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:motion/motion.dart';


class ADHomeButton extends StatelessWidget {
  final bool isBackHandled;
  final VoidCallback? onPressed;

  const ADHomeButton({Key? key, this.onPressed, this.isBackHandled = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Motion(
      child: Bounce(
        onTap: isBackHandled ? onPressed : () => navigateAndFinish(context,HomeScreen()),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(child: Text(locale!.goHome.toString(),style: defaultTextStyle(14, FontWeight.w600, Theme.of(context).colorScheme.onPrimary),))],
        ),
      ),
    );
  }
}
