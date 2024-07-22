import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import 'package:abudiyab/modules/home/all_bookings/presentaion/bloc/edit_order_cubit/edit_order_cubit.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:abudiyab/modules/home/all_branching/page/text_tile_branch.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_cubit.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/bloc/booking_cars_state.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/widget/branchs.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/widget/selscet_time.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/helper/date_helper.dart';
import '../../../../../service_locator.dart';

class EditOrder extends StatefulWidget {
  final DataCars carModel;
  final Datum bookingModel;

  const EditOrder(
      {Key? key, required this.carModel, required this.bookingModel})
      : super(key: key);

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.editOrder.toString(),
          style: Theme.of(context).textTheme.bodyText1,
        ),
        leading: ADBackButton(),
      ),
      body: BlocProvider(
        create: (context) => sl<EditOrderCubit>(),
        child: BlocProvider(
          create: (context) => sl<BookingFromCarsCubit>()
            ..getBranchesWithCar(
                carId: int.parse(widget.carModel.id.toString())),
          child: BlocConsumer<EditOrderCubit, EditOrderState>(
            listener: (context, state) async {
              if (state is EditOrderFailed) {
                HelperFunctions.dialog(
                    context: context,
                    title: locale.error.toString(),
                    body: state.error.toString());
              } else if (state is EditOrderSuccess) {
                HelperFunctions.showFlashBar(
                  context: context,
                  title: locale.done.toString(),
                  message: "",
                  icon: Icons.info,
                );
                Navigator.of(context).pop(true);
              }
            },
            builder: (context, state) {
              return BlocBuilder<BookingFromCarsCubit, BookingFromCarsState>(
                builder: (context, state) {
                  if (state is BookingFromCarsLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (state is BookingFromCarsLoaded) {
                    return SingleChildScrollView(
                      child: Container(
                        height: size.height,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.26,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.bookingModel.id
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5),
                                                  Text(
                                                    '${widget.carModel.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text.rich(
                                                    TextSpan(
                                                      text:
                                                          "${widget.bookingModel.price} ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline6,
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              "  ${locale.sar}",
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText2!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  FittedBox(
                                                    child: TextTileBranch(
                                                      title: "${locale.fromTime}",
                                                      content:
                                                          "${widget.bookingModel.receivingDateWithTime!.substring(0, 10)}",
                                                      size: 10,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5),
                                                  FittedBox(
                                                    child: TextTileBranch(
                                                      title: "${locale.toTime}",
                                                      content:
                                                          "${widget.bookingModel.deliveryDateWithTime!.substring(0, 10)}",
                                                      size: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                widget.carModel.photo),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                                    SizedBox(height: 5),
                                    _switchValue
                                        ? BranchTile(
                                            regions: state.branchModel.data,
                                            isRecieve: false)
                                        : SizedBox(),
                                    _switchValue
                                        ? SizedBox(height: 10)
                                        : SizedBox(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: AutoSizeText(
                                            locale.deliverAnotherBranch
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
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
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          child: Stack(
                                            children: [
                                              SelectTime(isReceive: true),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -size.height * 0.016,
                                          left: 20,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.03),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: AutoSizeText(
                                              locale.fromTime.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 15),
                                    Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.04,
                                          child: Stack(
                                            children: [
                                              SelectTime(isReceive: false),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -size.height * 0.016,
                                          left: 20,
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.03),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            child: AutoSizeText(
                                              locale.toTime.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    InkWell(
                                        onTap: () => onTap(context),
                                        child:
                                            ADGradientButton(locale.editOrder))
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
              );
            },
          ),
        ),
      ),
    );
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

    // Validation
    String receiveHour = DateHandler.timeOfDayToHour(
        BlocProvider.of<SearchCubit>(context).receiveTimeValue);
    String deliveryHour = DateHandler.timeOfDayToHour(
        BlocProvider.of<SearchCubit>(context).driveTimeValue);
    await BlocProvider.of<EditOrderCubit>(context).editBooking(
        orderId: widget.bookingModel.id,
        receivingId: BlocProvider.of<SearchCubit>(context)
            .selectedReceiveModel
            !.id
            .toString(),
        deliveryId: BlocProvider.of<SearchCubit>(context)
                .selectedDriveModel
                ?.id
                .toString() ??
            BlocProvider.of<SearchCubit>(context)
                .selectedReceiveModel
                !.id
                .toString(),
        receivingDate: DateHandler.mixDateWithHours(
            BlocProvider.of<SearchCubit>(context).receiveDateValue,
            receiveHour),
        deliveryDate: DateHandler.mixDateWithHours(
            BlocProvider.of<SearchCubit>(context).driveDateValue,
            deliveryHour));

  }
}
