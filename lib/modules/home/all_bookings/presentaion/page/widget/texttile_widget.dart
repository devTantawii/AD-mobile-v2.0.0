import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTileWidget extends StatelessWidget {
  const TextTileWidget(
      {Key? key,
      required this.contant,
      required this.title,
      required this.size})
      : super(key: key);
  final String title;
  final String contant;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 92.sp,
          child: AutoSizeText(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
            ),
          ),
        ),
        // SizedBox(
        //   width: size,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: AutoSizeText(contant,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700
            )
          ),
        )
      ],
    );
  }
}
