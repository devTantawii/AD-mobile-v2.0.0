import 'package:abudiyab/core/constants/palette.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class SimpleHomePageIcons extends StatelessWidget {
  final IconData icon;
  final size;
  final padding;

  SimpleHomePageIcons(this.icon, this.size, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Palette.iconBgColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(50),
      ),
      child:
        Icon(
          icon,
          size: size,
          color: Colors.white,
        ),

    );
  }
}

class HomePageIcons extends StatelessWidget {
  final IconData icon;
  final size;
  final padding;

  HomePageIcons(this.icon, this.size, this.padding);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color(0xff3fa0d7),
              blurRadius: 1.0,
              spreadRadius: 0.3,
            )
          ]),
      child:
        Icon(
          icon,
          size: size,
          color: Colors.white,
        ),

    );
  }
}

