import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/widget/bookingStatus/previousOrders.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/widget/bookingStatus/running_now.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/allbooking_cubit.dart';
class MyBookings extends StatefulWidget {
  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends State with SingleTickerProviderStateMixin {
  int orderIndex = 1;
  late TabController tabController;
  @override
  void initState() {
    BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
    tabController = TabController(length: 2, vsync: this,);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Padding(
          padding:  EdgeInsets.only(bottom: size.height*0.03),
          child: Container(
            height: size.height*0.08,
            width: size.width/1,
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: TabBar(
              controller: tabController,
              padding: EdgeInsets.all(0),
              indicator: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(6),
                    bottomLeft:Radius.circular(6),
                    topRight:Radius.circular(6),
                    bottomRight:Radius.circular(6)
                ),
              ),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.white,
              tabs: [
                Container(
                  width: size.width/1,
                  child: Center(
                    child: Text(
                        locale.isDirectionRTL(context)?"حجوزات جارية":"Ongoing",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp,
                        )
                    ),
                  ),
                ),
                Container(
                  width: size.width/1,
                  child: Center(
                    child: Text(
                        locale.isDirectionRTL(context)?"حجوزات سابقة":"History",
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.sp
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children:[
              RunningNow(),
              // NotCompletedOrder(),
              PreviousOrders(),
            ],
          ),
        ),
      ],
    );
  }
  Widget whenOrdersNull(locale){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/images/emptystate.png'),
              ),
              SizedBox(height: 25.sp,),
              Text(locale.noCarsBooking1.toString(),style:Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400
              )),
            ],
          ),
        ),
      ],
    );
  }

}
