import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../all_bookings/data/model/check_order_step_model.dart';

class ServicesNotCompeted extends StatefulWidget {
  final CheckOrderStepModel? checkOrderStepModel;
  final List<Features?>? featuresNotCompleted;

  const ServicesNotCompeted(
      {Key? key, this.checkOrderStepModel, this.featuresNotCompleted})
      : super(key: key);

  @override
  State<ServicesNotCompeted> createState() => _ServicesNotCompetedState();
}

class _ServicesNotCompetedState extends State<ServicesNotCompeted> {
  @override
  void initState() {
    BlocProvider.of<AdditionsCubit>(context).initialCheckedList();
    BlocProvider.of<AdditionsCubit>(context).checkAdditionSelected();
    // print(BlocProvider.of<AdditionsCubit>(context).checked.toString()+"FFFF");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final size = MediaQuery
        .of(context)
        .size;
    final additionCubit = BlocProvider.of<AdditionsCubit>(context);

    return BlocConsumer<AdditionsCubit, AdditionsState>(
      listener: (context, state) {},
      builder: (context, state) {

        return Stack(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.checkOrderStepModel!.order!.features!.length,
              itemBuilder: (BuildContext context, int index) {
                // List checked = widget.checkOrderStepModel!.order!.features!.toList();
                //  additionCubit.initialCheckedList();
                 // additionCubit.checkId(1);
                 // additionCubit.checkId(2);
                ///---------------------
                final List<String?>? title =
                widget.checkOrderStepModel!.order!.features?.map((e) => e.title).cast<
                    String?>().toList();
                final List<String?>? price = widget.checkOrderStepModel!.order!
                    .features!
                    .map((e) =>
                "${e.price}")
                    .toList();
                final List<String?>? daily = widget.checkOrderStepModel!.order!
                    .features!.map((e) =>
                "${e.daily == false ? "${locale.sar.toString()}" : "${locale.sar
                    .toString()}/${locale.day.toString()}"}")
                    .toList();
                return Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Container(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: CheckboxListTile(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: size.width * 0.02),
                          activeColor: Theme
                              .of(context)
                              .colorScheme
                              .secondaryContainer,
                          checkColor: Theme
                              .of(context)
                              .colorScheme
                              .primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          value: additionCubit.checked[index],
                          onChanged: (value) {
                            // if(value != null) {
                              // additionCubit.checkAddition(index,value);
                              additionCubit.checked[index] = value;
                              if (additionCubit.checked[index]) {
                                BlocProvider.of<AdditionsCubit>(context).addAdditionNotCompleted(context, widget.checkOrderStepModel!.order!.features![index]);
                                // checked[index]= false;
                              } else {
                                BlocProvider.of<AdditionsCubit>(context).removeAdditionNotCompleted(
                                    context, widget.checkOrderStepModel!.order!.features![index]);
                                additionCubit.checked[index]=false;

                              // }
                            }
                          },
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
                                  fontWeight: FontWeight.w400,

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

            if (widget.checkOrderStepModel!.order!.features!.length == 0)
              Container(
                color: Theme
                    .of(context)
                    .colorScheme
                    .onSecondary,
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
          ],
        );
      },
    );
  }
}