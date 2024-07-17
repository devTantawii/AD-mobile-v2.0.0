import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mybookings.dart';

class AllBookingScreen extends StatefulWidget {
  bool ?isBottomSheet;
  AllBookingScreen({Key? key,this.isBottomSheet}) : super(key: key);
  @override
  State<AllBookingScreen> createState() => _AllBookingScreenState();
}

class _AllBookingScreenState extends State<AllBookingScreen> {
  @override
  void initState(){
     BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: widget.isBottomSheet==false?AppBar(
        backgroundColor: Colors.transparent,
          title: Text(locale.myBookings!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 18.sp)),
          leading: ADBackButton()):AppBar(
        backgroundColor: Colors.transparent,
        title: Text(locale.myBookings.toString(),style: TextStyle(fontFamily: 'Cairo')),
      ),
      body: MyBookings(),
    );
  }
}

