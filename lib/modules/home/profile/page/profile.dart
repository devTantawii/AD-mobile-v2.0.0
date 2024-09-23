import 'dart:io';
import 'package:abudiyab/shared/commponents.dart';
import 'package:bounce/bounce.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/page/privacy_policy/privacy_policy.dart';
import 'package:abudiyab/modules/home/profile/page/widget/card_tile.dart';
import 'package:abudiyab/modules/home/profile/page/widget/space.dart';
import 'package:abudiyab/modules/widgets/components/error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../auth/register/presentaion/pages/register_page.dart';
import '../../../auth/signin/presentation/pages/signin_screen.dart';
import '../../all_bookings/presentaion/bloc/allbooking_cubit.dart';
import '../../selectLanguage/selectLanguage.dart';
import '../blocs/profile_cubit/profile_cubit.dart';
import 'edit_profile/presentaion/page/edit_profile.dart';
import 'widget/box_tile.dart';

class MyProfile extends StatefulWidget {
  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfile();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    var safeHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          locale.more,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 16.sp, color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is DeleteProfileSuccess) {
            HelperFunctions.showFlashBar(
                context: context,
                title: 'تم حذف حسابك بنجاح',
                message: "Your Account Deleted Successfully",
                icon: Icons.info_outline,
                color: Color(0xffDCEFE3),
                titlcolor: Colors.green,
                iconColor: Colors.green);
          }
          if (state is ProfileFailed) {
          } else if (state is ProfileLogout) {
            BlocProvider.of<AllBookingCubit>(context).booking = null;
            PersistentNavBarNavigator.pushNewScreen(context,
                screen: SignInScreen(), withNavBar: false);
          }
        },
        builder: (context, state) {
          final bool isShow = (state is ProfileSuccess);
          if (state is ProfileLoading) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          }
          if (state is ProfileSuccess) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding:
                    EdgeInsets.only(top: 20, bottom: 30, right: 20, left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        DottedBorder(
                          borderType: BorderType.Circle,
                          padding: EdgeInsets.all(5.sp),
                          color: Theme.of(context).colorScheme.primary,
                          strokeWidth: 1,
                          child: Container(
                            width: 103.sp,
                            height: 103.sp,
                            child: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: ClipOval(
                                child: Image.network(
                                  isShow
                                      ? state.profileModel.avatar!
                                      : Assets.profile,
                                  fit: BoxFit.cover,
                                  height: 100.sp,
                                  width: 100.sp,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              radius: 60,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      state.profileModel.name!,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     PersistentNavBarNavigator.pushNewScreen(context,
                    //         screen: EditProfile(
                    //           profileModel: state.profileModel,
                    //         ));
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       SvgPicture.asset(
                    //         Assets.icon_edits,
                    //         color:
                    //             Theme.of(context).brightness == Brightness.light
                    //                 ? Theme.of(context).colorScheme.primary
                    //                 : Color(0xffF08A61),
                    //       ),
                    //       SizedBox(
                    //         width: size.width * 0.01,
                    //       ),
                    //       Text(
                    //         locale.editProfile.toString(),
                    //         style: defaultTextStyle(
                    //           14,
                    //           FontWeight.w600,
                    //           Theme.of(context).brightness == Brightness.light
                    //               ? Theme.of(context).colorScheme.primary
                    //               : Color(0xffF08A61),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Column(
                      children: [
                        // Edit button for the profile
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CardTileWidget(
                              title: locale.editProfile.toString(),
                              icon: Assets.icon_edits,
                              ontap: () {
                                PersistentNavBarNavigator.pushNewScreen(context,
                                    screen: EditProfile(
                                      profileModel: state.profileModel,
                                    ));
                              }),
                        ),

                        BoxTileWidget(profileModel: state.profileModel),
                        SizedBox(height: safeHeight * 0.02),
                        state.profileModel.deleteStatus == "1"
                            ? Bounce(
                                //  onTap: () => context.read<ProfileCubit>().deleteProfile(),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0))),
                                          backgroundColor: Colors.blue,
                                          content: Container(
                                            child: Text(
                                              locale.areYouSureDelete
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ),
                                          actions: [
                                            Row(
                                              children: [
                                                Bounce(
                                                  onTap: () {
                                                    context
                                                        .read<ProfileCubit>()
                                                        .deleteProfile();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.08,
                                                            vertical: 8),
                                                        child: Text(
                                                          locale.ok.toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                Bounce(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal:
                                                                MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.08,
                                                            vertical: 8),
                                                        child: Text(
                                                          locale.cancel
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.no_accounts_outlined,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.8),
                                    ),
                                    SizedBox(width: 10.0),
                                    Text(
                                      locale.DeleteAccount.toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                      )
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: GestureDetector(
                                onTap: () async {
                                  const url =
                                      'https://www.facebook.com/abudiyabsa';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(Assets.icon_facebook,
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: GestureDetector(
                                onTap: () async {
                                  const url =
                                      'https://www.instagram.com/abudiyabsa/';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Image.asset(Assets.icon_instagram,
                                    width: MediaQuery.of(context).size.width *
                                        0.14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: GestureDetector(
                                  onTap: () async {
                                    const url =
                                        'https://www.linkedin.com/company/abudiyabsa/';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: SvgPicture.asset(Assets.icon_linkedIn,
                                      width: MediaQuery.of(context).size.width *
                                          0.1)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: GestureDetector(
                                onTap: () async {
                                  const url =
                                      'https://twitter.com/abudiyabrentcar?s=11&t=hDavfTiTfk1KFUkvcZlaAw';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(Assets.icon_twitter,
                                    width: MediaQuery.of(context).size.width *
                                        0.1),
                              ),
                            ),
                            GestureDetector(
                                onTap: () async {
                                  const url =
                                      'https://api.whatsapp.com/send/?phone=966557492493&text&type=phone_number&app_absent=0';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: SvgPicture.asset(Assets.icon_whatsApp,
                                    width: MediaQuery.of(context).size.width *
                                        0.1)),
                          ],
                        ),
                        SizedBox(height: safeHeight * 0.1),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProfileFailed &&
              (state.error!.contains("Not Authanticated") ||
                  state.error!.contains("Unauthenticated"))) {
            return ErrorImage(
                error: "Unauthenticated",
                refresh: () {
                  BlocProvider.of<ProfileCubit>(context).getProfile();
                });
          }
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: safeHeight * 0.08),
                Text(
                  locale.isDirectionRTL(context)
                      ? "هلا! سعداء بلقائك"
                      : "Hala! Nice to meet you",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  locale.isDirectionRTL(context)
                      ? "تطبيق تأجير السيارات الافضل في المنطقة"
                      : "The region’s favorite online car rental app.",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: safeHeight * 0.08),
                Row(
                  children: [
                    Bounce(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: SignInScreen(),
                            withNavBar: false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: size.width * 0.09,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: SvgPicture.asset(
                                  Assets.icon_login,
                                ),
                              ),
                            ),
                            Text(
                              locale.signIn.toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            )
                          ],
                        )),

                    ///second
                    Spacer(),
                    Bounce(
                        onTap: () {
                          PersistentNavBarNavigator.pushNewScreen(
                            context,
                            screen: RegisterPage(),
                            withNavBar: false,
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              width: size.width * 0.09,
                              height: size.height * 0.04,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: SvgPicture.asset(
                                  Assets.icon_addAccount,
                                ),
                              ),
                            ),
                            Text(
                              locale.isDirectionRTL(context)
                                  ? 'فتح حساب'
                                  : 'Create Account',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: safeHeight * 0.08),
                CardTileWidget(
                    title: locale.changeLanguage.toString(),
                    icon: Assets.profile_language,
                    ontap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: SelectLanguage());
                    }),
                SpaceWidget(),
                CardTileWidget(
                    title: locale.privacyPolicy.toString(),
                    icon: Assets.profile_privacy,
                    ontap: () {
                      PersistentNavBarNavigator.pushNewScreen(context,
                          screen: PrivacyPolicyScreen());
                    }),
                SpaceWidget(),
                // CardTileWidget(
                //     title: locale.connectWithUs.toString(),
                //     icon: Assets.profile_whatsapp,
                //     ontap: () async {
                //       await openWhatsApp();
                //     }),
                // SizedBox(height: safeHeight * 0.02),
              ],
            ),
          );
        },
      ),
    );
  }

  openWhatsApp() async {
    var whatsapp = "966557492493";
    Uri whatsappURlAndroid =
        Uri.parse("whatsapp://send?phone=" + whatsapp + "&text=hello");
    Uri whatappURLIos =
        Uri.parse("https://wa.me/$whatsapp?text=${Uri.parse("hello")}");

    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(whatappURLIos)) {
        await launchUrl(
          whatappURLIos,
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(whatsappURlAndroid)) {
        await launchUrl(whatsappURlAndroid);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
      }
    }
  }
}
