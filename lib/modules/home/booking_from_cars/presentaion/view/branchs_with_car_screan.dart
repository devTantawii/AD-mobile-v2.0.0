import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:abudiyab/modules/home/additions/presentaion/pages/additions_screen.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_cubit.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_state.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/widget/branchs.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/widget/info_car.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/widget/selscet_time.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../service_locator.dart';
import '../../../../../shared/commponents.dart';
import '../../../../auth/signin/presentation/pages/signin_screen.dart';
import '../../../../widgets/show_error_dailog.dart';
import '../../../search_screen/presentaion/widget/select_day_and_time.dart';

class BranchWithCarScreen extends StatefulWidget {
  final DataCars carModel;

  const BranchWithCarScreen({Key? key, required this.carModel})
      : super(key: key);

  @override
  State<BranchWithCarScreen> createState() => _BranchWithCarScreenState();
}

class _BranchWithCarScreenState extends State<BranchWithCarScreen> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          locale!.choseBranch.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        leading: ADBackButton(),
      ),
      body: BlocProvider(
        create: (context) => sl<BookingFromCarsCubit>()
          ..getBranchesWithCar(carId: int.parse(widget.carModel.id.toString())),
        child: BlocConsumer<BookingFromCarsCubit, BookingFromCarsState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is BookingFromCarsLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is BookingFromCarsLoaded) {
              return SingleChildScrollView(
                child: Container(
                  height: size.height,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: size.height * 0.2,
                        child: InfoCar(carModel: widget.carModel),
                      ),
                      SizedBox(
                        height: size.height * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              BranchTile(
                                  regions: state.branchModel.data,
                                  isRecieve: true),
                              SizedBox(
                                height: 10,
                              ),
                              _switchValue
                                  ? BranchTile(
                                      regions: state.branchModel.data,
                                      isRecieve: false)
                                  : SizedBox(),
                              _switchValue
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : SizedBox(),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      8.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: BlocProvider.of<SearchCubit>(context)
                                          .branchesData
                                          .isNotEmpty
                                          ? AutoSizeText(
                                        locale.deliverAnotherBranch.toString(),
                                        style: Theme.of(context).textTheme.labelLarge,
                                      )
                                          : Container(),
                                    ),
                                    BlocProvider.of<SearchCubit>(context)
                                        .branchesData
                                        .isNotEmpty
                                        ? SizedBox(
                                      child: FittedBox(
                                        child: Switch.adaptive(
                                          activeColor: Colors.black54,
                                          inactiveTrackColor: Colors.grey,
                                          value: _switchValue,
                                          onChanged: (value) => setState(() {
                                            _switchValue = value;
                                          }),
                                        ),
                                      ),
                                    )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              SizedBox(height: size.height * 0.04),
                              Row(
                                children: [
                                  Container(
                                    height: Device.get().isTablet ? 220.h : 170.h,
                                    width: 147.w,
                                    child: SelectDayAndTimeWidget(isReceive: true),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: Device.get().isTablet ? 220.h : 170.h,
                                    width: 147.w,
                                    child: SelectDayAndTimeWidget(isReceive: false),
                                  ),
                                ],
                              ),
                            // BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.carModel.id.toString());
                              SizedBox(height: 20.sp),
                              BlocConsumer<AdditionsCubit,AdditionsState>(
                                listener: (context, state) {
                                  if(state is AdditionsFailed){

                                    HelperFunctions.showFlashBar(
                                      context: context,
                                      title: locale.error.toString(),
                                      message:state.error.contains("Error Please LOGIN To Continue")?locale.loginToContinue.toString():state.error.toString().replaceAll("message: Error During Communication. -> Details: Exception:", ''),
                                      icon: Icons.info,  color: Color(0xffF6A9A9),
                                      titlcolor: Colors.red,
                                      iconColor: Colors.red,
                                    );

                                    if( state.error.contains("Error Please LOGIN To Continue") ) {
                                      navigateAndFinish(context, SignInScreen());
                                    }
                                  }
                                },
                                builder: (context, state) {
                                  return BlocConsumer<AdditionsCubit,AdditionsState>(
                                    listener: (context, state) {},
                                    builder: (context, state) {
                                      return Bounce(
                                            onTap: (){
                                              if(BlocProvider.of<SearchCubit>(context).selectedReceiveBranch!=null){
                                                onTapFirst(context);
                                                BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.carModel.id.toString());
                                                  onTap(context);
                                              }else{
                                                showErrorAlertDialog(context, locale.isDirectionRTL(context)
                                                    ? "يجب عليك اختيار الفرع اولا"
                                                    : "You Must Select The Branch",);
                                              }
                                            },
                                            child: ADGradientButton(locale.bookNow),
                                      );
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
onTapFirst(BuildContext context)async{
  final triggeredBranchModel = context
      .read<BookingFromCarsCubit>()
      .branchesModel
      .data
      .where((element) =>
  element.text ==
      BlocProvider.of<SearchCubit>(context).selectedReceiveBranch)
      .first;
  BlocProvider.of<SearchCubit>(context).selectedReceiveModel = BranchModel(
    id: triggeredBranchModel.id,
    name: triggeredBranchModel.text,
  );
  // drive
  if (BlocProvider.of<SearchCubit>(context).selectedDriveBranch != null) {
    final triggeredDriveBranchModel = context
        .read<BookingFromCarsCubit>()
        .branchesModel
        .data
        .where((element) =>
    element.text ==
        BlocProvider.of<SearchCubit>(context).selectedDriveBranch)
        .first;
    BlocProvider.of<SearchCubit>(context).selectedDriveModel =
        BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
        BranchModel(
          id: triggeredDriveBranchModel.id,
          name: triggeredDriveBranchModel.text,
        );
  } else {
    BlocProvider.of<SearchCubit>(context).selectedDriveModel =
        BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
        BranchModel(
          id: triggeredBranchModel.id,
          name: triggeredBranchModel.text,
        );
  }
}
  onTap(BuildContext context) async {
    final triggeredBranchModel = context
        .read<BookingFromCarsCubit>()
        .branchesModel
        .data
        .where((element) =>
            element.text ==
            BlocProvider.of<SearchCubit>(context).selectedReceiveBranch)
        .first;
    BlocProvider.of<SearchCubit>(context).selectedReceiveModel = BranchModel(
      id: triggeredBranchModel.id,
      name: triggeredBranchModel.text,
    );
    // drive
    if (BlocProvider.of<SearchCubit>(context).selectedDriveBranch != null) {
      final triggeredDriveBranchModel = context
          .read<BookingFromCarsCubit>()
          .branchesModel
          .data
          .where((element) =>
              element.text ==
              BlocProvider.of<SearchCubit>(context).selectedDriveBranch)
          .first;
      BlocProvider.of<SearchCubit>(context).selectedDriveModel =
          BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
              BranchModel(
        id: triggeredDriveBranchModel.id,
        name: triggeredDriveBranchModel.text,
      );
    } else {
      BlocProvider.of<SearchCubit>(context).selectedDriveModel =
          BlocProvider.of<SearchCubit>(context).selectedReceiveModel =
              BranchModel(
        id: triggeredBranchModel.id,
        name: triggeredBranchModel.text,
      );
    }

    ///-------------- Validation------------------
    await BlocProvider.of<SearchCubit>(context).validate();
    if (BlocProvider.of<SearchCubit>(context)
        .state
        .toString()
        .contains("SearchInvalid")) {

    } else if (BlocProvider.of<SearchCubit>(context).state.toString().contains("SearchValidate")) {
      BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.carModel.id.toString());
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => AdditionsScreen(datum: widget.carModel)));
    } else {
      HelperFunctions.showFlashBar(
          context: context,
          title: "...Oops",
          message: "some thing happened",
          icon: Icons.eighteen_mp);
    }

  }

}
