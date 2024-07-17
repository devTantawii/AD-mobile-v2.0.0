import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/check_order_step_model.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/page/bookDetailes.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/commponents.dart';
import '../../additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import '../../all_bookings/data/model/booking_model.dart';
import '../blocs/invoice_cubit.dart';

class InfoInvoiceNotCompletedWidget extends StatefulWidget {
  final ValueChanged<bool> onExpanded;
  final InvoiceModel? invoiceModel;
  final DataCars? carModel;
  final bool pageFromNotCompleted;
  final String ?orderID;
  final Datum? bookingData;

  InfoInvoiceNotCompletedWidget(
      {Key? key,
      required this.onExpanded,
      this.invoiceModel,
      this.pageFromNotCompleted = false,
      this.carModel,
      this.orderID,
      this.bookingData,
      })
      : super(key: key);

  @override
  _InfoInvoiceNotCompletedWidgetState createState() => _InfoInvoiceNotCompletedWidgetState();
}

class _InfoInvoiceNotCompletedWidgetState extends State<InfoInvoiceNotCompletedWidget> {
  final GlobalKey columnlKey = GlobalKey();
  late bool _see;
  double? height;

  @override
  void initState(){
    // getStepModel();
    super.initState();
    _see = false;
    height = 0.0;
  }

  getStepModel(){
    context.read<AdditionsCubit>().checkOrderStep(orderId: widget.orderID.toString());
  }
  void changeExpandedValue() {
    final currentContext = columnlKey.currentContext!;
    final box = currentContext.findRenderObject() as RenderBox?;

    if (_see) {
      setState(() {
        height = 0.0;
        _see = !_see;
      });
      widget.onExpanded(_see);
    } else {
      setState(() {
        height = box!.size.height;
        _see = !_see;
      });
      widget.onExpanded(_see);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    CheckOrderStepModel? stepModel = BlocProvider.of<AdditionsCubit>(context).stepModel;
    return BlocConsumer<AdditionsCubit, AdditionsState>(
      listener: (context, state) {
        if (state is AdditionsLoading) {
          Center(child: CircularProgressIndicator.adaptive());
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            ///Container Deliver and receive
            Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: Row(
                      children: [
                        Text(
                          locale!.bookingDetails.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                  defaultSizeBoxTwo(size),
                  Container(
                    height: size.height*0.37,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
                              vertical: size.height * 0.00),
                          child: Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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

                                  stepModel!.order!.receivePlace
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                                      stepModel.order!.deliverPlace.toString(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        defaultSizeBoxTwo(size),

                        ///------Card Footer TIME ----------
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ///-----------From--------------
                                  Icon(Icons.watch_later_outlined),
                                  Text(
                                    locale.from.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                         stepModel.order!.receiveTime
                                            .toString(),
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
                                  Text(
                                    locale.to.toString(),
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                        stepModel.order!.deliverTime
                                            .toString(),
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
                          padding:  EdgeInsets.symmetric(horizontal: size.width*0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  ///-----------From--------------
                                  Icon(Icons.calendar_month),
                                  // Text(locale.from.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                  Text(stepModel.order!.receiveDate!.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                ],
                              ),
                              ///-----------TO--------------
                              Row(
                                children: [
                                  // Icon(Icons.calendar_month),
                                  // Text(locale.to.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                  Text(stepModel.order!.receiveDate!.toString(),style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  defaultSizeBoxTwo(size),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      width: 1.2),
                  borderRadius: BorderRadius.circular(6)),
              child: Padding(
                padding: EdgeInsets.all(12.sp),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          locale.total.toString(),
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                        stepModel.order!.generalTotal.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 36.0,
                      child: Divider(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    Column(
                      children: [
                        RowRentDetails(
                            title: locale.rent.toString(),
                            resultTitle:
                                 stepModel.order!.rentPrice.toString()),
                        RowRentDetails(
                            title: locale.additions.toString(),
                            // resultTitle: BlocProvider.of<InvoiceCubit>(context).data!.featuresPrice.toString().isEmpty?stepModel.order!.additions.toString():BlocProvider.of<InvoiceCubit>(context).data!.featuresPrice.toString(),
                             resultTitle:stepModel.order!.additions.toString(),
                                ),
                        RowRentDetails(
                            title: locale.tam.toString(),
                            resultTitle:
                                stepModel.order!.tammPrice!.toString()
                                ),
                        RowRentDetails(
                            title: locale.total2.toString(),
                            resultTitle:
                                 stepModel.order!.total.toString()
                               ),
                        RowRentDetails(
                            title: locale.memberDiscount.toString(),
                            resultTitle:
                                 stepModel.order!.membershipDiscount
                                    .toString()
                                ),
                        RowRentDetails(
                            title: locale.promotionalDiscount.toString(),
                            resultTitle:
                               stepModel.order!.promotionalDiscount
                                    .toString()),
                        RowRentDetails(
                            title: locale.netAmount.toString(),
                            resultTitle:
                                stepModel.order!.netPrice.toString()
                                ),
                        RowRentDetails(
                            title: locale.taxValue.toString(),
                            resultTitle:
                                 stepModel.order!.vatValue.toString()
                                ),
                        RowRentDetails(
                            title: locale.grandTotal.toString(),
                            resultTitle:  stepModel.order!.generalTotal.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}