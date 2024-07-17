import 'package:abudiyab/modules/auth/signin/presentation/pages/signin_screen.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../language/locale.dart';
import '../../../../widgets/components/ad_gradient_btn.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/success.svg'),
                SizedBox(height: size.height*0.05,),
                Text(locale!.passwordChanged.toString(),
                  textAlign: TextAlign.center,
                  style: defaultTextStyle(34, FontWeight.w700, Colors.black),),
                SizedBox(height: size.height*0.05,),
                GestureDetector(onTap:(){
                  navigateAndFinish(context, SignInScreen());
                },child: ADGradientButton(locale.goToHome)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
