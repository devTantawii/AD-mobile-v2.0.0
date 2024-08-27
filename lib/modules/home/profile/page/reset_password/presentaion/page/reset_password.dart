import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/core/helpers/validation/validation.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/page/reset_password/presentaion/bloc/rsete_password_cubit.dart';
import 'package:abudiyab/modules/home/profile/page/reset_password/presentaion/bloc/rsete_password_state.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../service_locator.dart';

class ResetPasswordScrean extends StatelessWidget {
  ResetPasswordScrean({Key? key}) : super(key: key);
  final oldPasswordControler = TextEditingController();
  final newPasswordControler = TextEditingController();
  final confirmPasswordControler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            locale.resetPassword!.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16,
                ),
          ),
          leading: ADBackButton(),
        ),
        body: BlocProvider(
          create: (context) => sl<RsetePasswordCubit>(),
          child: BlocConsumer<RsetePasswordCubit, RsetePasswordState>(
            listener: (context, state) {
              if (state is RsetePassWordError) {
                HelperFunctions.showFlashBar(
                    context: context,
                    title: locale.error.toString(),
                    message: "${state.error}",
                    icon: Icons.info);
              }
              if (state is RsetePasswordLoaded) {
                HelperFunctions.showFlashBar(
                    context: context,
                    title: locale.done.toString(),
                    message: locale.passwordChanged.toString(),
                    icon: Icons.check);
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: ContainerTileWidget(widgets: [
                        ADPrimTextForm(
                          controller: oldPasswordControler,
                          type: TextInputType.visiblePassword,
                          label: locale.oldPassword.toString(),
                          pIcon: Icons.lock,
                          validat: (value) =>
                              Validate.validatePassword(context, value),
                        ),
                        SizedBox(height: 20.0),
                        ADPrimTextForm(
                          controller: newPasswordControler,
                          type: TextInputType.visiblePassword,
                          label: locale.newPassword.toString(),
                          pIcon: Icons.lock,
                          validat: (value) =>
                              Validate.validatePassword(context, value),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ADPrimTextForm(
                          controller: confirmPasswordControler,
                          type: TextInputType.visiblePassword,
                          label: locale.confirmPassword.toString(),
                          pIcon: Icons.lock,
                          validat: (value) => Validate.validatePassword(
                              context, newPasswordControler.text,
                              confirmPassword: value),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        state is RsetePasswordLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Bounce(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    BlocProvider.of<RsetePasswordCubit>(context)
                                        .rsetePassword(
                                            oldPassWord:
                                                oldPasswordControler.text,
                                            newPassWord:
                                                newPasswordControler.text,
                                            confirmPassWord:
                                                confirmPasswordControler.text);
                                  }
                                },
                                child: ADGradientButton(
                                    locale.changePassword.toString()),
                              ),
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
