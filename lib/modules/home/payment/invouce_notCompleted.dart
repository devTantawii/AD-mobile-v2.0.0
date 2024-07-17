import 'dart:io';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/presentaion/pages/additions_screen.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/check_order_step_model.dart';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:abudiyab/modules/home/booking_confirmed/bookingConfirmed.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/payment/data/models/credit_card_model.dart';
import 'package:abudiyab/modules/home/payment/widget/info_invoice_notCompleted.dart';
import 'package:abudiyab/modules/home/payment/widget/web_payment.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/pay.dart';
import '../../../core/constants/langCode.dart';
import '../../../shared/commponents.dart';
import '../../widgets/components/ADHomeButton.dart';
import '../additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import '../all_bookings/data/model/booking_model.dart';
import 'blocs/invoice_cubit.dart';
import 'payment_configurations.dart' as payment_configurations;
class InvoiceNotCompletedUI extends StatefulWidget {
  final DataCars? carModel;
  // final InvoiceModel? invoiceModel;
  final bool ?isApplePay;
  final bool ?isNotCompletedOrder;
  final bool? hideAddition;
  final Datum? allBookingData;
  final String ?totalApplePay;
  final String ?orderID;
  final String ?paymentType;
  final CheckOrderStepModel? checkOrderStepModel;

  const InvoiceNotCompletedUI({
    Key? key,
    this.checkOrderStepModel,
    this.allBookingData,
    this.carModel,
    // this.invoiceModel,
    this.isApplePay,
    this.isNotCompletedOrder,
    this.totalApplePay,
    this.orderID,
    this.hideAddition,
    this.paymentType,
  }) : super(key: key);

  @override
  State<InvoiceNotCompletedUI> createState() => _InvoiceNotCompletedUIState();
}
class _InvoiceNotCompletedUIState extends State<InvoiceNotCompletedUI> {
  bool? see = true;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }
  // getInvoice() async {
  //   await BlocProvider.of<AdditionsCubit>(context).checkOrderStep(orderId: widget.orderID);
  // }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
         bottomNavigationBar:Container(
          width: size.width,
          decoration: BoxDecoration(),
          child: BlocProvider.of<BookingCubit>(context).selectedPaymentMethods ==locale!.applePay&&Platform.isIOS
              ? Padding(
            padding:  EdgeInsets.symmetric(vertical: size.height*0.018,horizontal: 15.sp),
            child: Container(
              height: size.height*0.065,
              width: size.width,
              child: ApplePayButton(
                // paymentConfiguration: PaymentConfiguration.fromJsonString(
                //
                //     payment_configurations.defaultApplePay),
                //  paymentConfigurationAsset: 'applepay.json',
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                    payment_configurations.defaultApplePay),
                paymentItems:[
                  PaymentItem(
                    label: locale.applePayTotal.toString(),
                    // amount:widget.isNotCompletedOrder==false?BlocProvider.of<InvoiceCubit>(context).data!.total.toString(): BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.total,
                    amount:BlocProvider.of<InvoiceCubit>(context).data!.total.toString(),
                    status: PaymentItemStatus.final_price,
                  ),
                ],
                style: ApplePayButtonStyle.black,
                type: ApplePayButtonType.buy,
                margin:  EdgeInsets.only(top: 15.0.sp),
                onPaymentResult: (value) {
                  navigateAndFinish(context, BookingConfirmed(orderId: widget.orderID.toString(),));
                },
                onError: (error) {
                  HelperFunctions.showFlashBar(
                      context: context,
                      title: locale.error.toString(),
                      message: error.toString(),
                      icon: Icons.warning_amber,
                      color: Color(0xffF6A9A9),
                      titlcolor: Colors.red,
                      iconColor: Colors.red
                  );
                },
                loadingIndicator:  Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ):
          BlocProvider.of<BookingCubit>(context).selectedPaymentMethods != locale.visa.toString()?BlocConsumer<InvoiceCubit,InvoiceState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              return Padding(
                padding:  EdgeInsets.symmetric(vertical: size.height*0.018,horizontal: 15.sp),
                child: state is InvoiceLoading?Center(child: CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                )):Container(
                  child: InkWell(
                    onTap: bookNow,
                    child: ADGradientButton(locale.bookNow.toString()),
                  ),
                ),);
            },
          )
              : Padding(
            padding:  EdgeInsets.symmetric(vertical: size.height*0.018,horizontal: 15.sp),
            child: BlocConsumer<InvoiceCubit,InvoiceState>(
              listener: (context, state) {},
              builder: (context, state) {
                return state is InvoiceLoading?Center(child: CircularProgressIndicator.adaptive(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                )):Container(
                  height: size.height*0.065,
                  child: InkWell(
                    onTap: bookNowWithVisa,
                    child: ADGradientButton(locale.bookNow.toString()),
                  ),
                );
              },
            ),
          ),
        ),
        appBar: AppBar(
          title: Text(
            locale.invoice.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 16.sp),
          ),
          leading:widget.isNotCompletedOrder==true?ADHomeButton(): ADBackButton(),
          // leading:ADBackButton(),
        ),
        body: BlocConsumer<InvoiceCubit, InvoiceState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              if (context.read<BookingCubit>().selectedPaymentMethods.toString().toLowerCase() ==
                  locale.visa.toString().toLowerCase()) {
                navigateAndFinish(
                    context,
                    WebPayment(
                      url: state.paymentStepModel.paymentUrl,
                    ));
                cardNameSaved = null;
                cardNumberSaved = null;
                securityNumberSaved = null;
                expiryMonthSaved = null;
                expiryYearSaved = null;
                isVisa = false;
              } else {
                navigateAndFinish(context, BookingConfirmed(orderId: widget.orderID.toString(),));
              }
            } else if(state is InvoiceFailed){
              Navigator.pop(context);
              HelperFunctions.dialog(
                context: context,
                title: locale.error.toString(),
                body: state.error,
              );
            }

          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ///------------First Widget Container------------
                  Container(
                    width: size.width,
                    height: 70.sp,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 20.sp,
                                height: 20.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary,
                                ),
                                child: Center(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0),
                                child: Text(
                                  locale.orderDetails.toString(),
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.primary),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(
                                Icons.circle_outlined,
                                color: Colors.black54,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3.0),
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
                  defaultSizeBoxTwo(size),
                  ///------------second Widget  details--------------------
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.04),
                    child: Row(
                      children: [
                        Text(
                          locale.carSelected.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        ///----------SOON-----------
                        Spacer(),
                        BlocConsumer<AdditionsCubit,AdditionsState>(
                          listener: (context, state) {
                            if( state is CheckOrderStateLoading){
                              CircularProgressIndicator.adaptive();
                            }
                          },
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: ()async{
                                navigateTo( context,AdditionsScreen(
                                  fromAddAdditions: true,
                                  datum: widget.carModel,
                                  fromNotCompleted: true,
                                  checkOrderStepModel:  BlocProvider.of<AdditionsCubit>(context).stepModel,
                                ));
                                setState(() {
                                  widget.isNotCompletedOrder==false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text(
                                    locale.additions.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Theme.of(context).colorScheme.onPrimary,
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width:50.sp,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.onPrimary
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  defaultSizeBoxTwo(size),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.09,
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
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
                                widget.carModel!.photo.toString())),
                        Text(
                          widget.carModel!.name,
                          style: TextStyle(
                            fontSize: 14.sp,
                          ),
                        ),
                        Spacer(),
                        Padding(padding:
                        const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: [
                              Text(
                                widget.carModel!.priceBefore.toString() +
                                    ' ',
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),

                              ),
                              Text(
                                widget.carModel!.priceAfter.toString() +
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
                  ///------------END second Widget Car details
                 InfoInvoiceNotCompletedWidget(
                    orderID: widget.orderID,
                    onExpanded: (value) =>
                        setState(() => see = !value),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bookNowWithVisa() async {
    await BlocProvider.of<InvoiceCubit>(context).activePaymentStep(
        CreditCardModel(
            orderId: context.read<BookingCubit>().orderID!=null?context.read<BookingCubit>().orderID.toString():BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.id.toString(),
            paymentType:context.read<BookingCubit>().selectedPaymentMethods!=null? context.read<BookingCubit>().selectedPaymentMethods.toString().toLowerCase()
                :BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.paymentType.toString().toLowerCase(),
            securityCode: securityNumberSaved,
            cardNumber: cardNumberSaved,
            expiryMonth: expiryMonthSaved,
            expiryYear: expiryYearSaved,
            nameOnCard: cardNameSaved));
  }

  bookNow() async {
    final CreditCardModel cardModel = CreditCardModel(
      orderId: context.read<BookingCubit>().orderID!=null?context.read<BookingCubit>().orderID.toString():widget.orderID,
      paymentType: context.read<BookingCubit>().selectedPaymentMethods!=null?context.read<BookingCubit>().selectedPaymentMethods.toString():widget.paymentType!.toLowerCase(),
      couponCode: context.read<BookingCubit>().couponCode,
    );
    await BlocProvider.of<InvoiceCubit>(context).activePaymentStep(cardModel);
  }
}
