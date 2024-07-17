import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/mybookings.dart';
import 'package:abudiyab/modules/home/all_branching/page/branches_screen.dart';
import 'package:abudiyab/modules/home/cars/presentaion/all_cars_screen.dart';
import 'package:abudiyab/modules/home/profile/page/profile.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:new_version/new_version.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../core/constants/langCode.dart';
import '../../../core/helpers/SharedPreference/pereferences.dart';
import '../all_bookings/presentaion/page/all_booking_screen.dart';
import '../profile/blocs/profile_cubit/profile_cubit.dart';
import '../search_screen/presentaion/search_Screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int _page = 0;
  List<Widget> _buildScreens() =>[
        SearchScreen(),
        AllCarsScreen(fromFilter: false, filterModel: null),
        AllBookingScreen(isBottomSheet:true),
        BranchesScreen(),
        MyProfile(),
      ];
  late PersistentTabController _controller;
  @override
  void initState() {
    BlocProvider.of<ProfileCubit>(context).getProfile();
    super.initState();

    // SharedPreferencesHelper().get("token").toString().isNotEmpty?
    // BlocProvider.of<AllBookingCubit>(context).getAllBooking():false;
    // SharedPreferencesHelper().get("token").toString().isNotEmpty?checkVersion():false;
    ///-------version function--------
    //   BlocProvider.of<ProfileCubit>(context).deleteStatus=="1"?false :checkVersion();
    //    if(BlocProvider.of<ProfileCubit>(context).deleteStatus =="0"){
    //       checkVersion();
    //   }
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return [
      PersistentBottomNavBarItem(
        icon: FittedBox(
          fit: BoxFit.none,
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.014,
            ),
            child: Padding(
              padding: EdgeInsets.all(4.5),
              child: Icon(
                Icons.home,
                size: 33,
                color: _page == 0 ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
              ),
            ),
          ),
        ),
        title: "${locale!.home}",
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
        activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: FittedBox(
          fit: BoxFit.none,
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.014,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.sp),
              child: SvgPicture.asset(
                height:size.height*0.027,
                Assets.layout_cars,
                alignment: Alignment.center,
                color: _page == 1 ?  Theme.of(context).colorScheme.onPrimary : Colors.grey,
              ),
            ),
          ),
        ),
        title: "${locale.fleet}",
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
        activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      ///-----orders----------
      PersistentBottomNavBarItem(
        icon: FittedBox(
          fit: BoxFit.none,
          clipBehavior: Clip.none,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.014,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.sp),
              child: Icon(
                Icons.calendar_month_outlined,
                size: 31,
                color: _page == 2 ?  Theme.of(context).colorScheme.onPrimary : Colors.grey,
              ),
            ),
          ),
        ),
        title: "${locale.myBookings}",
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
        activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      ///-----orders----------
      PersistentBottomNavBarItem(
        icon: FittedBox(
          fit: BoxFit.none,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.014,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp, vertical: 5.sp),
              child: SvgPicture.asset(
                height:size.height*0.03,
                Assets.layout_branch,
                alignment: Alignment.center,
                color: _page == 3 ? Theme.of(context).colorScheme.onPrimary : Colors.grey,
              ),
            ),
          ),
        ),
        // textStyle: TextStyle(fontSize: 10,),
        title: "${locale.branches}",
        textStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
        activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: FittedBox(
            fit: BoxFit.none, child: GestureDetector(
              child: Padding(
          padding:  EdgeInsets.only( top: size.height * 0.015,),
          child: Icon(Icons.more_vert_outlined,size: 33,),
        ),
            )),
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 8.sp, fontWeight: FontWeight.bold),
        title: "${locale.more}",
        activeColorPrimary: Theme.of(context).colorScheme.onPrimary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: PersistentTabView(
        context,
        onItemSelected: (index) => setState(() => _page = index),
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).brightness==Brightness.light?Colors.white:Color(0xff222249),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        //navBarHeight: Platform.isIOS?MediaQuery.of(context).size.height * 0.060:MediaQuery.of(context).size.height * 0.080,
        hideNavigationBarWhenKeyboardShows: true,
        //margin: Platform.isIOS ? EdgeInsets.all(0) : EdgeInsets.all(20.0),
        popActionScreens: PopActionScreensType.all,

        selectedTabScreenContext: (context) {},
        hideNavigationBar: false,
        decoration: NavBarDecoration(),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 100),
          // curve: Curves.fastOutSlowIn,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          // curve: Curves.linear,
         duration: Duration(milliseconds: 100),
        ),
        navBarStyle: NavBarStyle.style8,
      ),
    );
  }

  ///******************* GET VERSION *******************
   checkVersion() async {
    final newVersion = NewVersion(
      iOSId: 'com.abudiyab.abudiyab',
      androidId: 'com.abudiyab.abudiyab',
    );
    final status = await newVersion.getVersionStatus();
    if (status != null) {
        newVersion.showUpdateDialog(
          context: context,
          versionStatus: status,
          dialogTitle: "تحديث",
          //dismissButtonText: "Skip",
          dialogText: "برجاء تحديث التطبيق الآن ",
          allowDismissal: false,
          dismissAction: () {
            SystemNavigator.pop();
          },
          updateButtonText: "تحديث الآن",
        );
      print("app version on Device " + "${status.localVersion}");
      print("app version on store " + "${status.storeVersion}");
    }
  }
}
