import 'package:abudiyab/modules/home/selectLanguage/languageCubit.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/search_Screen.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/fade_route.dart';
import '../../../core/helpers/SharedPreference/pereferences.dart';
import '../../auth/on_boarding/on_boarding.dart';

class SelectLanguage extends StatefulWidget {
  final bool isStart;

  SelectLanguage([this.isStart = false]);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  late LanguageCubit _languageCubit;
  int? _selectedLanguage = -1;
  String? token = SharedPreferencesHelper().get("token").toString();

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  bool en_Selected = false;
  bool ar_Selected = false;
  int? group;

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var locale = AppLocalizations.of(context)!;
    var size = MediaQuery.of(context).size;
    List languages = [
      locale.eng,
      locale.arab,
    ];

    return
      Scaffold(
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.11,
                ),
                SvgPicture.asset('assets/icons/ar-en.svg'),
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      ///EN
                      Text(
                        'Welcome To AbuDiyab',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 23.sp,
                          fontWeight: FontWeight.w700,
                        )
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        'Please Choose Your Preferred Language To Use',
                        textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          )
                      ),

                      ///AR-ع
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        'أهلا بك في أبو ذياب',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w700,
                          )
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Text(
                        'من فضلك أختر لغتك المفضلة للإستخدام',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () {
                          ar_Selected = false;
                          en_Selected == false
                              ? en_Selected = true
                              : en_Selected = false;
                          _selectedLanguage = 0;
                          setState(() {
                            en_Selected == false
                                ? _selectedLanguage = -1
                                : false;
                          });
                        },
                        child: Container(
                          width: size.width * 0.42,
                          height: size.height * 0.06,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: en_Selected == true
                                      ? Colors.transparent
                                      : Theme.of(context).colorScheme.onPrimary,
                                  width: 0.8),
                              borderRadius: BorderRadius.circular(10.sp),
                              color: en_Selected == true
                                  ? Color(0xff7F89C0)
                                  : Colors.transparent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset('assets/icons/england.svg'),
                              Text(
                                'English',
                                style: defaultTextStyle(
                                  16,
                                  FontWeight.w500,
                                  Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          en_Selected = false;
                          ar_Selected == false
                              ? ar_Selected = true
                              : ar_Selected = false;
                          _selectedLanguage = 1;
                          setState(() {
                            ar_Selected == false
                                ? _selectedLanguage = -1
                                : false;
                          });
                        },
                        child: Container(
                          width: size.width * 0.42,
                          height: size.height * 0.07,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ar_Selected == true
                                      ? Colors.transparent
                                      : Theme.of(context).colorScheme.onPrimary,
                                  width: 0.8.sp),
                              borderRadius: BorderRadius.circular(10.sp),
                              color: ar_Selected == true
                                  ? Color(0xff7F89C0)
                                  : Colors.transparent),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset('assets/icons/Flags.svg'),
                              Text(
                                'العربية',
                                style: defaultTextStyle(
                                  16,
                                  FontWeight.w500,
                                  Theme.of(context).brightness==Brightness.light?Colors.black:Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Bounce(
                          onTap: () {
                            if (_selectedLanguage == 0 && en_Selected == true) {
                              _languageCubit.selectEngLanguage();
                            } else if (_selectedLanguage == 1 &&
                                ar_Selected == true) {
                              _languageCubit.selectArabicLanguage();
                            }
                            if (widget.isStart) {
                              Navigator.of(context).pushAndRemoveUntil(
                                FadeRoute(
                                  builder: (BuildContext context) => token != null
                                      ? OnBoarding()
                                      : SearchScreen(
                        
                                  ),
                                ),
                                (route) => false,
                              );
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: defaultButton(
                            context,
                            Text(
                              locale.confirm,
                              style: defaultTextStyle(
                                  18, FontWeight.w700, Colors.white),
                            ),
                          ),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
