import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_cubit.dart';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:abudiyab/modules/home/home_screen/home_screen.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/commponents.dart';

class BookingConfirmed extends StatelessWidget {
  final String? orderId;

  const BookingConfirmed({
    Key? key,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: size.width,
                  height: 70.sp,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 20.sp,
                              height: 20.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Text(
                                locale.orderDetails.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              width: 20.sp,
                              height: 20.sp,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20,
                              )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Text(
                                locale.payment.toString(),
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Container(
                  child: Center(
                    child: Image.asset("assets/images/DoneBooking.png"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  child: Column(
                    children: [
                      Text(''
                          // "#${BlocProvider.of<BookingCubit>(context).orderID??"${orderId.toString()}"}",
                          // style: Theme.of(context)
                          //     .textTheme
                          //     .bodyLarge!
                          //     .copyWith(fontSize: 24.sp)
                          ),
                      SizedBox(height: 10),
                      Text(locale.bookingConfirmed!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 20.sp)),
                      SizedBox(height: 10),
                      // Text(
                      //   locale.sitBackAndRelax! ,
                      //       //+
                      //       //" ${BlocProvider.of<BookingCubit>(context).orderID}",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .bodyMedium!
                      //       .copyWith(fontSize: 15.sp),
                      //   textAlign: TextAlign.center,
                      // ),
                      SizedBox(height: 10),
                      Text(locale.haveAGreatDay!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15.sp),
                          textAlign: TextAlign.center),
                      SizedBox(height: 15.sp),
                      GestureDetector(
                        onTap: () async {
                          BlocProvider.of<BookingCubit>(context).reset();
                          await BlocProvider.of<AllBookingCubit>(context)
                              .getAllBooking(state: 'running');
                          navigateAndFinish(context, HomeScreen());
                          // pushNewScreen(context, screen: AllBookingScreen(),);
                        },
                        child: ADGradientButton(
                          locale.goToHome.toString(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
