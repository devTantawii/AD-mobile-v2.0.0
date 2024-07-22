import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/core/helpers/validation/form_validator.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_cubit.dart';
import 'package:abudiyab/modules/auth/old_customer/presentaion/bloc/old_customer_state.dart';
import 'package:abudiyab/modules/compose_ui.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatEmailAndPassOldCustomerScrean extends StatelessWidget {
  CreatEmailAndPassOldCustomerScrean({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: BlocConsumer<OldCustomerCubit, OldCustomerState>(
          listener: (context, state) {
            if (state is ResetError) {
              HelperFunctions.showFlashBar(
                context: context,
                title: locale.error.toString(),
                message: state.error,
                icon: Icons.info,
              );
            }
            if (state is ResetLoaded) {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ComposeUi(),
                ),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                //BackgroundScreen(),
                SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
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
                                locale.oldCustomer.toString(),
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                locale.createEmailAndPassword.toString(),
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
                              child: Form(
                                key: _formKey,
                                child: ContainerTileWidget(
                                  widgets: [
                                    ADPrimTextForm(
                                      controller: emailController,
                                      type: TextInputType.emailAddress,
                                      label: locale.emailAddress.toString(),
                                      pIcon: Icons.email,
                                      validat: (value) =>
                                          FormValidator.emailValidate(
                                              context, value),
                                    ),
                                    SizedBox(height: 5),
                                    ADPrimTextForm(
                                      controller: passwordController,
                                      type: TextInputType.visiblePassword,
                                      label: locale.password.toString(),
                                      pIcon: Icons.lock,
                                      validat: (value) =>
                                          FormValidator.passwordValidate(
                                              context, value),
                                    ),
                                    SizedBox(height: 5),
                                    ADPrimTextForm(
                                      controller: confirmPasswordController,
                                      type: TextInputType.visiblePassword,
                                      label: locale.confirmPassword.toString(),
                                      pIcon: Icons.lock,
                                      validat: (value) =>
                                          FormValidator.passwordConfirmValidate(
                                              context,
                                              passwordController.text,
                                              value),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    state is ResetLoading
                                        ? Center(
                                            child: CircularProgressIndicator
                                                .adaptive(),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                BlocProvider.of<OldCustomerCubit>(
                                                        context)
                                                    .resetOldCustomer(
                                                        email: emailController
                                                            .text
                                                            .toString(),
                                                        password:
                                                            passwordController
                                                                .text
                                                                .toString(),
                                                        confPass:
                                                            confirmPasswordController
                                                                .text
                                                                .toString());
                                              }
                                            },
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*0.6,
                                        child: ADGradientButton(
                                            locale.signIn.toString()),
                                      ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
