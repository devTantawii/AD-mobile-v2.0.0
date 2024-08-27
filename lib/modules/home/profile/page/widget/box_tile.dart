import 'dart:io';

import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/all_booking_screen.dart';
import 'package:abudiyab/modules/home/favourites/favourites.dart';
import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:abudiyab/modules/home/profile/page/privacy_policy/privacy_policy.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/home/profile/page/widget/space.dart';
import 'package:abudiyab/modules/home/selectLanguage/selectLanguage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/profile_cubit/profile_cubit.dart';
import '../members_ship.dart';
import 'card_tile.dart';

class BoxTileWidget extends StatefulWidget {
  const BoxTileWidget({Key? key, required this.profileModel}) : super(key: key);
  final ProfileModel profileModel;

  @override
  State<BoxTileWidget> createState() => _BoxTileWidgetState();
}

class _BoxTileWidgetState extends State<BoxTileWidget> {
  openWhatsApp() async {
    var whatsapp = "966557492493";
    Uri whatsappURlAndroid =
        Uri.parse("whatsapp://send?phone=" + whatsapp + "&text=مرحبا بك في ابو دياب ");
    Uri whatappURLIos =
        Uri.parse("https://wa.me/$whatsapp?text=${Uri.parse("اطلب المساعده")}");

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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        ContainerTileWidget(
            widgets:[
          SpaceWidget(),
          CardTileWidget(
              title: locale.myBookings!,
              icon: Assets.layout_booking,
              ontap: () {
                PersistentNavBarNavigator.pushNewScreen(context, screen: AllBookingScreen());
              }),
          SpaceWidget(),
          CardTileWidget(
              title: locale.memberShip!.toString(),
              icon: Assets.profile_membership,
              ontap: () {
                PersistentNavBarNavigator.pushNewScreen(context,
                    screen: MemberShipScrean(
                      member: widget.profileModel,
                    ));
              }),
          SpaceWidget(),
          CardTileWidget(
              title: locale.favorite.toString(),
              icon: Assets.profile_favorites,
              ontap: () {
                PersistentNavBarNavigator.pushNewScreen(context, screen: Favourites(),withNavBar: false);
              }),
          CardTileWidget(
              title: locale.privacyPolicy.toString(),
              icon: Assets.profile_privacy,
              ontap: () {
                PersistentNavBarNavigator.pushNewScreen(context, screen: PrivacyPolicyScreen());
              }),
        ]),
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.01,
        // ),
        ContainerTileWidget(
            widgets: [
          CardTileWidget(
              title: locale.changeLanguage.toString(),
              icon: Assets.profile_language,
              ontap: () {
                PersistentNavBarNavigator.pushNewScreen(context, screen: SelectLanguage());
              }),
          SpaceWidget(),
          CardTileWidget(title:  locale.logout.toString(), ontap: () => context.read<ProfileCubit>().logOut(),icon: Assets.logout,isLogout: true),
          SpaceWidget(),

        ]),
      ],
    );
  }
}
