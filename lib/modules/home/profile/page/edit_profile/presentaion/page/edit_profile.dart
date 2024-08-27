import 'dart:developer';
import 'dart:io';

import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/core/helpers/validation/validation.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/blocs/profile_cubit/profile_cubit.dart';
import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:abudiyab/modules/home/profile/page/edit_profile/presentaion/bloc/edit_profile_cubit.dart';
import 'package:abudiyab/modules/home/profile/page/edit_profile/presentaion/bloc/edit_profile_state.dart';
import 'package:abudiyab/modules/home/profile/page/edit_profile/presentaion/page/view_licence.dart';
import 'package:abudiyab/modules/home/profile/page/reset_password/presentaion/page/reset_password.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:abudiyab/modules/widgets/components/ad_prim_text_form/ad_prim_text_form.dart';
import 'package:abudiyab/shared/commponents.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:bounce/bounce.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../../service_locator.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key, required this.profileModel}) : super(key: key);
  final ProfileModel profileModel;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final nameControler = TextEditingController();

  final emailControler = TextEditingController();

  final phoneControler = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailControler.text = widget.profileModel.email!;
    nameControler.text = widget.profileModel.name!;
    phoneControler.text = widget.profileModel.phone!;
    BlocProvider.of<ProfileCubit>(context).getProfile();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    // print(BlocProvider.of<ProfileCubit>(context).licenceImage.toString()+'5555555555555555555555');
    // dynamic  customClass = BlocProvider.of<ProfileCubit>(context).licenceImage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            locale.editProfile!.toString(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 16.sp,
              color: Theme.of(context).colorScheme.primary
                ),
          ),
          leading: ADBackButton(),
        ),
        body: BlocProvider(
          create: (context) => sl<EditProfileCubit>(),
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileError) {
                HelperFunctions.showFlashBar(
                  context: context,
                  title: locale.error.toString(),
                  message: locale.errorData.toString(),
                    icon: Icons.warning_amber,
                    color: Color(0xffF6A9A9),
                    titlcolor: Colors.red,
                    iconColor: Colors.red
                );
              }
              if (state is EditProfileLoaded) {
                HelperFunctions.showFlashBar(
                  context: context,
                  title: locale.done.toString(),
                  message: locale.doneEditProfile,
                  icon: Icons.check,
                  color: Color(0xffDCEFE3),
                  titlcolor: Colors.green,
                 iconColor: Colors.green
                );

                BlocProvider.of<ProfileCubit>(context)
                    .getProfile()
                    .then((value) => Navigator.pop(context));
              }
            },
            builder: (context, state) {
              var cubit = EditProfileCubit.get(context);
              Size size =  MediaQuery.of(context).size;
              return
                  SingleChildScrollView(
                    child: Column(
                      children: [
                       SizedBox(height:  size.height * 0.03,),
                        Stack(
                          children: [
                            DottedBorder(
                              borderType: BorderType.Circle,
                                color: Theme.of(context).colorScheme.primary,
                                child: CircleAvatar(
                                  backgroundImage: cubit.imagePathFace == ""
                                      ? NetworkImage(widget.profileModel.avatar!)
                                      : null,
                                  radius: 60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(cubit.imagePathFace)),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ),

                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(

                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.transparent,
                                        width: 0.0)),
                                child: Bounce(
                                  onTap: () {
                                    cubit.getImage();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    radius: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:size.height*0.01),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: ContainerTileWidget(widgets: [
                              ADPrimTextForm(
                                controller: nameControler,
                                type: TextInputType.name,
                                label: locale.enterName.toString(),
                                pIcon: Icons.person,
                                validat: (value) =>
                                    Validate.validateName(context, value),
                              ),
                              SizedBox(height: 20.0),
                              ADPrimTextForm(
                                controller: emailControler,
                                type: TextInputType.emailAddress,
                                label: locale.emailAddress.toString(),
                                pIcon: Icons.email,
                                validat: (value) =>
                                    Validate.validateEmail(context, value),
                              ),
                              SizedBox(height: 20.0),
                              ADPrimTextForm(
                                controller: phoneControler,
                                type: TextInputType.phone,
                                label: locale.phoneNumber.toString(),
                                pIcon: Icons.phone_iphone_outlined,
                                validat: (value) =>
                                    Validate.validatePhoneNumber(
                                        context, value),
                              ),
                              SizedBox(height: 20.0),

                              ///EDIT AND UPLOAD LICENCE
                              if (widget.profileModel.user_license != null)
                                Bounce(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        WebViewLicence(
                                          licenceImage: widget
                                              .profileModel.user_license
                                              .toString(),
                                        ));
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: size.height * 0.1,
                                        width: size.width,
                                        child: Image.network(
                                          widget.profileModel.user_license.toString(),
                                        fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        height: size.height * 0.1,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                              color: Theme.of(context).colorScheme.primary.withOpacity(1),
                                              width: 1
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 6),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.remove_red_eye_sharp,
                                                      size: 14,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary
                                                          .withOpacity(1),
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                        locale.viewLicense.toString(),
                                                        style: TextStyle(
                                                            color: Theme.of(context)
                                                                .colorScheme
                                                                .primary
                                                                .withOpacity(1),
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              if (widget.profileModel.user_license == null)
                                Bounce(
                                  onTap: () {
                                    cubit.getImageLicence();
                                  },
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.06,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary
                                              .withOpacity(1),
                                          width: 1),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              size: 14,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                                  .withOpacity(1),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                                locale.editLicense.toString(),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary
                                                        .withOpacity(1),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ///END EDIT AND UPLOAD LICENCE
                              SizedBox(height: 10.0.sp),
                              State is EditProfileLoading
                                  ? const Center(
                                      child: CircularProgressIndicator
                                          .adaptive(),
                                    )
                                  : Bounce(
                                        onTap: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            log(cubit.imagePathFace);
                                            log(cubit.imagePathFaceLicence);
                                            log(nameControler.text);
                                            log(emailControler.text);
                                            log(phoneControler.text);
                                            cubit.editProfile(
                                              image: cubit.imagePathFace,
                                              name: nameControler.text,
                                              email: emailControler.text,
                                              phone: phoneControler.text,
                                              profileModel: widget.profileModel,
                                              licenceFace:
                                                  cubit.imagePathFaceLicence,
                                            );
                                          }
                                        },
                                        child: ADGradientButton(locale.save)),

                              SizedBox(height: 16.sp),
                              Bounce(
                                    onTap: () {
                                      PersistentNavBarNavigator.pushNewScreen(context,
                                          screen: ResetPasswordScrean());
                                    },
                                    child: Container(
                                      height: MediaQuery.of(context).size.height * 0.053,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.secondaryContainer,
                                        borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Center(
                                        child: Text(locale.resetPassword!,
                                            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.primary,)),
                                      ),
                                    )),

                              SizedBox(height: 10.0),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
