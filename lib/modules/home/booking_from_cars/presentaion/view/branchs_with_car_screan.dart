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
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../service_locator.dart';
import '../../../../../shared/commponents.dart';
import '../../../../auth/signin/presentation/pages/signin_screen.dart';

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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: AutoSizeText(
                                      locale.deliverAnotherBranch.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: FittedBox(
                                      child: CupertinoSwitch(
                                        activeColor: Colors.blue,
                                        value: _switchValue,
                                        onChanged: (value) {
                                          setState(() {
                                            _switchValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.04),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.05,
                                    child: Stack(
                                      children: [
                                        SelectTime(isReceive: true),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: -size.height * 0.03,
                                    left: 20,
                                    right: size.width*0.07,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      child: AutoSizeText(
                                        locale.fromTime.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.sp),
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.04,
                                    child: Stack(
                                      children: [
                                        SelectTime(isReceive: false),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: -size.height * 0.035,
                                    left: 20,
                                    right: size.width*0.07,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5,),
                                      constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height * 0.03,
                                      ),
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: AutoSizeText(
                                        locale.toTime.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
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
                                    if( state.error.contains("Error Please LOGIN To Continue")){
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
                                                HelperFunctions.showFlashBar(
                                                    context: context,
                                                    title: locale.error.toString(),
                                                    message: locale.isDirectionRTL(context)?"يجب عيك اختيار الفرع":"You Must Select The Branch",
                                                    icon: Icons.warning_amber,
                                                    color: Color(0xffF6A9A9),
                                                    titlcolor: Colors.red,
                                                    iconColor: Colors.red);
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
