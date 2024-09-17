import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key, required this.isReceive}) : super(key: key);

  final bool isReceive;

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 0)),
              onPressed: () async {
                showDialog<Widget>(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.09,
                            vertical: size.width * 0.3),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(12)),
                          child: SfDateRangePicker(
                            cancelText: locale!.cancel.toString(),
                            confirmText: locale.ok.toString(),
                            selectionTextStyle: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white),
                            rangeTextStyle:
                                Theme.of(context).textTheme.bodyLarge,
                            headerStyle: DateRangePickerHeaderStyle(
                                textStyle:
                                    Theme.of(context).textTheme.bodyLarge),
                            monthCellStyle: DateRangePickerMonthCellStyle(
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                              disabledDatesTextStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.grey),
                            ),
                            yearCellStyle: DateRangePickerYearCellStyle(
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                            showActionButtons: true,
                            initialDisplayDate: DateTime.now(),
                            minDate: DateTime.now(),
                            //  minDate: BlocProvider.of<SearchCubit>(context)
                            //     .selectedReceiveModel
                            //     ?.bookToday  == 0
                            //     ? DateTime.now().add(const Duration(days: 1))
                            //     : DateTime.now(),
                            selectionMode: DateRangePickerSelectionMode.single,
                            initialSelectedRange: PickerDateRange(
                              DateTime.now().add(const Duration(days: 1)),
                              DateTime.now().add(const Duration(days: 2)),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
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
                              setState(() {});
                            },
                            onCancel: () => Navigator.pop(context),
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 8.0),
                // height: 30,
                constraints: BoxConstraints(
                    maxWidth: size.width * 0.2,
                    minWidth: size.width * 0.2,
                    maxHeight: size.height * 0.05),
                //width: size.width * 0.4,
                child: widget.isReceive
                    ? Center(
                        child: Text(
                          "${BlocProvider.of<SearchCubit>(context).receiveDateValue.toString().substring(0, 11)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      )
                    : Center(
                        child: Text(
                          "${BlocProvider.of<SearchCubit>(context).driveDateValue.toString().substring(0, 11)}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
              child: TextButton(
                  style:
                      TextButton.styleFrom(padding: const EdgeInsets.all(0.0)),
                  onPressed: () async {
                    if (widget.isReceive) {
                      BlocProvider.of<SearchCubit>(context).receiveTimeValue =
                          (await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: false,
                                    ),
                                    child: childWidget!);
                              }))!;
                    } else {
                      BlocProvider.of<SearchCubit>(context).driveTimeValue =
                          (await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              builder: (context, childWidget) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      alwaysUse24HourFormat: false,
                                    ),
                                    child: childWidget!);
                              }))!;
                    }

                    setState(() {});
                  },
                  child: widget.isReceive
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.ltr,
                          children: [
                            AutoSizeText(
                              "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.hour.toString()}  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              " : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.minute.toString()} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              "${BlocProvider.of<SearchCubit>(context).receiveTimeValue.period.name.toString().toUpperCase()} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          textDirection: TextDirection.ltr,
                          children: [
                            AutoSizeText(
                              " ${BlocProvider.of<SearchCubit>(context).driveTimeValue.hour.toString()}  ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              " : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              " ${BlocProvider.of<SearchCubit>(context).driveTimeValue.minute.toString()} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            AutoSizeText(
                              "${BlocProvider.of<SearchCubit>(context).driveTimeValue.period.name.toString().toUpperCase()} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ))),
        ),
      ],
    );
  }
}
