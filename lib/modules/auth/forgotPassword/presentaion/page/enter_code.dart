import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password.state.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/page/change_password.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';

import '../../../../../core/constants/langCode.dart';
import '../../../../../shared/commponents.dart';
import '../../../../widgets/components/ad_curve.dart';

class EnterCodeScrean extends StatelessWidget {
  EnterCodeScrean({Key? key}) : super(key: key);
  final codeControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return Motion(
      child: Bounce(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
            listener: (context, state) {
              if (state is CodeError) {
                HelperFunctions.showFlashBar(
                  context: context,
                  title: locale!.error.toString(),
                  message: locale.oldCustCode.toString(),
                  icon: Icons.info,
                );
              }
              if (state is CodeLoaded) {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ChangePasswordScreen(),
                  ),
                );
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CurveWidget(
                      title:'',
                      subTitle:'',
                      positionTop: size.height*0.0,
                      positionBottom:size.height*0.0,
                      titleStyle: defaultTextStyle(24, FontWeight.w600, Colors.white),
                      subtitleStyle: defaultTextStyle(16, FontWeight.w400, Colors.white),
                      isHome: false,
                      forgetPasswordScreen: true,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height*0.05,
                          ),
                          Text(
                            locale!.enterCodeSent.toString(),
                            textAlign: TextAlign.center,
                            style: defaultTextStyle(26, FontWeight.w700, Theme.of(context).colorScheme.onPrimary),
                          ),
                          Text(
                            locale.isDirectionRTL(context)?"${"تم اسال رمز التحقق الي الرقم "+phoneStorage.toString()}":"Code Sent To: ${ phoneStorage.toString()}",
                            textAlign: TextAlign.center,
                            style: defaultTextStyle(14, FontWeight.w400,Theme.of(context).brightness==Brightness.light? Color(0xff515151):Colors.white70),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ADPrimTextForm(
                              controller: codeControler,
                              type: TextInputType.number,
                              label: locale.enterCode.toString(),
                              pIcon: Icons.password_outlined
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          state is CodeLoading
                              ? Center(
                            child: CircularProgressIndicator.adaptive(backgroundColor: Theme.of(context).colorScheme.onPrimary,),
                          )
                              : Motion(
                                child: Bounce(
                                                          onTap: () {
                                BlocProvider.of<ForgetPasswordCubit>(context)
                                    .sendCode(code: codeControler.text);
                                                          },
                                                          child: ADGradientButton(locale.send.toString()),
                                                        ),
                              ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
