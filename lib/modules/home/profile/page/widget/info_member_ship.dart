import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoMemnerShip extends StatelessWidget {
  const InfoMemnerShip({
    Key? key,
    required this.data,
    required this.title,
    required this.svgPic,
  }) : super(key: key);
  final String data;
  final String title;
  final String svgPic;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(svgPic),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                left: 10.0,
                right: 10.0,
              ),
              child: Text.rich(
                TextSpan(
                  text: "$title :  ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 14.sp),
                  children: [
                    TextSpan(
                        text: data,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14.sp))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
