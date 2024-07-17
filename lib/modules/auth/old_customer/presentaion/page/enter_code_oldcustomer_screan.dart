import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_state.dart';
import 'package:abudiyab/modules/home/payment/widget/screen_background.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'creat_email_oldcustomer_screan.dart';

class EnterCodeOldCustomerScrean extends StatelessWidget {
  EnterCodeOldCustomerScrean({Key? key}) : super(key: key);
  final codeControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<OldCustomerCubit, OldCustomerState>(
          listener: (context, state) {
            if (state is CodeError) {
              HelperFunctions.showFlashBar(
                context: context,
                title: locale!.error.toString(),
                message: state.error,
                icon: Icons.info,
              );
            }
            if (state is CodeLoaded) {
              pushNewScreen(context,
                  screen: CreatEmailAndPassOldCustomerScrean());
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
               // BackgroundScreen(),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50, width: 50, child: ADBackButton()),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              locale!.oldCustomer.toString(),
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              locale.enterCodeSent.toString(),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 120),
                      Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: ContainerTileWidget(
                              widgets: [
                                ADPrimTextForm(
                                    controller: codeControler,
                                    type: TextInputType.number,
                                    label: locale.enterCode.toString(),
                                    pIcon: Icons.password_outlined),
                                SizedBox(
                                  height: 20.0,
                                ),
                                state is CodeLoading
                                    ? Center(
                                        child: CircularProgressIndicator
                                            .adaptive(),
                                      )
                                    : InkWell(
                                        onTap: () {
                                          BlocProvider.of<OldCustomerCubit>(
                                                  context)
                                              .enterodeOldCustomer(
                                            code: codeControler.text,
                                          );
                                        },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.6,
                                    child: ADGradientButton(
                                        locale.send.toString()),
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
