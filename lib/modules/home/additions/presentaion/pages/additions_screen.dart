import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import 'package:abudiyab/modules/home/additions/presentaion/widgets/services.dart';
import 'package:abudiyab/modules/home/additions/presentaion/widgets/services_notCompleted.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/widgets/components/ADHomeButton.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/ad_gradient_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../../../core/helpers/helper_fun.dart';
import 'package:abudiyab/modules/home/all_bookings/data/model/booking_model.dart';
import '../../../../auth/signin/presentation/pages/signin_screen.dart';
import '../../../all_bookings/data/model/check_order_step_model.dart';
import '../../../payment/paymentMethods.dart';

// ignore: must_be_immutable
class AdditionsScreen extends StatefulWidget {
  final DataCars? datum;
  final CheckOrderStepModel? checkOrderStepModel;
  Datum?bookDetails;
   bool ?fromNotCompleted;
  bool ?fromAddAdditions;
  AdditionsScreen({
    this.datum,
    this.checkOrderStepModel,
     this.fromNotCompleted,
    this.fromAddAdditions,
    this.bookDetails
  });

  @override
  _AdditionsScreenState createState() => _AdditionsScreenState();
}

class _AdditionsScreenState extends State<AdditionsScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  //var _scrollController, _tabController;
  @override
  void initState() {

    // _scrollController = ScrollController();
    // _tabController = TabController(length: 2, vsync: this);
    // BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.datum!.id.toString());
  if(widget.fromNotCompleted==true){
     widget.fromAddAdditions==true?checkOrderStep():false;
  }else{
    // BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.datum!.id.toString());
  }

    super.initState();
  }
  checkOrderStep()async{
    await BlocProvider.of<AdditionsCubit>(context).checkOrderStep(
        orderId: BlocProvider.of<AdditionsCubit>(context).stepModel!.order!.id.toString());
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AdditionsCubit, AdditionsState>(
      listener: (context, state) {
        if(state is CheckOrderStateLoading){
          CircularProgressIndicator.adaptive(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
          );
        }
        if(state is AdditionsFailed){
          HelperFunctions.showFlashBar(
            context: context,
            title: state.error.contains("not Authanticated")?locale!.loginToContinue.toString():state.error.toString().replaceAll("message: Error During Communication. -> Details: Exception:", ''),
            message:'',
            icon: Icons.info,  color: Color(0xffF6A9A9),
            titlcolor: Colors.red,
            iconColor: Colors.red,

          );
        }
        if(state is AdditionsFailed){
          HelperFunctions.showFlashBar(
            context: context,
            title: state.error.contains("Error Please LOGIN To Continue")?locale!.loginToContinue.toString():state.error.toString().replaceAll("message: Error During Communication. -> Details: Exception:", ''),
            message:'',
            icon: Icons.info,  color: Color(0xffF6A9A9),
            titlcolor: Colors.red,
            iconColor: Colors.red,

          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: widget.fromNotCompleted==true?ADHomeButton():ADBackButton(),
              // leading: ADBackButton(),
              title: Text(locale!.checkOut.toString(),style: TextStyle(
                fontFamily: 'Cairo',
              )),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                    height: 50.sp,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: size.width*0.05),
                          child: Text(locale.additions.toString(),style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface
                          ),),
                        ),
                      ],
                    ),
                  ),
                  state is AdditionsFailed ? Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height/7,),
                            Image.asset(
                              Assets.img_empty,
                              // width: size.width * 0.9,
                              // height: size.height * 0.5,
                            ),
                            Text(
                              // state.error.replaceAll("message: Error During Communication. -> Details: Exception:", ""),
                              state.error.contains("not Authanticated")?locale.loginToContinue.toString()
                                  :extractDetails(state.error.toString()),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(height: 10.sp),
                            if (state.error.contains("not Authanticated"))
                              InkWell(
                                  onTap: () async {
                                    var data = await pushNewScreen(
                                      context,
                                      screen:
                                      SignInScreen(pushAddition: true),
                                      withNavBar: false,
                                    );
                                    if (data) {
                                      BlocProvider.of<AdditionsCubit>(context)
                                          .getCarFeatures(context, widget.datum!.id.toString(),);
                                    }
                                  },
                                  child: ADGradientButton(
                                    locale.signIn.toString(),
                                    width:
                                    MediaQuery.of(context).size.width * 0.5,
                                  )),
                          ],
                        ),
                      ))
                      : state is AdditionsLoading
                      ? Center(child: Column(
                    children: [
                      SizedBox(
                        height: size.height/2.7,
                      ),
                      CircularProgressIndicator.adaptive(
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ],
                  )):Column(
                    children: [
                     widget.fromNotCompleted==true?ServicesNotCompeted(
                       checkOrderStepModel:BlocProvider.of<AdditionsCubit>(context).stepModel,
                       featuresNotCompleted: BlocProvider.of<AdditionsCubit>(context).features2,
                        ):
                     Services(
                          datum: widget.datum,
                          features: state is AdditionsSuccess
                              ? state.features : []),
                      Container(
                        child:
                         widget.fromNotCompleted==true?
                        PaymentMethodsScreen(
                          true,
                           isNotCompleted: true,
                          carModel: widget.datum,
                          stepOneOrderModel: BlocProvider.of<AdditionsCubit>(context).stepOneOrderModel,
                          orderId:widget.checkOrderStepModel!.order!.id.toString(),
                        )
                            :PaymentMethodsScreen(
                          true,
                          isNotCompleted: false,
                          carModel: widget.datum,
                          stepOneOrderModel:
                          BlocProvider.of<AdditionsCubit>(context).stepOneOrderModel,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        );
      },
    );
  }
  String extractDetails(String inputString) {
    final detailsKeyword = "not Authanticated";
    final startIndex = inputString.indexOf(detailsKeyword);

    if (startIndex != -1) {
      final extractedString = inputString.substring(startIndex);
      return extractedString.trim();
    }

    return '';
  }
}

