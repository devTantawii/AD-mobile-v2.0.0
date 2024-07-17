import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../shared/style/colors.dart';

class CardTileWidget extends StatelessWidget {
   CardTileWidget(
      {Key? key, required this.title,  this.icon, required this.ontap, this.isLogout})
      : super(key: key);
  final String title;
  final String? icon;
   final bool? isLogout;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16.sp,
                ),
          ),
          isLogout==true?Container():Icon(Icons.arrow_forward_ios_rounded,size: 22,),
        ],
      ),
      leading: FittedBox(
        child: SizedBox(
            width: 25.0,
            height: 25.0,
            child: SvgPicture.asset(
              icon.toString(),
              // color: Color(0xffD62E2E),
            )
        ),
      ),
      onTap: ontap,
    );
  }
}
