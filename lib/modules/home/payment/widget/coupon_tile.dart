import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/blocs/booking_cubit/booking_cubit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CouponTile extends StatefulWidget {
  const CouponTile({Key? key}) : super(key: key);

  @override
  _CouponTileState createState() => _CouponTileState();
}

class _CouponTileState extends State<CouponTile> {
  final TextEditingController controller = TextEditingController();
  bool status = true;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is CouponInvalid) {
          HelperFunctions.showFlashBar(
            context: context,
            title:locale!.error.toString(),
            message: locale.isDirectionRTL(context)
                ? "كوبون غير صالح"
                : "Invalid Coupon",
            icon: Icons.info,
            color: Color(0xffF6A9A9),
            titlcolor: Colors.red,
            iconColor: Colors.red,
          );
        } else if (state is CouponValid) {
          HelperFunctions.showFlashBar(
              color:Color(0xffDCEFE3) ,
              context: context,
              title: locale!.done.toString(),
              message: locale.isDirectionRTL(context)?'تم تطبيق الخصم':'Discount Applied',
              titlcolor: Color(0xff327B5B),
              icon: Icons.check,
              iconColor: Color(0xff327B5B)
          );
        }
      },
      builder: (context, state) {
        return TextButton.icon(
          onPressed: couponTrigger,
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(28.0),
            ),
            child: Icon(status ? Icons.add : Icons.done,
                size: 20.0, color: Theme.of(context).colorScheme.surface),
          ),
          label: Row(
            children: [
              if (status)
                AnimatedContainer(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                  height: 45,
                  width: 150,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "${locale!.addCoupon}...",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                )
              else
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                  alignment: Alignment.center,
                  height: 45,
                  width: 100,
                  child: AutoSizeText(
                    locale!.addVoucher.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 12.sp),
                  ),
                ),
              if (state is CouponValid)
                AutoSizeText(
                  " ${locale.totalAfterDiscount} ${state.couponModel.finalPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 12.sp),
                ),
            ],
          ),
        );
      },
    );
  }
void errorHandel(locale){
  HelperFunctions.showFlashBar(
    context: context,
    title:locale.error.toString(),
    message: locale.isDirectionRTL(context)
        ? "من فضلك -أضف كوبون الخصم"
        : "Add Coupon",
    icon: Icons.info,
    color: Color(0xffF6A9A9),
    titlcolor: Colors.red,
    iconColor: Colors.red,
  );
}
  Future<void> couponTrigger() async {
    if (controller.text.trim() != "") {
      // HelperFunctions.showFlashBar(
      //   context: context,
      //   title: "Checking...",
      //   message: "checking ${controller.text} Coupon",
      //   icon: Icons.info,
      // );
      BlocProvider.of<BookingCubit>(context).couponCode = controller.text;
      await BlocProvider.of<BookingCubit>(context).checkCouponCode().then((value) => print);
      status = !status;
      // context.read(ordersServicesProvider)
      //     .checkCouponCode(controller.text.toString())
      //     .then((value) {
      //   checkCouponValue(value);
      // });
    } else {
      setState(() {
        // status = !status;
        errorHandel(AppLocalizations.of(context));
      });
      BlocProvider.of<BookingCubit>(context).couponCode = "";
      // context.read(checkoutControllerProvider).changeCouponStatus();
      // CheckoutController().addCouponCode("");
      // CheckoutController().addCouponID("");
    }
  }
}
