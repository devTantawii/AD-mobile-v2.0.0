import 'package:abudiyab/core/fade_route.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../language/locale.dart';
import '../../auth/signin/presentation/pages/signin_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final pages = List.generate(
      3,
      (index) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //defaultSizeBox(context),

              Image.asset(
                index == 0
                    ? 'assets/images/onBoarding1.png'
                    : index == 1
                        ? Theme.of(context).brightness == Brightness.light
                            ? 'assets/images/onBoarding2.png'
                            : 'assets/images/onBoarding2dark.png'
                        : Theme.of(context).brightness == Brightness.light
                            ? 'assets/images/onBoarding3.png'
                            : 'assets/images/onBoarding3dark.png',
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    index == 0
                        ? Text(
                            locale!.titleOnboarding1.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700),
                          )
                        : index == 1
                            ? Text(
                                locale!.titleOnboarding2.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                              )
                            : Text(
                                locale!.titleOnboarding3.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700),
                              ),

                    ///Body
                    SizedBox(
                      height: 16.h,
                    ),
                    index == 0
                        ? Text(
                            locale.bodyOnboarding1.toString(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500),
                          )
                        : index == 1
                            ? Text(
                                locale.bodyOnboarding2.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                              )
                            : Text(
                                locale.bodyOnboarding3.toString(),
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500),
                              ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.001,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.80,
                        width: MediaQuery.of(context).size.width,
                        child: PageView.builder(
                          controller: controller,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: SlideEffect(
                            dotHeight: 4.h,
                            dotWidth: 20.w,
                            dotColor: Color(0xffF8CBB0),
                            activeDotColor: Color(0xffF08A61),
                            spacing: 10.h),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.width * 0.1,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          FadeRoute(
                            builder: (BuildContext context) =>
                                const SignInScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05),
                        child: defaultButton(
                            context,
                            Text(
                              locale!.follow.toString(),
                              style: defaultTextStyle(
                                15,
                                FontWeight.w600,
                                Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final colors = Color(0xffF08A61);
}
