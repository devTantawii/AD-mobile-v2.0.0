import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_state.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../../../widgets/components/ad_curve.dart';
import 'enter_code_oldcustomer_screan.dart';

class EnterInfoOldCustromerScrean extends StatelessWidget {
  EnterInfoOldCustromerScrean({Key? key}) : super(key: key);
  final idControler = TextEditingController();
  final phoneControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<OldCustomerCubit, OldCustomerState>(
          listener: (context, state) {
            if (state is ForgetError) {
              HelperFunctions.showFlashBar(
                context: context,
                title: locale!.error.toString(),
                message: state.error,
                icon: Icons.warning_amber,
                  color: Color(0xffF6A9A9),
                  titlcolor: Color(0xffD62E2E),
                  iconColor: Color(0xffD62E2E)
              );
            }
            if (state is ForgetLoaded) {
              pushNewScreen(context, screen: EnterCodeOldCustomerScrean());
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CurveWidget(
                        title:locale!.welcomeAgain.toString(),
                        subTitle:locale.oldCustomer.toString(),
                        positionTop: size.height*0.1,
                        positionBottom:size.height*0.16,
                        titleStyle: defaultTextStyle(24, FontWeight.w600, Colors.white),
                        subtitleStyle: defaultTextStyle(16, FontWeight.w400, Colors.white),
                        isHome: false,
                        forgetPasswordScreen: true,
                      ),
                      Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: ContainerTileWidget(
                              widgets: [
                                ADPrimTextForm(
                                    controller: idControler,
                                    type: TextInputType.number,
                                    label: locale.enterIdAndNumber.toString(),
                                    pIcon: Icons.credit_card_outlined),
                                SizedBox(
                                  height: 30.0,
                                ),
                                ADPrimTextForm(
                                    controller: phoneControler,
                                    type: TextInputType.number,
                                    label: locale.phoneNumber.toString(),
                                    pIcon: Icons.phone_iphone_sharp),
                                SizedBox(
                                  height: 30.0,
                                ),
                                state is ForgetLoading
                                    ? Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : Motion(
                                      child: Bounce(
                                          onTap: () {
                                            BlocProvider.of<OldCustomerCubit>(
                                                    context)
                                                .forgetOldCustomer(
                                                    phone: phoneControler.text,
                                                    id: idControler.text);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width*0.6,
                                            child: ADGradientButton(
                                                locale.send.toString()),
                                          ),
                                        ),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
