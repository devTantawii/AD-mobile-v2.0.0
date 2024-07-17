import 'package:abudiyab/core/helpers/validation/form_validator.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class BottomSheetContant extends StatefulWidget {
  const BottomSheetContant({Key? key}) : super(key: key);

  @override
  State<BottomSheetContant> createState() => _BottomSheetContantState();
}

class _BottomSheetContantState extends State<BottomSheetContant> {
  var cardHolderName = TextEditingController();

  var cardNumber = TextEditingController();

  var cvv = TextEditingController();

  var month = TextEditingController();

  var year = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 15),
                ADPrimTextForm(
                  inputFormatters: [
                    CreditCardNumberInputFormatter(
                        onCardSystemSelected: (cardSystemData) {
                      print(cardSystemData?.system ?? "null");
                      print(cardNumber.text.toString());
                    }),
                  ],
                  sizeText: 20,
                  controller: cardNumber,
                  type: TextInputType.number,
                  label: "Card Number",
                  pIcon: Icons.credit_card_sharp,
                  validat: (value) =>
                      FormValidator.creditValidate(context, value),
                ),
                SizedBox(height: 10),
                ADPrimTextForm(
                  controller: cardHolderName,
                  type: TextInputType.name,
                  label: "Card Holder Name",
                  pIcon: Icons.camera_front_rounded,
                  validat: (value) =>
                      FormValidator.nameValidate(context, value),
                ),
                SizedBox(height: 10),
                ADPrimTextForm(
                  controller: month,
                  type: TextInputType.number,
                  label: "Expire Month",
                  pIcon: Icons.calendar_today,
                  auth: false,
                  validat: FormValidator.dateValidate,
                ),
                SizedBox(height: 10),
                ADPrimTextForm(
                  controller: year,
                  type: TextInputType.number,
                  label: "Expire Year",
                  pIcon: Icons.calendar_today,
                  auth: false,
                  validat: FormValidator.dateValidate,
                ),
                SizedBox(height: 10),
                ADPrimTextForm(
                  controller: cvv,
                  type: TextInputType.number,
                  label: "CVV",
                  pIcon: Icons.credit_card_sharp,
                  auth: false,
                  validat: (value) => FormValidator.cvvValidate(context, value),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 45,
                  child: InkWell(
                    onTap: () {},
                    child: ADGradientButton(locale!.bookNow),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
