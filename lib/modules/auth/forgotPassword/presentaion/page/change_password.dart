import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/core/helpers/validation/validation.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password.state.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/bloc/forget_password_cubit.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/page/successPage.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
// import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../shared/commponents.dart';
import '../../../../widgets/components/ad_curve.dart';


class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  final newPasswordControler = TextEditingController();
  final confirmPasswordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
          listener: (context, state) {
            if (state is ChangePassWordError) {
              HelperFunctions.showFlashBar(
                context: context,
                title: locale!.error.toString(),
                message: state.error,
                icon: Icons.info_outline,
              );
            }
            if (state is ChangePasswordLoaded) {
              // HelperFunctions.showFlashBar(
              //   context: context,
              //   title: locale!.done.toString(),
              //   message: locale.passwordChanged.toString(),
              //   icon: Icons.info_outline,
              // );
              Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SuccessPage(),
                ),
                (_) => false,
              );
              phoneStorage==null;
            }
          },
          builder: (context, state) {
            return
              SingleChildScrollView(
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
                    SizedBox(
                      height: size.height*0.05,
                    ),
                    ADPrimTextForm(
                      controller: newPasswordControler,
                      type: TextInputType.visiblePassword,
                      label: locale!.newPassword.toString(),
                      pIcon: Icons.lock,
                      validat: (value) =>
                          Validate.validatePassword(context, value),
                    ),
                    SizedBox(height: 20.0),
                    ADPrimTextForm(
                      controller: confirmPasswordControler,
                      type: TextInputType.visiblePassword,
                      label: locale.confirmPassword.toString(),
                      pIcon: Icons.lock,
                      validat: (value) => Validate.validatePassword(
                          context, newPasswordControler.text,
                          confirmPassword: value),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    state is ChangePasswordLoading
                        ? Center(
                            child: CircularProgressIndicator.adaptive())
                        : InkWell(
                            onTap: () {
                              BlocProvider.of<ForgetPasswordCubit>(context)
                                  .passwordchange(
                                      password: newPasswordControler.text,
                                      confirmPassword: confirmPasswordControler.text);
                            },
                            child: ADGradientButton(
                                locale.changePassword.toString())),
                  ]),
                );

          },
        ),
      ),
    );
  }
}
