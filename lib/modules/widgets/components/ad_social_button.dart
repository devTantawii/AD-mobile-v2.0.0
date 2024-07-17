import 'package:abudiyab/language/locale.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ADSocialButtons extends StatelessWidget {
  final String? title;
  final Color color;
  ADSocialButtons({required this.title, required this.color});
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), gradient: gradient),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 15,
              child:
                Image(
                    image: title == locale.facebook
                        ? AssetImage('')
                        : AssetImage('')),
            ),
            Text(
              title!,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}
