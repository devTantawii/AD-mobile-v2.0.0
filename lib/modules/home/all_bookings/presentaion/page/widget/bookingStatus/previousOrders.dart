import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_state.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/widget/texttile_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../../../../../../../core/helpers/helper_fun.dart';
import '../../../../../../../language/locale.dart';
import '../../../../../../../shared/commponents.dart';
import '../../../bloc/allbooking_cubit.dart';
import '../../bookDetailes.dart';

class PreviousOrders extends StatefulWidget {
  const PreviousOrders({super.key});

  @override
  State<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  @override
  void initState() {
    BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'ended');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return BlocConsumer<AllBookingCubit, AllBookingState>(
      listener: (context, state) {
        if (state is AllBookingError) {
          HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.error,
              icon: Icons.info,
              color: Color(0xffF6A9A9),
              titlcolor: Color(0xffD62E2E),
              iconColor: Color(0xffD62E2E));
        }

        if (state is CancelError) {
          HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.error,
              icon: Icons.warning_amber,
              color: Color(0xffF6A9A9),
              titlcolor: Color(0xffD62E2E),
              iconColor: Color(0xffD62E2E));
        }
        if (state is CancelSuccess) {
          BlocProvider.of<AllBookingCubit>(context)
              .getAllBooking(state: 'ended');
          HelperFunctions.showFlashBar(
              color: Color(0xffDCEFE3),
              context: context,
              title: '',
              message: locale.isDirectionRTL(context)
                  ? 'تم الغاء الطلب بنجاح'
                  : 'Order has been cancelled Successfully',
              titlcolor: Color(0xff327B5B),
              icon: Icons.check,
              iconColor: Color(0xff327B5B));
        }

        ///-----delete error state
        if (state is DeleteOrderError) {
          HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.error,
              icon: Icons.warning_amber,
              color: Color(0xffF6A9A9),
              titlcolor: Color(0xffD62E2E),
              iconColor: Color(0xffD62E2E));
        }
        if (state is DeleteOrderSuccess) {
          BlocProvider.of<AllBookingCubit>(context)
              .getAllBooking(state: 'ended');
          HelperFunctions.showFlashBar(
              color: Color(0xffDCEFE3),
              context: context,
              title: '',
              message: locale.isDirectionRTL(context)
                  ? 'تم حذف الطلب بنجاح'
                  : 'Order has been Deleted Successfully',
              titlcolor: Color(0xff327B5B),
              icon: Icons.check,
              iconColor: Color(0xff327B5B));
        }
        if (state is AllBookingLoading) {
          Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AllBookingLoading) {
          return Center(
              child: CircularProgressIndicator.adaptive(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
          ));
        } else if (BlocProvider.of<AllBookingCubit>(context).booking !=
                null &&
            BlocProvider.of<AllBookingCubit>(context).booking!.data != null &&
            state is AllBookingLoaded) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var carData = BlocProvider.of<AllBookingCubit>(context)
                    .booking!
                    .data![index]!
                    .car;
                var bookingData = BlocProvider.of<AllBookingCubit>(context)
                    .booking!
                    .data![index]!;
                return Stack(
                    alignment: locale.isDirectionRTL(context)
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    children: [
                      Bounce(
                        onTap: () {
                          navigateTo(
                              context,
                              BookDetails(
                                bookingData: bookingData,
                              ));
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.all(size.width * 0.01),
                            height: MediaQuery.of(context).size.height * 0.22,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // First Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: AutoSizeText(
                                        "${bookingData.createdAt}",
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 76.w,
                                      height: 30.h,
                                      decoration: BoxDecoration(
                                        color: bookingData.status == 'done'
                                            ? Color(0XFF1FA88F)
                                            : bookingData.status == 'rejected'
                                            ? Color(0XFFFFC107)
                                            : Color(0xffD62E2E),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0)),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.015, vertical: 5.h),
                                        child: Text(
                                          bookingData.statusText.toString(),
                                          style: TextStyle(
                                            color: Color(0XFFFDFDFD),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                // Second Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${locale.isDirectionRTL(context) ? "رقم الحجز: " : "Book Number: "}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "${bookingData.id}",
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.width * 0.015,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${locale.carName} : ",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              Text(
                                                "${carData.name} ",
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.width * 0.015,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                locale.isDirectionRTL(context)
                                                    ? "تكلفة الحجز: "
                                                    : "Booking cost: ",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                              Text(
                                                "${bookingData.price} " + " " + locale.sar.toString(),
                                                style: TextStyle(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black87),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    WidgetZoom(
                                      heroAnimationTag: 'hero-${bookingData.id}',
                                      zoomWidget: Image.network(
                                        carData.photo,
                                        width: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.015,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        BookDetails(
                                          bookingData: bookingData,
                                        ));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                                    child: Container(
                                      width: 70.w,
                                      height: 24.h,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondaryContainer,
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Text(
                                        locale.bookingDetails
                                            .toString()
                                            .replaceAll('Details', '')
                                            .replaceAll('الحجز', ''),
                                        style: defaultTextStyle(
                                            13, FontWeight.w600, Theme.of(context).colorScheme.primary),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ]);
              },
              itemCount: BlocProvider.of<AllBookingCubit>(context)
                  .booking!
                  .data!
                  .length,
            ),
          );
        } else {
          return whenOrdersNull(locale);
        }
      },
    );
  }

  Widget whenOrdersNull(locale) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/images/emptystate.png'),
              ),
              SizedBox(
                height: 25.sp,
              ),
              // Text(locale.noCarsBookings.toString(),style:Theme.of(context).textTheme.titleMedium!.copyWith(
              //     fontSize: 28.sp,
              //     fontWeight: FontWeight.w700
              // ),),
              Text(locale.noCarsBooking1.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
      ],
    );
  }
}
