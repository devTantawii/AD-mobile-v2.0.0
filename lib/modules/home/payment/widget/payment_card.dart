import 'dart:ui';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/langCode.dart';
import '../../../../core/helpers/validation/form_validator.dart';
import '../../../../language/locale.dart';
import '../../../widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import '../blocs/invoice_cubit.dart';
import '../data/models/credit_card_model.dart';

class PaymentMethodCard extends StatefulWidget {
  final Color color;
  final String text;
  final String ?svg;

  const PaymentMethodCard({
    required this.color,
    required this.text,
     this.svg,
  });

  @override
  State<PaymentMethodCard> createState() => _PaymentMethodCardState();
}

class _PaymentMethodCardState extends State<PaymentMethodCard> {
  var cardHolderName = TextEditingController();
  var cardNumber = TextEditingController();
  var cvv = TextEditingController();
  var month = TextEditingController();
  var year = TextEditingController();
  bool? see = true;
  final _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return _CardBackground(
      child: GestureDetector(
        onTap: () async {
          BlocProvider.of<BookingCubit>(context).setPaymentMethods(widget.text);
          await BlocProvider.of<BookingCubit>(context).selectedPaymentMethods == locale!.visa.toString()
              ? showModalBottomSheet(
                  isScrollControlled: true,
                  elevation: 0,
                  isDismissible: true,
                  backgroundColor:Theme.of(context).brightness == Brightness.light ? Colors.white : Theme.of(context).colorScheme.primary,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: size.height * 0.9,
                      width: double.infinity,
                      child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.sp),
                                  Container(
                                    width: 80.sp,
                                    height: 6.sp,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        color: Color(0xff505AC9)),
                                  ),
                                  SizedBox(height: 15.sp),
                                  ADPrimTextForm(
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      CardNumberFormatter(),
                                      //  CreditCardNumberInputFormatter(
                                      //      onCardSystemSelected: (cardSystemData) {}
                                      //  )
                                    ],
                                    sizeText: 20,
                                    maxlenth: 19,
                                    controller: cardNumber,
                                    type: TextInputType.number,
                                    label: locale.isDirectionRTL(context)
                                        ? 'رقم البطاقة'
                                        : "Card Number",
                                    pIcon: Icons.credit_card_sharp,
                                    validat: (value) =>
                                        FormValidator.creditValidate(
                                            context, value),
                                  ),
                                  SizedBox(height: 10.sp),
                                  ADPrimTextForm(
                                    controller: cardHolderName,
                                    type: TextInputType.name,
                                    label: locale.isDirectionRTL(context)
                                        ? 'الأسم'
                                        : "Card Holder Name",
                                    pIcon: Icons.camera_front_rounded,
                                    validat: (value) =>
                                        FormValidator.nameValidate(
                                            context, value),
                                  ),
                                  SizedBox(height: 10.sp),
                                  ADPrimTextForm(
                                    maxlenth: 2,
                                    controller: month,
                                    type: TextInputType.number,
                                    label: locale.isDirectionRTL(context)
                                        ? 'شهر الانتهاء'
                                        : "Expire Month",
                                    pIcon: Icons.calendar_today,
                                    auth: false,
                                    validat: FormValidator.dateValidate,
                                  ),
                                  SizedBox(height: 10.sp),
                                  ADPrimTextForm(
                                    maxlenth: 2,
                                    controller: year,
                                    type: TextInputType.number,
                                    label: locale.isDirectionRTL(context)
                                        ? 'سنة الانتهاء'
                                        : "Expire Year",
                                    pIcon: Icons.calendar_today,
                                    auth: false,
                                    validat: FormValidator.dateValidate,
                                  ),
                                  SizedBox(height: 10.sp),
                                  ADPrimTextForm(
                                    maxlenth: 3,
                                    controller: cvv,
                                    type: TextInputType.number,
                                    label: "CVV",
                                    pIcon: Icons.credit_card_sharp,
                                    auth: false,
                                    validat: (value) =>
                                        FormValidator.cvvValidate(
                                            context, value),
                                  ),
                                  SizedBox(height: 10.sp),
                                  GestureDetector(
                                      onTap: bookNowWithVisa,
                                      child: ADGradientButton(
                                          locale.isDirectionRTL(context)
                                              ? 'اضافه البطاقه'
                                              : 'Add Payment Card')),
                                  SizedBox(
                                    height: size.height * 0.05,
                                  )
                                ],
                              ),
                            ),
                          )),
                    );
                  },
                )
              : SizedBox.shrink();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
          child: Container(
            height: size.height * 0.058,
            width: size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BlocProvider.of<BookingCubit>(context).selectedPaymentMethods !=
                        widget.text
                    ? BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                      )
                    : BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(0.4),
                      ),
              ],
              border: Border.all(width: 1, color: Color(0xffDDDDDD)),
              color: BlocProvider.of<BookingCubit>(context)
                          .selectedPaymentMethods ==
                      widget.text
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                  : Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(widget.svg!,fit: BoxFit.cover,),
                  ),

                  SizedBox(width: 10.sp),
                  Text(
                    this.widget.text,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
              Spacer(),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Icon(BlocProvider.of<BookingCubit>(context)
                    .selectedPaymentMethods ==
                    widget.text ? Icons.check_circle : Icons.radio_button_off,
                  color: Theme.of(context).brightness==Brightness.light?Colors.black54:Colors.white,
                  size: 25,
                ),
              )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  bookNowWithVisa() async {
    if (_formKey.currentState!.validate()) {
      CreditCardModel cardModel = CreditCardModel(
        orderId: context.read<BookingCubit>().orderID.toString(),
        nameOnCard: cardHolderName.text,
        cardNumber: cardNumber.text.replaceAll("-", "").trim(),
        paymentType: context
            .read<BookingCubit>()
            .selectedPaymentMethods
            .toString()
            .toLowerCase(),
        securityCode: int.parse(cvv.text),
        expiryMonth: int.parse(month.text.substring(0, 2)),
        expiryYear: int.parse(year.text.substring(0, 2)),
        couponCode: context.read<BookingCubit>().couponCode,
      );
      setState(() {
        cardNameSaved = cardHolderName.text;
        cardNumberSaved = cardNumber.text.replaceAll("-", "").trim();
        securityNumberSaved = int.parse(cvv.text);
        expiryMonthSaved = int.parse(month.text.substring(0, 2));
        expiryYearSaved = int.parse(year.text.substring(0, 2));
        isVisa = true;
        Navigator.pop(context);
      });
      // widget.isAutomated
      //     ? await BlocProvider.of<InvoiceCubit>(context)
      //     .activeAutomatedPaymentStep(cardModel)
      //     : await BlocProvider.of<InvoiceCubit>(context)
      //     .activePaymentStep(cardModel);
    } else {
      setState(() {
        isVisa = false;
      });
    }
  }
  //  myRadioButton({
  //   String? title,
  //   int ?value,
  //    Function?onChanged,
  // }){
  //   return RadioListTile(
  //     value: value,
  //     groupValue: _groupValue,
  //     onChanged:onChanged,
  //     title: Text(title.toString()),
  //   );
  // }
}

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue previousValue,
    TextEditingValue nextValue,
  ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = new StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write('-');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: new TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(5.sp),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: this.child,
          ),
        ),
      );
}
