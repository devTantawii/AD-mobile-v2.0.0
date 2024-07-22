import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                  child: ListView(
                    children: [
                      Center(
                        child: Text(
                          widget.isReceive?locale!.reciveDate.toString():locale!.deliveryDate.toString(),
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
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
                                        fontSize: 56.sp,
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
                                        fontSize: 56.sp,
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

          ],
        );
      },
    );
  }
}
