import 'package:abudiyab/shared/style/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';


class ADGradientButton extends StatelessWidget {
  final String? title;
  final double? width;

  ADGradientButton(this.title, {this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white.withOpacity(0.0)),
          borderRadius: BorderRadius.circular(6)),
      child: Container(
        height: size.height * 0.053,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: kButtonColor
        ),
        child: Center(
            child: AutoSizeText(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white),
        )),
      ),
    );
  }
}
