import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextTileBranch extends StatelessWidget {
  const TextTileBranch(
      {Key? key,
      required this.content,
      required this.title,
      required this.size})
      : super(key: key);
  final String title;
  final String? content;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: AutoSizeText(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp),
          ),
        ),
        // SizedBox(
        //   width: size,
        // ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: AutoSizeText(
              content!,
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp
              )),
        )
      ],
    );
  }
}
