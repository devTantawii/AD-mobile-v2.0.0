import 'dart:math';

import 'package:abudiyab/language/locale.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final boxDecoration = BoxDecoration(
      // color: Theme.of(context).scaffoldBackgroundColor,

      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topLeft,
        colors: <Color>[
          Theme.of(context).scaffoldBackgroundColor,
          Theme.of(context).colorScheme.onSecondary,
        ],
      ),
    );
    return Stack(
      children: [
        Container(decoration: boxDecoration),

        // Pink Box
        Positioned(
          top: -100,
          left: locale!.isDirectionRTL(context) ? null : -40,
          right: locale.isDirectionRTL(context) ? -40 : null,
          child: _PinkBox(),
        ),
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5,
      child: Container(
        height: 360,
        width: 360,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.0),
              blurRadius: 1,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(80),
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topLeft,
            colors: <Color>[
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).colorScheme.primary.withOpacity(0.0),

              //Color(0xff3a3b55),
            ],
          ),
        ),
      ),
    );
  }
}
