import 'package:abudiyab/modules/home/additions/presentaion/pages/additions_screen.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_state.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../../core/helpers/helper_fun.dart';
import '../../../../../language/locale.dart';
import '../../../../widgets/components/ad_back_button.dart';
import '../../../additions/presentaion/blocs/addition_cubit/additions_cubit.dart';

import '../../../payment/invouce_notCompleted.dart';
import '../bloc/allbooking_cubit.dart';

class BookDetails extends StatelessWidget {
  const BookDetails(
      {Key? key,
      required this.bookingData,
      this.dataCars,
      this.checkOrderStepModel,
      this.isNotCompleted})
      : super(key: key);
  final Datum bookingData;
  final DataCars? dataCars;
  final DataCars? checkOrderStepModel;
  final bool? isNotCompleted;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return BlocConsumer<AllBookingCubit, AllBookingState>(
      listener: (context, state) {
        if (state is CancelError) {
          HelperFunctions.showFlashBar(
              context: context,
              title: locale.error.toString(),
              message: state.error,
              color: Color(0xffF6A9A9),
              titlcolor: Color(0xffD62E2E),
              icon: Icons.warning_amber,
              iconColor: Color(0xffD62E2E));
        }
        if (state is CheckOrderStateLoading) {
          CircularProgressIndicator.adaptive();
        }
        if (state is CancelSuccess) {
          // BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
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
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: bookingData.status == 'confirmed' ||
                  bookingData.status == 'pending'
              ? Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.00,
                    bottom: MediaQuery.of(context).size.height * 0.09,
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: size.height * 0.23,
                            color: Theme.of(context).colorScheme.onSecondary,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Container(
                                  height: size.height * 0.007,
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Center(
                                  child: Text(
                                    locale.wantToCancel.toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: size.width * 0.25,
                                        height: size.height * 0.045,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary)),
                                        child: Center(
                                          child: Text(
                                            locale.isDirectionRTL(context)
                                                ? "عدم الالغاء"
                                                : "No",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await BlocProvider.of<AllBookingCubit>(
                                                context)
                                            .cancelBooking(
                                              orderId: bookingData.id,
                                            )
                                            .then((value) =>
                                                Navigator.pop(context));
                                        // BlocProvider.of<AllBookingCubit>(context).getAllBooking();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: size.width * 0.25,
                                        height: size.height * 0.045,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border:
                                                Border.all(color: Colors.red),
                                            color: Colors.red),
                                        child: Center(
                                          child: Text(
                                            locale.isDirectionRTL(context)
                                                ? "الغاء الحجز"
                                                : "Cancel Order",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Card(
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(6)),
                        child: Container(
                          height: size.height * 0.053,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Theme.of(context).scaffoldBackgroundColor,
                            border: Border.all(color: Colors.red, width: 1.3),
                          ),
                          child: Center(
                              child: state is CancelLoading
                                  ? CircularProgressIndicator.adaptive()
                                  : AutoSizeText(
                                      locale.cancel.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Colors.red),
                                    )),
                        ),
                      ),
                    ),
                  ),
                )
              : bookingData.status == 'notcompleted'
                  ? Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.00,
                          bottom: MediaQuery.of(context).size.height * 0.09,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            await BlocProvider.of<AdditionsCubit>(context)
                                .checkOrderStep(
                                    orderId: bookingData.id.toString());
                            if (bookingData.step == 2) {
                              BlocProvider.of<AdditionsCubit>(context)
                                          .stepModel !=
                                      null
                                  ? navigateTo(
                                      context,
                                      AdditionsScreen(
                                        datum: bookingData.car,
                                        fromNotCompleted: true,
                                        bookDetails: bookingData,
                                        checkOrderStepModel:
                                            BlocProvider.of<AdditionsCubit>(
                                                    context)
                                                .stepModel,
                                      ))
                                  : null;
                            } else if (bookingData.step == 3) {
                              BlocProvider.of<AdditionsCubit>(context)
                                          .stepModel !=
                                      null
                                  ? PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: InvoiceNotCompletedUI(
                                        carModel: dataCars,
                                        isNotCompletedOrder: true,
                                        orderID: bookingData.id.toString(),
                                        paymentType: bookingData.paymentType!
                                            .toLowerCase(),
                                        checkOrderStepModel:
                                            BlocProvider.of<AdditionsCubit>(
                                                    context)
                                                .stepModel,
                                      ),
                                      withNavBar: false)
                                  : false;
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.05),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.white.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Container(
                                height: size.height * 0.053,
                                width: size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Theme.of(context).colorScheme.primary,
                                  border: Border.all(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      width: 1.3),
                                ),
                                child: Center(
                                    child: state is CancelLoading
                                        ? CircularProgressIndicator.adaptive()
                                        : BlocConsumer<AdditionsCubit,
                                            AdditionsState>(
                                            listener: (context, state) {},
                                            builder: (context, state) {
                                              return state
                                                      is CheckOrderStateLoading
                                                  ? CircularProgressIndicator
                                                      .adaptive(
                                                      backgroundColor:
                                                          Colors.white,
                                                    )
                                                  : AutoSizeText(
                                                      locale.isDirectionRTL(
                                                              context)
                                                          ? "إِستكمال الطلب "
                                                          : "Continue Order",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge!
                                                          .copyWith(
                                                              color:
                                                                  Colors.white),
                                                    );
                                            },
                                          )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 2,
                      height: 2,
                    ),
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(locale.orderDetails.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 18.sp)),
              leading: ADBackButton()),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ///------------First Container orderStatus-number
                Container(
                  height: size.height * 0.09,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            locale.orderStatus.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            bookingData.statusText.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: bookingData.status == 'done'
                                        ? Color(0XFF1FA88F)
                                        : bookingData.status == 'pending'
                                            ? Color(0XFF8304B0)
                                            : bookingData.status == 'confirmed'
                                                ? Color(0XFF1FA88F)
                                                : bookingData.status ==
                                                        'rejected'
                                                    ? Color(0xffFFC107)
                                                    : bookingData.status ==
                                                            'cancel'
                                                        ? Colors.red
                                                        : Color(0xffDD5406)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "${locale.isDirectionRTL(context) ? "رقم الحجز : " : "Book Number"}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            bookingData.id.toString(),
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                defaultSizeBoxTwo(size),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      ///------------second Widget Car details
                      Row(
                        children: [
                          Text(
                            locale.carSelected2.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      defaultSizeBoxTwo(size),
                      Container(
                        width: double.infinity,
                        height: size.height * 0.09,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: Image.network(
                                    bookingData.car.photo.toString())),
                            Text(
                              bookingData.car.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: [
                                  Text(
                                    bookingData.price.toString() +
                                        locale.sar.toString(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                  Text(
                                    "/" + locale.day.toString(),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                            .withOpacity(0.5)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      defaultSizeBoxTwo(size),

                      ///Container Three Deliver and receive
                      Row(
                        children: [
                          Text(
                            locale.deliverAndReceiveData.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      defaultSizeBoxTwo(size),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(6)),
                        child: Column(
                          children: [
                            ///------Receive Data----------
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.03,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.04,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03),
                                        child: Text(
                                          locale.reservation.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Expanded(
                                    child: Text(
                                      bookingData.recivingBranch.address
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ///---------Deliver Data----------
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.03,
                                  vertical: size.height * 0.00),
                              child: Row(
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.04,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03),
                                        child: Text(
                                          locale.delivery.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.04),
                              child: Row(
                                children: [
                                  Icon(Icons.gps_fixed),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Expanded(
                                    child: Text(
                                      bookingData.deliveryBranch.address
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            defaultSizeBoxTwo(size),

                            ///------Card time TIME -------------
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ///-----------From--------------
                                      Icon(Icons.watch_later_outlined),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.sp),
                                        child: Text(
                                          locale.from.toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        bookingData.receive_time.toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),

                                  ///-----------TO--------------
                                  Row(
                                    children: [
                                      // Icon(Icons.watch_later_outlined),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.sp),
                                        child: Text(
                                          locale.to.toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text(
                                        bookingData.deliver_time.toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            defaultSizeBoxTwo(size),

                            ///------Card Date -------------
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.01),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      ///-----------From--------------
                                      Icon(Icons.calendar_month),
                                      // Text(locale.from.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.sp),
                                        child: Text(
                                          bookingData.receive_date.toString(),
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///-----------TO--------------
                                  Row(
                                    children: [
                                      // Icon(Icons.calendar_month),
                                      // Text(locale.to.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                      Text(
                                        bookingData.deliver_date.toString(),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            )
                          ],
                        ),
                      ),
                      defaultSizeBoxTwo(size),

                      ///--------------Payment Details--------------
                      Row(
                        children: [
                          Text(
                            locale.isDirectionRTL(context)
                                ? "تفاصيل الدفع"
                                : "Cheque",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      defaultSizeBoxTwo(size),
                      Container(
                        width: double.infinity,
                        // height: size.height*0.48,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                                width: 1.2),
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02,
                              vertical: size.width * 0.03),
                          child: Column(
                            children: [
                              RowRentDetails(
                                  title: locale.rent.toString(),
                                  resultTitle: bookingData.total.toString()),
                              RowRentDetails(
                                  title: locale.additions.toString(),
                                  resultTitle:
                                      bookingData.additions.toString()),
                              RowRentDetails(
                                  title: locale.tam.toString(),
                                  resultTitle:
                                      bookingData.tamm_price.toString()),

                              ///extra driver
                              RowRentDetails(
                                  title: locale.total2.toString(),
                                  resultTitle: bookingData.total.toString()),
                              RowRentDetails(
                                  title: locale.memberDiscount.toString(),
                                  resultTitle: bookingData.membership_discount
                                      .toString()),
                              RowRentDetails(
                                  title: locale.promotionalDiscount.toString(),
                                  resultTitle: bookingData.promotional_discount
                                      .toString()),
                              RowRentDetails(
                                  title: locale.visaDiscount.toString(),
                                  resultTitle:
                                      bookingData.visaAmout.toString()),
                              RowRentDetails(
                                  title: locale.total3.toString(),
                                  resultTitle:
                                      bookingData.net_price.toString()),
                              RowRentDetails(
                                  title: locale.taxValue.toString(),
                                  resultTitle:
                                      bookingData.vat_value.toString()),
                              RowRentDetails(
                                  title: locale.total.toString(),
                                  resultTitle:
                                      bookingData.general_total.toString()),
                            ],
                          ),
                        ),
                      ),
                      bookingData.status != "completed" ||
                              bookingData.status != "pinging"
                          ? SizedBox(
                              height: size.height * 0.07,
                            )
                          : SizedBox(height: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class RowRentDetails extends StatelessWidget {
  const RowRentDetails(
      {Key? key, required this.title, required this.resultTitle})
      : super(key: key);
  final String title;
  final String resultTitle;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Text(
              resultTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              " " + locale.sar.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ],
    );
  }
}
