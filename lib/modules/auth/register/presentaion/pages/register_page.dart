import  'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/core/helpers/validation/form_validator.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/blocs/auth_bloc/onboarding_cubt_cubit.dart';
import 'package:abudiyab/modules/auth/register/presentaion/bloc/register_cubit.dart';
import 'package:abudiyab/modules/home/profile/page/privacy_policy/privacy_policy.dart';
import 'package:abudiyab/modules/widgets/components/ad_curve.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/fade_route.dart';
import '../../../../../service_locator.dart';
import '../../../signin/presentation/pages/signin_screen.dart';

class RegisterPage extends StatefulWidget {
  final Function()? isLogin;
  final OnBoardingCubit? onBoardingCubit;
  final bool pushAddition;

  const RegisterPage({
    Key? key,
    this.isLogin,
    this.onBoardingCubit,
    this.pushAddition = false,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var idNumberController = TextEditingController();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAgreeTerms = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    // var safeHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size;

    return BlocProvider<RegisterCubit>(
      create: (context) => sl<RegisterCubit>(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            widget.pushAddition
                ? Navigator.of(context).pop(true)
                : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => SignInScreen()),
              ModalRoute.withName('/'),
            );
            HelperFunctions.showFlashBar(
                context: context,
                title: '',
                message: locale.isDirectionRTL(context)?'تم انشاء الحساب  بنجاح':'Account has been created Successfully',
                titlcolor: Color(0xff327B5B),
                icon: Icons.check,
                iconColor: Color(0xff327B5B)
            );
            ///go to home
            // widget.pushAddition
            //     ? Navigator.of(context).pop(true)
            //     : Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute<void>(
            //             builder: (BuildContext context) => LayoutScreen()),
            //         ModalRoute.withName('/'),
            //       );
          } else if (state is RegisterError) {
            navigateAndFinish(context, SignInScreen());

            ///show FlashBar when error is happening
            HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.massage.toString(),
              icon: Icons.info_outline,
                color: Color(0xffF6A9A9),
                titlcolor: Color(0xffD62E2E),
                iconColor: Color(0xffD62E2E)
            );
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                   // physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CurveWidget(
                          title: locale.welcomeAtAbudiyab.toString(),
                          subTitle: locale.welcomeAtAbudiyabsubTitle.toString(),
                          positionTop: size.height*0.1,
                          positionBottom:size.height*0.16,
                          titleStyle: defaultTextStyle(24, FontWeight.w600, Colors.white),
                          subtitleStyle: defaultTextStyle(14, FontWeight.w500, Colors.white),
                          isHome: false,
                          forgetPasswordScreen: false,
                        ),
                       Padding(
                         padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                         child: Column(
                           children: [
                             SizedBox(
                               height: 10.sp,
                             ),
                             Form(
                               key: _formKey,
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 children: [
                                   ADPrimTextForm(
                                     controller: idNumberController,
                                     type: TextInputType.text,
                                     label: locale.enterIdAndNumber.toString(),
                                     pIcon: Icons.person_outlined,
                                     validat: (value) =>
                                         FormValidator.nameValidate(
                                             context, value),
                                     auth: true,
                                   ),
                                   SizedBox(height: 10),
                                   ADPrimTextForm(
                                     controller: emailController,
                                     type: TextInputType.emailAddress,
                                     label: locale.emailAddress.toString(),
                                     pIcon: Icons.email_outlined,
                                     validat: (value) =>
                                         FormValidator.emailValidate(
                                             context, value),
                                     auth: true,
                                   ),
                                   SizedBox(height: 10),
                                   ADPrimTextForm(
                                     controller: passwordController,
                                     type: TextInputType.visiblePassword,
                                     label: locale.password.toString(),
                                     pIcon: Icons.lock_outline,
                                     validat: (value) =>
                                         FormValidator.passwordValidate(
                                             context, value),
                                     auth: true,
                                   ),
                                   SizedBox(height: 10),
                                   ADPrimTextForm(
                                     controller: confirmPasswordController,
                                     type: TextInputType.visiblePassword,
                                     label: locale.confirmPassword.toString(),
                                     pIcon: Icons.lock_outline,
                                     validat: (value) =>
                                         FormValidator.passwordConfirmValidate(
                                             context,
                                             passwordController.text,
                                             value),
                                     auth: true,
                                   ),
                                   SizedBox(height: 10),
                                   ADPrimTextForm(
                                     inputFormatters: [
                                       new LengthLimitingTextInputFormatter(10),
                                     ],
                                     controller: phoneController,
                                     type: TextInputType.phone,
                                     label: locale.phoneNumber.toString(),
                                     pIcon: Icons.phone,
                                     validat: (value) =>
                                         FormValidator.phoneValidate(
                                             context, value),
                                     auth: true,
                                   ),

                                   ///------------------------05-----------------------
                                   // Row(
                                   //    children: [
                                   //      // Container(
                                   //      //   height: size.height * 0.053,
                                   //      //   child: Text(
                                   //      //     ' 05 ',
                                   //      //     style: TextStyle(
                                   //      //       fontWeight: FontWeight.bold,
                                   //      //       fontSize: 16,
                                   //      //     ),
                                   //      //   ),
                                   //      //   decoration: BoxDecoration(
                                   //      //       border: Border.all(
                                   //      //           color: Colors.blueAccent,
                                   //      //           width: 1.5),
                                   //      //       borderRadius:
                                   //      //           BorderRadius.circular(7)),
                                   //      // ),
                                   //      // Container(
                                   //      //   width: size.width*0.008,
                                   //      //   height: size.height*0.04,
                                   //      //   color: Colors.black54,
                                   //      // ),
                                   //      // SizedBox(
                                   //      //   width: size.width * 0.005,
                                   //      // ),
                                   //      // ADPrimPhoneTextForm(
                                   //      //   // inputFormatters: [
                                   //      //   //   new LengthLimitingTextInputFormatter(8),
                                   //      //   // ],
                                   //      //   controller: phoneController,
                                   //      //   type: TextInputType.phone,
                                   //      //   label: locale.phoneNumber.toString(),
                                   //      //   pIcon: Icons.phone,
                                   //      //   validat: (value) =>
                                   //      //       FormValidator.phoneValidate(
                                   //      //           context, value),
                                   //      //   auth: true,
                                   //      // ),
                                   //    ],
                                   //  ),
                                 ],
                               ),
                             ),
                             SizedBox(height: 10.sp),
                             InkWell(
                               onTap: () {
                                 showDialog(
                                     context: context,
                                     builder: (context) {
                                       return AlertDialog(
                                         backgroundColor: Colors.white,
                                         content: Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.spaceAround,
                                           children: [
                                             Column(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 IconButton(
                                                   onPressed: () {
                                                     cubit
                                                         .getImage("camera")
                                                         .then((value) {
                                                       Navigator.pop(context);
                                                     });
                                                   },
                                                   icon: const Icon(
                                                     Icons.camera_alt,
                                                     color: Color(0xff7F89C0),
                                                   ),
                                                   iconSize: 40,
                                                 ),
                                                 Text(
                                                   locale.tackPhoto.toString(),
                                                   style: TextStyle(
                                                       color: Colors.black),
                                                 ),
                                               ],
                                             ),
                                             Column(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 IconButton(
                                                   onPressed: () {
                                                     cubit
                                                         .getImage("gallery")
                                                         .then((value) {
                                                       Navigator.pop(context);
                                                     });
                                                   },
                                                   icon: const Icon(
                                                     Icons.image,
                                                     color: Color(0xff7F89C0),
                                                   ),
                                                   iconSize: 40,
                                                 ),
                                                 Text(
                                                   locale.gallery.toString(),
                                                   style: TextStyle(
                                                       color: Colors.black),
                                                 )
                                               ],
                                             ),
                                           ],
                                         ),
                                       );
                                     });
                               },
                               child: Container(
                                 padding: const EdgeInsets.all(10.0),
                                 height: 50.0,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(12),
                                   border: Border.all(
                                       color: Colors.blueAccent, width: 1.0),
                                   color: Color(0xff7F89C0),
                                   shape: BoxShape.rectangle,
                                 ),
                                 child: Row(
                                   children: [
                                     FaIcon(
                                       FontAwesomeIcons.upload,
                                       color: Colors.white,
                                     ),
                                     SizedBox(
                                       width: 15.0,
                                     ),
                                     Text(
                                       cubit.imagePathFace == ""
                                           ? locale.uploadLicense.toString()
                                           : locale.uploadedSuccessfully
                                           .toString(),
                                       style: TextStyle(
                                           color: Colors.white, fontSize: 16.sp),
                                     ),
                                     Spacer(),
                                     cubit.imagePathFace != ""
                                         ? Icon(
                                       Icons.check_circle_outline_outlined,
                                       color: Colors.white,
                                       size: 20,
                                     )
                                         : SizedBox()
                                   ],
                                 ),
                               ),
                             ),
                             FittedBox(
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Theme(
                                     data: ThemeData(
                                       primarySwatch: Colors.blue,
                                       unselectedWidgetColor: Theme.of(context).colorScheme.onPrimary, // Your color
                                     ),
                                     child: Transform.scale(
                                       scale: 1,
                                       child: Checkbox(
                                           value: _isAgreeTerms,
                                           onChanged: (value) {
                                             setState(() {
                                               _isAgreeTerms = value!;
                                             });
                                           }),
                                     ),
                                   ),
                                   InkWell(
                                     onTap: () {
                                       Navigator.of(context).push(MaterialPageRoute(
                                           builder: (_) => PrivacyPolicyScreen()));
                                     },
                                     child: Text(
                                       locale.agreeTermsAndConditions.toString(),
                                       style: TextStyle(
                                         fontSize: 14.sp,
                                         color: KSecondColor,
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             ),
                             SizedBox(height: 10),
                             state is RegisterLoading
                                 ? Center(
                               child: CircularProgressIndicator.adaptive(backgroundColor: Theme.of(context).colorScheme.onPrimary,),
                             )
                                 : Center(child: GestureDetector(
                                 child: defaultButton(
                                     context,
                                     Text(
                                       locale.register.toString(),
                                       style: defaultTextStyle(16,
                                           FontWeight.w700, Colors.white),
                                     )),
                                 onTap: () {
                                   if (_formKey.currentState!.validate() &&
                                       _isAgreeTerms &&
                                       cubit.imagePathFace != '') {
                                     cubit
                                       ..userRegister(
                                           idNumber:
                                           idNumberController.text,
                                           name: 'Test_Name',
                                           email: emailController.text,
                                           phone: phoneController.text,
                                           password:
                                           passwordController.text,
                                           passworConfirm:
                                           confirmPasswordController
                                               .text,
                                           licenceFace:
                                           cubit.imagePathFace);
                                   } else {
                                     AlertDialog(
                                       title: Text('object'),
                                       backgroundColor: Colors.red,
                                     );
                                   }
                                 }),),
                             SizedBox(height: 20.sp),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: size.width * 0.15,
                                   height: 1,
                                   color: Colors.grey,
                                 ),
                                 SizedBox(
                                   width: size.width * 0.02,
                                 ),
                                 Text(locale.or.toString()),
                                 SizedBox(
                                   width: size.width * 0.02,
                                 ),
                                 Container(
                                   width: size.width * 0.15,
                                   height: 1,
                                   color: Colors.grey,
                                 ),
                               ],
                             ),
                             SizedBox(height: 5),

                             /// Already have account Row
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   locale.alreadyHaveAccount.toString(),
                                   style: TextStyle(
                                       color: Colors.grey[400],
                                       fontSize: 12,
                                       fontWeight: FontWeight.bold),
                                 ),
                                 SizedBox(
                                   width: 5,
                                 ),
                                 InkWell(
                                   onTap: () {
                                     Navigator.of(context).pushAndRemoveUntil(
                                       FadeRoute(
                                           builder: (BuildContext context) =>
                                           const SignInScreen()),
                                           (route) => false,
                                     );
                                   },
                                   child: Text(
                                     locale.signIn.toString(),
                                     style: TextStyle(
                                       fontSize: 14,
                                       color: Theme.of(context).colorScheme.onPrimary,
                                       fontWeight: FontWeight.w600,
                                     ),
                                   ),
                                 ),

                               ],
                             ),
                             SizedBox(
                               height: 15.sp,
                             ),
                           ],
                         ),
                       ),
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

  void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => widget,
          ), (route) {
        return false;
      });
}
