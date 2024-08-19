import 'package:abudiyab/language/locale.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:motion/motion.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../auth/signin/presentation/pages/signin_screen.dart';
import 'ad_gradient_btn.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({Key? key, required this.refresh, this.error})
      : super(key: key);
  final Function() refresh;
  final String? error;
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;

    if (error!.contains("Not Authenticated")  || error!.contains("Unauthenticated") ) {
      return Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Lottie.asset("assets/images/login.json")),
              SizedBox(height: 10.0),
              Motion(
                child: Bounce(
                    onTap: () {
                      pushNewScreen(
                        context,
                        screen: SignInScreen(),
                        withNavBar: false,
                      );
                    },
                    child: Column(
                      children: [
                        Text(locale!.loginToContinue.toString(),style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),),
                        SizedBox(height: 30.sp,),
                        ADGradientButton(
                          locale.signIn.toString(),
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      );
    } else
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/error.svg", height: size.height * 0.6, width: size.width),
            IconButton(
                onPressed: refresh,
                icon: Icon(
                  Icons.refresh,
                  size: 50,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
          ],
        ),
      );
  }
}
