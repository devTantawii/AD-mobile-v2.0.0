import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/data/models/step_one_order_model.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Services extends StatefulWidget {
  // final List<FeatureNotCompletedModel?>? featuresNotCompleted;
  final List<Feature?>? features;
  final DataCars? datum;
  final bool isAutomated;

  const Services(
      {Key? key, /* this.featuresNotCompleted,*/ this.datum, this.isAutomated = false,this.features})
      : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  List checked = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: widget.features!.length,
          itemBuilder: (BuildContext context, int index) {
            final List<String?>? title =
                widget.features?.map((e) => e?.title).cast<String?>().toList();
            final List<String?>? price = widget.features
                ?.map((e) =>
                    "${e?.price}")
                .toList();
            final List<String?>? daily = widget.features
                ?.map((e) =>
            "${e?.daily == false ? "${locale.sar.toString()}" : "${locale.sar.toString()}/${locale.day.toString()}"}")
                .toList();
            return Column(
              children: [
                SizedBox(
                  height: size.height*0.01,
                ),
                Container(
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: size.width*0.02),
                      activeColor: Theme.of(context).colorScheme.secondaryContainer,
                      checkColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      onChanged: (value) {
                        setState(() {
                          checked[index] = value;
                          checked[index]
                              ? BlocProvider.of<AdditionsCubit>(context)
                                  .addAddition(context, widget.features![index])
                              : BlocProvider.of<AdditionsCubit>(context)
                                  .removeAddition(context, widget.features![index]);
                        });
                      },

                      value: checked[index],
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(daily![index] ?? "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  )),
                              Text(price![index] ?? "",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                  )),
                            ],
                          ),

                          Text(
                            title![index] ?? "",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight:FontWeight.w400,

                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        if (widget.features!.isEmpty)
          Container(
            color: Theme.of(context).colorScheme.onSecondary,
            // width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "No Items",
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 34.sp,
                  fontFamily: "Cairo",
                  letterSpacing: 1.5),
            ),
          ),

        // Align(
        //   alignment: locale.isDirectionRTL(context)
        //       ? Alignment.bottomLeft
        //       : Alignment.bottomRight,
        //   child: GestureDetector(
        //     onTap: () async {
        //       if (widget.isAutomated) {
        //         BlocProvider.of<BookingCubit>(context).selectedPaymentMethods = locale.visa.toString();
        //         pushNewScreen(context,
        //             screen: InvoiceUI(
        //               isAutomated: true,
        //             ));
        //       } else {
        //         context.read<BookingCubit>().additions = context.read<AdditionsCubit>().additions;
        //         final isClear = await Navigator.pushReplacement(
        //             context,
        //             ///Pay Method to select Pay
        //             MaterialPageRoute(
        //                 builder: (context) => PaymentMethodsScreen(
        //                       true,
        //                       carModel: widget.datum,
        //                       stepOneOrderModel:
        //                           BlocProvider.of<AdditionsCubit>(context)
        //                               .stepOneOrderModel,
        //                     )),
        //             // MaterialPageRoute(
        //             //     builder: (context) =>
        //             //         InvoiceUI(carModel: widget.datum))
        //         );
        //         if (isClear) {
        //           context
        //               .read<AdditionsCubit>()
        //               .getCarFeatures(context, widget.datum!.id.toString());
        //         }
        //       }
        //     },
        //     child: Container(
        //       margin: EdgeInsets.only(
        //           bottom: MediaQuery.of(context).size.height * 0.13,
        //           left: 20,
        //           right: 20),
        //       height: MediaQuery.of(context).size.height * 0.05,
        //       width: MediaQuery.of(context).size.width * 0.2,
        //       decoration: BoxDecoration(
        //         border:
        //             Border.all(color: Colors.white, style: BorderStyle.solid),
        //         borderRadius: BorderRadius.circular(25),
        //         gradient: gradient,
        //       ),
        //       child: Center(
        //         child: Text(
        //           locale.next.toString(),
        //           style: Theme.of(context)
        //               .textTheme
        //               .titleLarge!
        //               .copyWith(color: Colors.white),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
