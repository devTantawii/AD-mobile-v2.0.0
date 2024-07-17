import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_state.dart';
import 'package:abudiyab/shared/style/colors.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class SelectDayAndTimeWidget extends StatefulWidget {
  final bool isAutomated;

  const SelectDayAndTimeWidget(
      {Key? key, required this.isReceive, this.isAutomated = false})
      : super(key: key);

  final bool isReceive;

  @override
  State<SelectDayAndTimeWidget> createState() => _SelectDayAndTimeWidgetState();
}

class _SelectDayAndTimeWidgetState extends State<SelectDayAndTimeWidget> {
  DateTime selectedDateTime = DateTime.now();

  @override
  void initState() {
    if (widget.isAutomated) {
      BlocProvider.of<SearchCubit>(context).driveDateValue = DateTime.now();
    } else {
      BlocProvider.of<SearchCubit>(context).driveDateValue =
          DateTime.now().add(Duration(days: 1));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: GestureDetector(
              onTap: () async {
                final DateTime? pickedDateTime = await showDatePicker(
                  context: context,
                  initialDate: selectedDateTime.add(Duration(days: 1)),
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2040),
                  builder: (context,child){
                    return  Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.blueAccent, // header background color
                          onPrimary: Colors.white, // header text color
                          onSurface: Colors.black, // body text color
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black, // button text color
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDateTime != null) {
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                    builder: (context,child){
                      return  Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.blueAccent, // header background color
                            onPrimary: Colors.white, // header text color
                            onSurface: Colors.black, // body text color
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.black, // button text color
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime != null) {
                    setState(() {
                      selectedDateTime = DateTime(
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );
                    });
                    widget.isReceive
                        ? BlocProvider.of<SearchCubit>(context)
                                .receiveDateValue =
                            DateTime.parse((selectedDateTime.toString()))
                        : BlocProvider.of<SearchCubit>(context).driveDateValue =
                            DateTime.parse(selectedDateTime.toString());
                    BlocProvider.of<SearchCubit>(context).changeState();
                    print(selectedDateTime.toString());
                    // Navigator.pop(context);
                  }
                };
              },
              child: Container(
                width: 170.w,
                height: 140.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 10.0.h),
                  child: Column(
                    children: [
                      Text(
                        widget.isReceive?locale!.reciveDate.toString():locale!.deliveryDate.toString(),
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          widget.isReceive
                              ? Center(
                                  child: AutoSizeText(
                                    DateFormat.d().format(DateTime.parse(
                                        BlocProvider.of<SearchCubit>(context)
                                            .receiveDateValue
                                            .toString())),
                                    style: TextStyle(
                                        fontSize: 64.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )
                              : Center(
                                  child: AutoSizeText(
                                    DateFormat.d().format(DateTime.parse(
                                        BlocProvider.of<SearchCubit>(context)
                                            .driveDateValue
                                            .toString())),
                                    style: TextStyle(
                                        fontSize: 64.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                               Column(
                            children: [
                              widget.isReceive
                                  ? Center(
                                      child: AutoSizeText(
                                        DateFormat.LLL().format(DateTime.parse(
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .receiveDateValue
                                                .toString())),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Center(
                                      child: AutoSizeText(
                                        DateFormat.LLL().format(DateTime.parse(
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .driveDateValue
                                                .toString())),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),

                              ///----------------------
                              widget.isReceive
                                  ? Center(
                                      child: AutoSizeText(
                                        DateFormat.E().format(DateTime.parse(
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .receiveDateValue
                                                .toString())),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  : Center(
                                      child: AutoSizeText(
                                        DateFormat.E().format(DateTime.parse(
                                            BlocProvider.of<SearchCubit>(
                                                    context)
                                                .driveDateValue
                                                .toString())),
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                            ],
                          )
                        ],
                      ),
                      widget.isReceive
                          ? Center(
                        child: AutoSizeText(
                          DateFormat.jm().format(DateTime.parse(
                              BlocProvider.of<SearchCubit>(
                                  context)
                                  .receiveDateValue
                                  .toString())),
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                          : Center(
                        child: AutoSizeText(
                          DateFormat.jm().format(DateTime.parse(
                              BlocProvider.of<SearchCubit>(
                                  context)
                                  .driveDateValue
                                  .toString())),
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ))
            /* Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                  shape: BoxShape.rectangle,
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  onPressed: () async {
                    final DateTime? pickedDateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDateTime.add(Duration(days: 1)),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(2040),
                    );
                    if (pickedDateTime != null) {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          selectedDateTime = DateTime(
                            pickedDateTime.year,
                            pickedDateTime.month,
                            pickedDateTime.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                        });
                          widget.isReceive
                              ? BlocProvider.of<SearchCubit>(context)
                              .receiveDateValue =
                              DateTime.parse((selectedDateTime.toString()))
                              : BlocProvider.of<SearchCubit>(context)
                              .driveDateValue =
                              DateTime.parse(selectedDateTime.toString());
                          BlocProvider.of<SearchCubit>(context).changeState();
                          print(selectedDateTime.toString());
                          Navigator.pop(context);

                      }
                    }
                   /* showDialog<Widget>(
                        context: context,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.09,
                                vertical: size.width * 0.3),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(16.sp)),
                              child: SfDateRangePicker(
                                cancelText: locale!.cancel.toString(),
                                confirmText: locale.ok.toString(),
                                selectionTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                                rangeTextStyle: Theme.of(context).textTheme.bodyLarge,
                                headerStyle: DateRangePickerHeaderStyle(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(color:Theme.of(context).colorScheme.onPrimary)),
                                monthCellStyle: DateRangePickerMonthCellStyle(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                  disabledDatesTextStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall!.copyWith(color: Colors.grey[400]),
                                ),
                                yearCellStyle: DateRangePickerYearCellStyle(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .labelSmall,
                                ),
                                showActionButtons: true,
                                initialDisplayDate: DateTime.now(),
                                selectionColor: kPickColor,
                                todayHighlightColor: kPickColor,
                                minDate: BlocProvider.of<SearchCubit>(context).selectedReceiveModel?.bookToday == 0 ? DateTime.now().add(const Duration(days: 1))
                                    : DateTime.now(),
                                selectionMode: DateRangePickerSelectionMode.single,
                                initialSelectedRange: PickerDateRange(
                                    DateTime.now().add(const Duration(days: 2)),
                                    DateTime.now().add(const Duration(days: 2))),
                                backgroundColor: Theme.of(context).colorScheme.background,
                                onSubmit: (dynamic value) {
                                  widget.isReceive
                                      ? BlocProvider.of<SearchCubit>(context)
                                              .receiveDateValue =
                                          DateTime.parse((value.toString()))
                                      : BlocProvider.of<SearchCubit>(context)
                                              .driveDateValue =
                                          DateTime.parse(value.toString());
                                  BlocProvider.of<SearchCubit>(context)
                                      .changeState();
                                  Navigator.pop(context);
                                },
                                onCancel: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        });*/
                  },
                  child: Padding(
                    padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/images/calender.svg",color: Theme.of(context).colorScheme.onPrimary,),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: size.width * 0.2,
                              minWidth: size.width * 0.2,
                              maxHeight: size.height * 0.05),
                          //width: size.width * 0.4,
                          child: widget.isReceive
                              ? Center(
                                  child: AutoSizeText(
                                    "${BlocProvider.of<SearchCubit>(context).receiveDateValue.toString().substring(0, 11)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!,
                                  ),
                                )
                              : Center(
                                  child: AutoSizeText(
                                    "${BlocProvider.of<SearchCubit>(context).driveDateValue.toString().substring(0, 11)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0.sp),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                    shape: BoxShape.rectangle,
                  ),
                  child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0.0)),
                      onPressed: () async {
                        if (widget.isReceive) {
                          BlocProvider.of<SearchCubit>(context).receiveTimeValue =
                              (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false,
                                        ),
                                        child: child!);
                                  }))!;
                        } else {
                          BlocProvider.of<SearchCubit>(context).driveTimeValue =
                              (await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder: (context, child) {
                                    return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: false,

                                        ),
                                        child: child!);
                                  }))!;
                        }

                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width*0.03),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/clock.svg',
                              color: Theme.of(context).colorScheme.onPrimary,),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: size.width * 0.23,
                                  minWidth: size.width * 0.2,
                                  maxHeight: size.height * 0.033
                              ),
                              child: widget.isReceive
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        AutoSizeText(
                                          "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.hour.toString()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        AutoSizeText(
                                          " : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge
                                        ),
                                        AutoSizeText(
                                          "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.minute.toString()} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        AutoSizeText(
                                          "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.period.name.toString().toUpperCase()} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      textDirection: TextDirection.ltr,
                                      children: [
                                        AutoSizeText(
                                            " ${BlocProvider.of<SearchCubit>(context).driveTimeValue.hour.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        AutoSizeText(" : ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        AutoSizeText(
                                            " ${BlocProvider.of<SearchCubit>(context).driveTimeValue.minute.toString()} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                        AutoSizeText(
                                            "${BlocProvider.of<SearchCubit>(context).driveTimeValue.period.name.toString().toUpperCase()} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ))),
            ),*/
          ],
        );
      },
    );
  }
}
