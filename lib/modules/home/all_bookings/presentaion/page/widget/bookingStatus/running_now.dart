import 'package:abudiyab/modules/auth/signin/presentation/pages/signin_screen.dart';
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

class RunningNow extends StatefulWidget { 
  const RunningNow({super.key});

  @override
  State<RunningNow> createState() => _RunningNowState();
}

class _RunningNowState extends State<RunningNow> {
  @override
  void initState() {
    BlocProvider.of<AllBookingCubit>(context).getAllBooking(state:'running');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var locale = AppLocalizations.of(context)!;
    return  Padding(
      padding:  EdgeInsets.only(bottom: size.height*0.08),
      child: BlocConsumer<AllBookingCubit,AllBookingState>(
        listener: (context, state) {
          if(state is AllBookingLoading){
            Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
            );
          }
          if (state is AllBookingError) {
            HelperFunctions.showFlashBar(
                context: context,
                title: locale.error.toString(),
                message: state.error.contains('Not Authenticated')?locale.loginToContinue.toString():state.error.contains('Data Not Found')?locale.noCarsBooking1.toString():state.error.toString(),
                icon: Icons.info,
                color: Color(0xffF6A9A9),
                titlcolor: Color(0xffD62E2E),
                iconColor: Color(0xffD62E2E)
            );
            if(state.error.contains('Not Authenticated')){
              navigateTo(context, SignInScreen());
            }
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
            BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
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
            BlocProvider.of<AllBookingCubit>(context).getAllBooking(state: 'running');
            HelperFunctions.showFlashBar(
                color:Color(0xffDCEFE3) ,
                context: context,
                title: '',
                message: locale.isDirectionRTL(context)?'تم حذف الطلب بنجاح':'Order has been Deleted Successfully',
                titlcolor: Color(0xff327B5B),
                icon: Icons.check,
                iconColor: Color(0xff327B5B),
            );
          }
        },
        builder: (context, state) {
          if(state is AllBookingLoading){
            return Center(child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ));
          }else if( state is AllBookingLoaded){
            return  ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                var carData = BlocProvider.of<AllBookingCubit>(context).booking!.data;
                var bookingData = BlocProvider.of<AllBookingCubit>(context).booking!.data;
                return Stack(
                    alignment: locale.isDirectionRTL(context)
                        ? Alignment.topLeft
                        : Alignment.topRight,
                    children: [
                      Container(
                        margin:  EdgeInsets.only(bottom: 13.0.sp),
                        padding:  EdgeInsets.all(size.width *0.02),
                        height: MediaQuery.of(context).size.height * 0.26,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.015,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.02),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      AutoSizeText("${bookingData![index]!.createdAt}",style: Theme.of(context).textTheme.bodyLarge,),
                                      Spacer(),
                                      Container(
                                          decoration:BoxDecoration(
                                              color: bookingData[index]!.status =='pending'?Color(0XFF8304B0):bookingData[index]!.status =='notcompleted'?Color(0XFFDD5406):Color(0XFF4B48D4),
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.h),
                                            child: Text(bookingData[index]!.statusText.toString(),
                                              style: TextStyle(
                                                  color:Color(0XFFFDFDFD),
                                                  // color: bookingData.status =='done'?Color(0XFF1FA88F):bookingData.status =='rejected'?Color(0XFFD62E2E):Color(0xffFFC107),
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600
                                              ),),
                                          )
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      AutoSizeText("${locale.isDirectionRTL(context)?"رقم الحجز : ":"Book Number"}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600

                                          )),
                                      AutoSizeText("${bookingData[index]!.id}",style: TextStyle(
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: size.width*0.02,
                                ),
                                child: Column(
                                  children: [
                                    Row(
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
                                                    contant: "${carData![index]!.car.name}",
                                                    title: "${locale.carName} :",
                                                    size: 21,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context).size.width * 0.015,
                                                ),
                                                FittedBox(
                                                  child: TextTileWidget(
                                                    contant: "${bookingData[index]!.price}"+" "+locale.sar.toString(),
                                                    title: locale.isDirectionRTL(context)?"تكلفة الحجز: ":"Total amount: ",
                                                    size: 30,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.02,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Align(
                                              alignment:
                                              AlignmentDirectional.center,
                                              child: Image.network(carData[index]!.car.photo)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            navigateTo(context, BookDetails(
                                              bookingData: bookingData[index]!,
                                            ));
                                          },
                                          child: Padding(
                                            padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffE1E6F8),
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              child: Padding(
                                                padding:  EdgeInsets.symmetric(horizontal: size.width*0.03,vertical: 2),
                                                child: Text(locale.bookingDetails.toString().replaceAll('Details', '').replaceAll('الحجز', ''),
                                                  style: defaultTextStyle(14, FontWeight.w600,Theme.of(context).colorScheme.primary),),
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Container(
                                                  height: size.height*0.23,
                                                  color: Theme.of(context).colorScheme.onSecondary,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: size.height*0.01,),
                                                      Container(
                                                        height: size.height*0.007,
                                                        width: size.width*0.2,
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(context).colorScheme.onPrimary,
                                                            borderRadius: BorderRadius.circular(20)
                                                        ),
                                                      ),
                                                      SizedBox(height: size.height*0.01,),
                                                      Center(
                                                        child: Text(locale.wantToCancel.toString(),style: Theme.of(context).textTheme.titleMedium,),
                                                      ),
                                                      SizedBox(height: size.height*0.02,),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap:(){
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: size.width*0.25,
                                                              height: size.height*0.045,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  border: Border.all(
                                                                      color: Theme.of(context).colorScheme.onPrimary
                                                                  )
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  locale.isDirectionRTL(context)?"عدم الالغاء":"No",
                                                                  style: TextStyle(
                                                                      color: Theme.of(context).colorScheme.onPrimary
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap:()async {
                                                              await BlocProvider.of<AllBookingCubit>(context).cancelBooking(orderId: bookingData[index]!.id,);
                                                              // BlocProvider.of<AllBookingCubit>(context).getAllBooking();
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              width: size.width*0.25,
                                                              height: size.height*0.045,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  border: Border.all(
                                                                      color: Colors.red
                                                                  ),
                                                                  color:Colors.red
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  locale.isDirectionRTL(context)?"الغاء الحجز":"Cancel Order",
                                                                  style: TextStyle(
                                                                      color: Colors.white
                                                                  ),
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(8)
                                            ),
                                            child: Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.h),
                                              child: Text(locale.cancel.toString(),style: defaultTextStyle(14, FontWeight.w600, Colors.white),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )

                    ]);
              },
              itemCount: BlocProvider.of<AllBookingCubit>(context).booking!.data!.length,
            );
          }else{
           return  whenOrdersNull(locale);
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
              Text(locale.noCarsBooking1.toString(),style:Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,)),
            ],
          ),
        ),
      ],
    );
  }
}
