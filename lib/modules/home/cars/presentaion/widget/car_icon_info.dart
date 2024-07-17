import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarIconInfo extends StatelessWidget {
  const CarIconInfo({Key? key, required this.image, required this.text})
      : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(2.0),
      width: MediaQuery.of(context).size.width * 0.22,
      height: MediaQuery.of(context).size.height * 0.055,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
         color:Colors.transparent,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: FittedBox(
        child: Column(
          children: [
            SizedBox(
                // width: 150.0,
                height: 50.0,
                child: Image.asset(
                  image,
                  color: Color(0xffF08A61),
                )),
            SizedBox(
              height: 10.0,
            ),
            AutoSizeText(
              "$text",
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
