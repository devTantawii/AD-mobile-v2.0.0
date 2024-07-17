import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ADColoredTextButton extends StatefulWidget {
  final String text;
  bool isSelected;
  final VoidCallback onTap;

  ADColoredTextButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ADColoredTextButton> createState() => _ADColoredTextButtonState();
}

class _ADColoredTextButtonState extends State<ADColoredTextButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isSelected = !widget.isSelected;
          widget.onTap();
        });
        // print(isSelected);
      },
      child: Container(
        // padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        // width: MediaQuery.of(context).size.width * 0.25,
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.5,
            maxHeight: MediaQuery.of(context).size.width * 0.09,),
        // height: 5,
        decoration: BoxDecoration(
          color: widget.isSelected?Theme.of(context).colorScheme.primary:Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.5),
          border: Border.all(
            color: widget.isSelected?Theme.of(context).colorScheme.onPrimary:Colors.transparent,
            width: 1.2
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            widget.text,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 20.0.sp,
                color: widget.isSelected ?Colors.white:Theme.of(context).colorScheme.primary
            ),
          ),
        ),
      ),
    );
  }
}
