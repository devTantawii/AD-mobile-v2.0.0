import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/allbooking_state.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/widget/texttile_widget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Padding(
      padding:  EdgeInsets.only(bottom: size.height*0.08),
      child: BlocConsumer<AllBookingCubit,AllBookingState>(
         listener:(context, state) {
           if (state is AllBookingError) {
             HelperFunctions.showFlashBar(
                 context: context,
                 title: locale.error.toString(),
                 message: state.error,
                 icon: Icons.info,
                 color: Color(0xffF6A9A9),
                 titlcolor: Color(0xffD62E2E),
                 iconColor: Color(0xffD62E2E)
             );

           }
           if (state is CancelError) {
             HelperFunctions.showFlashBar(
                 context: context,
                 title: locale.error.toString(),
                 message: state.error,
                 icon: Icons.warning_amber,
                 color: Color(0xffF6A9A9),
                 titlcolor: Color(0xffD62E2E),
                 iconColor: Color(0xffD62E2E)
             );
           }
           if (state is CancelSuccess) {
             BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'ended');
             HelperFunctions.showFlashBar(
                 color:Color(0xffDCEFE3) ,
                 context: context,
                 title: '',
                 message: locale.isDirectionRTL(context)?'تم الغاء الطلب بنجاح':'Order has been cancelled Successfully',
                 titlcolor: Color(0xff327B5B),
                 icon: Icons.check,
                 iconColor: Color(0xff327B5B)
             );
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
                 iconColor: Color(0xffD62E2E)
             );
           }
           if (state is DeleteOrderSuccess) {
             BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'ended');
             HelperFunctions.showFlashBar(
                 color:Color(0xffDCEFE3) ,
                 context: context,
                 title: '',
                 message: locale.isDirectionRTL(context)?'تم حذف الطلب بنجاح':'Order has been Deleted Successfully',
                 titlcolor: Color(0xff327B5B),
                 icon: Icons.check,
                 iconColor: Color(0xff327B5B)
             );
           }
           if(state is AllBookingLoading){
             Center(
               child: CircularProgressIndicator.adaptive(
                 backgroundColor: Theme.of(context).colorScheme.surface,
               ),
             );
           }
         },
        builder: (context, state) {
          if(state is AllBookingLoading){
            return Center(child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ));
          }else if(BlocProvider.of<AllBookingCubit>(context).booking != null &&
              BlocProvider.of<AllBookingCubit>(context).booking!.data != null &&
              state is AllBookingLoaded) {
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var carData = BlocProvider.of<AllBookingCubit>(context).booking!.data![index]!.car;
                var bookingData = BlocProvider.of<AllBookingCubit>(context).booking!.data![index]!;
                return
                  Stack(
                      alignment: locale.isDirectionRTL(context)
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02),
                          child: Container(
                            margin:  EdgeInsets.only(bottom: 13.0.sp),
                            padding:  EdgeInsets.all(size.width*0.03),
                            height: MediaQuery.of(context).size.height * 0.28,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.width * 0.015,
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: size.width*0.03),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          AutoSizeText("${bookingData.createdAt}",style: Theme.of(context).textTheme.bodyLarge),
                                          Spacer(),
                                          Container(
                                              decoration:BoxDecoration(
                                                  color: bookingData.status =='done'?Color(0XFF1FA88F):bookingData.status =='rejected'?Color(0XFFFFC107):Color(0xffD62E2E),
                                                  borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: size.width*0.015,vertical: 5.h),
                                                child: Text(bookingData.statusText.toString(),style: TextStyle(
                                                    color:Color(0XFFFDFDFD),
                                                    // color: bookingData.status =='done'?Color(0XFF1FA88F):bookingData.status =='rejected'?Color(0XFFD62E2E):Color(0xffFFC107),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600
                                                ),),
                                              )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: size.height*0.01,),
                                      Row(
                                        children: [
                                          AutoSizeText("${locale.isDirectionRTL(context)?"رقم الحجز : ":"Book Number"}",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              )),
                                          AutoSizeText("${bookingData.id}",style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                          ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: size.width * 0.01),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 5,
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            alignment:
                                            locale.isDirectionRTL(context)
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                            child: Column(
                                              children: [
                                                FittedBox(
                                                  child: TextTileWidget(
                                                    contant: "${carData.name}",
                                                    title: "${locale.carName} :",
                                                    size: 21,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.015,
                                                ),
                                                FittedBox(
                                                  child: TextTileWidget(
                                                    contant: "${bookingData.price}"+" "+locale.sar.toString(),
                                                    title: locale.isDirectionRTL(context)?"المبلغ المدفوع: ":"Total amount: ",
                                                    size: 30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.01,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Align(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Image.network(carData.photo)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap:(){
                                    navigateTo(context, BookDetails(
                                      bookingData: bookingData,
                                    ));
                                  },
                                  child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.secondaryContainer,
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: 5.h),
                                        child: Text(locale.bookingDetails.toString().replaceAll('Details', '').replaceAll('الحجز', ''),style: defaultTextStyle(14, FontWeight.w600,Theme.of(context).colorScheme.primary),),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        )
                      ]);
              },
              itemCount: BlocProvider.of<AllBookingCubit>(context).booking!.data!.length,
            );
          }else{
            return whenOrdersNull(locale);
          }
        },
      ),
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
              // Text(locale.noCarsBookings.toString(),style:Theme.of(context).textTheme.titleMedium!.copyWith(
              //     fontSize: 28.sp,
              //     fontWeight: FontWeight.w700
              // ),),
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
