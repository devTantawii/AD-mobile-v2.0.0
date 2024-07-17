
import 'dart:ui';

import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password.state.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/page/enter_code.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/langCode.dart';
import '../../../../../shared/commponents.dart';
import '../../../../widgets/components/ad_curve.dart';
import '../../../../widgets/components/ad_prim_text_form/ad_prim_text_form.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPassWordError) {
            HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.error,
              icon: Icons.info_outline,
            );
          }
          if (state is ForgetPasswordLoaded) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => EnterCodeScrean(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            // appBar: AppBar(
            //   leading: ADBackButton(),
            // ),
          body: SingleChildScrollView(
            child: Column(
              children:[
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
                SizedBox(height: 10),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Text(
                        locale.resetPassword.toString(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      Text(
                        locale.isDirectionRTL(context)?'أدخل رقم الهاتف المرتبط بحسابك وسنرسل رسالة كود التحقق  لإعادة تعيين كلمة المرور الخاصة بك.':'Enter Phone Number Associated With Your Account And We Will Send A message With OTP Code To Reset Your Password.',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 40),
                      ADPrimTextForm(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: locale.phoneNumber.toString(),
                        pIcon: Icons.phone,
                        validat: (value) {
                          value?.isEmpty;
                          return null;
                        },
                        auth: true,
                      ),
                      SizedBox(height: 40),
                      state is ForgetPasswordLoading
                          ? Center(
                          child: CircularProgressIndicator.adaptive(
                            backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          ))
                          : GestureDetector(
                          onTap: (){
                            BlocProvider.of<ForgetPasswordCubit>(context)
                                .sendPone(phone: phoneController.text);
                            phoneStorage =phoneController.text;
                          },
                          child:  defaultButton(context,Text(locale.send.toString(),style: defaultTextStyle(16, FontWeight.w700, Colors.white),)))
                    ],
                  ),
                ),
              ],
            ),
          ),
          );
        },
      ),
    );
  }

}
