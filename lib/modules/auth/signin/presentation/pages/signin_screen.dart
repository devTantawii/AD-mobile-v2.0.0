import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/validation/form_validator.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/forgotPassword/presentaion/widgets/forgotPassword.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/page/enter_info_oldcustomer_screan.dart';
import 'package:abudiyab/modules/auth/blocs/auth_bloc/onboarding_cubt_cubit.dart';
import 'package:abudiyab/modules/auth/signin/presentation/bloc/signin_bloc.dart';
import 'package:abudiyab/modules/home/home_screen/home_screen.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:abudiyab/service_locator.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/fade_route.dart';
import '../../../../../shared/style/colors.dart';
import '../../../../home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import '../../../../widgets/components/ad_curve.dart';
import '../../../register/presentaion/pages/register_page.dart';

class SignInScreen extends StatefulWidget {
  final Function()? isLogin;
  final OnBoardingCubit? cubit;

  const SignInScreen({Key? key, this.isLogin, this.cubit, this.pushAddition = false})
      : super(key: key);
  final bool pushAddition;

  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // String? _country;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  String? errorEmail;
  String? errorPassword;

  String valueEmail = "";
  String valuePassword = "";

  FocusNode nodePassword = FocusNode();

  bool loadingLogin = false;

  bool get isLoadingLogin => loadingLogin;

  final _formKey = GlobalKey<FormState>();

  void resetForm() {
    controllerEmail.clear();
    controllerPassword.clear();
  }

  @override
  void initState() {
    resetForm();
    BlocProvider.of<AllBookingCubit>(context).booking=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => sl<SignInBloc>(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            if (_formKey.currentState!.validate()) {
              widget.pushAddition
                  ? Navigator.of(context).pop(true)
                  : Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                      (route) => false);
            }
            ///
            // if (_formKey.currentState!.validate()) {
            //   widget.pushAddition
            //       ? Navigator.of(context).pop(true)
            //       : Navigator.of(context).pushAndRemoveUntil(
            //           MaterialPageRoute(builder: (_) => LayoutScreen()),
            //           (route) => false);
            // }
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CurveWidget(
                            title:locale.welcomeAgain.toString(),
                            subTitle:locale.welcomeAgainSubtitel.toString(),
                            positionTop: size.height*0.1,
                            positionBottom:size.height*0.16,
                          titleStyle: defaultTextStyle(24, FontWeight.w600, Colors.white),
                          subtitleStyle: defaultTextStyle(16, FontWeight.w400, Colors.white),
                          isHome: false,
                          forgetPasswordScreen: false,
                        ),
                        Padding(
                          padding:
                          EdgeInsets.only(top:size.height*0.01, left: size.width*0.05,right:size.width*0.05),
                          child: Column(
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    ///Fir
                                    ADPrimTextForm(
                                      controller: controllerEmail,
                                      type: TextInputType.emailAddress,
                                      label: locale.dataUser.toString(),
                                      pIcon: Icons.email_outlined,
                                      // validat: (value) =>
                                      //     FormValidator.emailValidate(
                                      //         context, value),
                                      auth: true,
                                    ),
                                    SizedBox(
                                      height: 10.sp,
                                    ),

                                    ///Sec
                                    ADPrimTextForm(
                                      controller: controllerPassword,
                                      type: TextInputType.visiblePassword,
                                      label: locale.password.toString(),
                                      pIcon: Icons.lock_outline,
                                      validat: (value) =>
                                          FormValidator.passwordValidate(
                                              context, value),
                                      auth: true,
                                    ),
                                    SizedBox(height: 10),
                                    state is SignInFailure
                                        ? Text(
                                      locale.checkUsernameAndPassword
                                          .toString(),
                                      style: TextStyle(color: Colors.red),
                                    )
                                        : SizedBox.shrink(),
                                    InkWell(
                                        onTap: (){
                                          navigateTo(context,ForgotPasswordScreen());
                                        },
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            locale.forgetPassword.toString(),
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.sp),
                                          ),
                                        )),
                                    SizedBox(height: 10.sp),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0.sp),
                              state is SignInLoading
                                  ? Center(
                                  child: CircularProgressIndicator.adaptive(
                                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                                  ))
                                  : GestureDetector(
                                child: defaultButton(context,Text(locale.signIn.toString(),style: defaultTextStyle(16, FontWeight.w700, Colors.white),)),
                                onTap: (){
                                  login(context);
                                  BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
                                },
                              ),

                              SizedBox(height: 10.0),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (_) => HomeScreen()),
                                          (_) => false);
                                },
                                child: Card(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: size.height * 0.05,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0.sp),
                                    ),
                                    child: Center(
                                        child: AutoSizeText(
                                            locale.continueAsGuest!,
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w500)
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.0.sp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    locale.dontHaveAccount.toString(),
                                    style: TextStyle(
                                        color:Theme.of(context).brightness==Brightness.light? Colors.grey[600]:Colors.grey[400],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Bounce(
                                    onTap: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        FadeRoute(
                                          builder: (BuildContext context) =>
                                          const RegisterPage(
                                            onBoardingCubit: null,
                                          ),
                                        ),
                                            (route) => false,
                                      );
                                    },
                                    child: Text(
                                      locale.registerNow.toString(),
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                                    ),
                                  ),

                                ],
                              ),
                              SizedBox(height: 20.0.sp),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: size.width * 0.20,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Text(locale.or.toString(),style: TextStyle(color:KSecondColor,fontSize: 18.sp),),
                                  SizedBox(
                                    width: size.width * 0.02,
                                  ),
                                  Container(
                                    width: size.width * 0.20,
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0.h),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (_) =>EnterInfoOldCustromerScrean()),
                                          );
                                },
                                child: Card(
                                  elevation: 0.0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    height: size.height * 0.05,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:Color(0xFFCAD3F3),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                        child: AutoSizeText(
                                          locale.oldCustomer.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!.copyWith(fontSize: 16)
                                              .copyWith(color: Color(0XFF505AC9)),
                                        )),
                                  ),
                                ),
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

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
  void onForgetPasswordClick() =>
      showDialog(context: context, builder: (_) => ForgotPasswordScreen());
  void login(context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<SignInBloc>(context).add(SignIn(
        email: controllerEmail.text,
        password: controllerPassword.text,
        device_token: deviceToken.toString(),
      ));
    }
  }
}
