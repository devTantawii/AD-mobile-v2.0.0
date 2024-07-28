import 'dart:io';
import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/data/models/step_one_order_model.dart';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/payment/blocs/invoice_cubit.dart';
import 'package:abudiyab/modules/home/payment/data/models/credit_card_model.dart';
import 'package:abudiyab/modules/home/payment/invouce_notCompleted.dart';
import 'package:abudiyab/modules/home/payment/widget/coupon_tile.dart';
import 'package:abudiyab/modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../core/constants/langCode.dart';
import '../../widgets/components/ad_gradient_btn.dart';
import '../additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import '../profile/page/privacy_policy/privacy_policy.dart';
import 'invoice.dart';
import 'widget/payment_card.dart';
import 'widget/title_widget.dart';

class PaymentMethodsScreen extends StatefulWidget {
  final bool newBooking;
  final DataCars? carModel;
  final StepOneOrderModel? stepOneOrderModel;
  final bool isAutomated;
  final bool? isNotCompleted;
  final DataCars? datum;
  String? orderId;
  final CreditCardModel? cardModel;

  PaymentMethodsScreen(
      this.newBooking,
      {required this.stepOneOrderModel,
      required this.carModel,
      this.isAutomated = false,
      this.datum,
      this.isNotCompleted,
       this.orderId,
      this.cardModel});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  bool _isAgreeTerms = false;
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<BookingCubit, BookingState>(
                  buildWhen: (previous, current) =>
                      previous != current && current is PaymentMethodChanged,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         if (widget.stepOneOrderModel==null?
                         BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.visaActive!:widget.stepOneOrderModel!.visaActive!)
                          PaymentMethodCard(
                            text: locale.visa.toString(),
                            color: Theme.of(context).colorScheme.background,
                            svg: Assets.icon_cvv,
                          ),
                        if (widget.stepOneOrderModel==null?
                        BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.cashActive!: widget.stepOneOrderModel!.cashActive!)
                          PaymentMethodCard(
                            text: locale.cash.toString(),
                            color: Theme.of(context).colorScheme.background,
                            svg: Assets.icon_money,
                          ),
                        if (widget.stepOneOrderModel==null?
                        BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.apple_active!: widget.stepOneOrderModel!.apple_active!)
                          Platform.isIOS?PaymentMethodCard(
                            text: 'Apple Pay'.toString(),
                            color: Theme.of(context).colorScheme.background,
                            svg: Assets.icon_apple_pay,
                          ):Container(),
                        if (widget.stepOneOrderModel==null?
                        BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.pointsActive!: widget.stepOneOrderModel!.pointsActive!)
                          Align(
                            alignment: Alignment.center,
                            child: PaymentMethodCard(
                              text: locale.points.toString(),
                              color: Theme.of(context).colorScheme.background,
                              svg: Assets.icon_points,
                            ),
                          ),
                        CouponTile(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Theme(
                              data: ThemeData(
                                primarySwatch: Colors.blue,
                                unselectedWidgetColor: Theme.of(context)
                                    .colorScheme
                                    .onPrimary, // Your color
                              ),
                              child: Transform.scale(
                                scale: 1.2,
                                child: Checkbox(
                                    value: _isAgreeTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAgreeTerms = value!;
                                      });
                                    }),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => PrivacyPolicyScreen()));
                              },
                              child: Text(
                                locale.agreeTerms.toString(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20.sp,
              ),
            ],
          ),
          widget.newBooking
              ? Align(
                  alignment: locale.isDirectionRTL(context)
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  child: BlocConsumer<AdditionsCubit,AdditionsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return  state is CheckOrderStateLoading ||state is InvoiceLoading ?Center(child: CircularProgressIndicator.adaptive(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      )):GestureDetector(
                        onTap: () async {
                          if (BlocProvider.of<BookingCubit>(context).selectedPaymentMethods != null && _isAgreeTerms) {
                            context.read<BookingCubit>().additions = context.read<AdditionsCubit>().additions;
                            // widget.isNotCompleted==true? context.read<AdditionsCubit>().checkOrderStep(orderId: widget.orderId):false;
                            if (BlocProvider.of<BookingCubit>(context).selectedPaymentMethods != locale.visa.toString()&&BlocProvider.of<BookingCubit>(context).selectedPaymentMethods != locale.applePay.toString()) {
                              // widget.isNotCompleted==true?context.read<AdditionsCubit>().stepModel!.order!.additions.toString().isEmpty:false;
                              if(widget.isNotCompleted==true){
                                context.read<AdditionsCubit>().stepModel!.order!.additions.toString().isEmpty;
                                await BlocProvider.of<InvoiceCubit>(context).getInvoiceNotCompletedOrder(context,widget.orderId.toString());
                                await context.read<AdditionsCubit>().checkOrderStep(orderId: widget.orderId);
                                 pushNewScreen(
                                    context,
                                    withNavBar: false,
                                    screen:InvoiceNotCompletedUI(
                                      carModel: widget.carModel,
                                      orderID:widget.orderId.toString(),
                                      isNotCompletedOrder: widget.isNotCompleted==true?true:false,
                                    ));
                              }else{
                                pushNewScreen(
                                    context,
                                    withNavBar: false,
                                    screen:InvoiceUI(
                                      carModel: widget.carModel,
                                      orderID:widget.orderId.toString(),
                                      isNotCompletedOrder: widget.isNotCompleted==true?true:false,
                                    ));
                              }
                            }
                            else if (BlocProvider.of<BookingCubit>(context).selectedPaymentMethods == locale.visa.toString()) {
                              // widget.isNotCompleted==true?await context.read<AdditionsCubit>().checkOrderStep(orderId: widget.orderId):false;
                              if(isVisa !=true){
                                HelperFunctions.showFlashBar(
                                  context: context,
                                  title: "",
                                  message: locale.isDirectionRTL(context)
                                      ? "من فضلك تحقق من ملء بيانات الكارت في المكان المخصص واعد المحاولة"
                                      : "Please check your credit card and try again",
                                  icon: Icons.info,
                                  color: Color(0xffF6A9A9),
                                  titlcolor: Colors.red,
                                  iconColor: Colors.red,
                                );
                              }
                              else{
                                if(widget.isNotCompleted==true){
                                  pushNewScreen(
                                      context,
                                      withNavBar: false,
                                      screen:InvoiceNotCompletedUI(
                                        carModel: widget.carModel,
                                        orderID:widget.orderId.toString(),
                                        isNotCompletedOrder: widget.isNotCompleted==true?true:false,
                                      ));

                                }else{
                                  pushNewScreen(
                                      context,
                                      withNavBar: false,
                                      screen: InvoiceUI(
                                        carModel: widget.carModel,
                                        orderID:widget.orderId.toString(),
                                        isNotCompletedOrder: widget.isNotCompleted==true?true:false,
                                      ));

                                }
                              }
                            }

                            ///--------------ApplePay-------------
                            else if(BlocProvider.of<BookingCubit>(context).selectedPaymentMethods == locale.applePay.toString()){
                              await BlocProvider.of<InvoiceCubit>(context).getInvoice(context);
                              Duration(seconds: 1);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InvoiceUI(carModel: widget.carModel,)));
                            }
                            ///--------------END Apple Pay---------------
                          } else {
                            HelperFunctions.showFlashBar(
                              context: context,
                              title: "",
                              message: locale.noMethodSelected.toString(),
                              icon: Icons.info,
                              color: Color(0xffF6A9A9),
                              titlcolor: Colors.red,
                              iconColor: Colors.red,
                            );
                          }
                        },
                        child: ADGradientButton(locale.goToPayment.toString()),
                      );
                    },
                  ))
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

