import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/additions/presentaion/pages/additions_screen.dart';
import 'package:abudiyab/modules/home/booking_from_cars/presentaion/view/branchs_with_car_screan.dart';
import 'package:abudiyab/modules/home/cars/presentaion/bloc/cubit/cars_cubit.dart';
import 'package:abudiyab/modules/home/cars/presentaion/page/cars_info.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/filter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../../../core/helpers/helper_fun.dart';
import '../../../../../shared/commponents.dart';
import '../../../../auth/signin/presentation/pages/signin_screen.dart';
import '../../../additions/presentaion/blocs/addition_cubit/additions_cubit.dart';
import '../../../blocs/favourite_cubit/favourite_cubit.dart';
import '../../data/models/cars_model.dart';
class CarTile extends StatefulWidget {
  final int index;
  final cubit;
  final FilterModel? filterModel;
  final state;
  final DataCars? datum;
  const CarTile({
    Key? key,
    required this.index,
    this.cubit,
    this.filterModel,
    this.state,
    this.datum,
  }): super(key: key);
  @override
  State<CarTile> createState() => _CarTileState();
}

class _CarTileState extends State<CarTile> {
  bool? lookLike = true;
  late bool isFavorite = false;

  @override
  void initState() {
    print('object');
    if(widget.filterModel == null && lookLike == true){
  }else{
      // BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.cubit.data[widget.index].id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AdditionsCubit,AdditionsState>(
      listener: (context, state) {
        if(state is AdditionsLoading){
      Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
            ),
          );
        }
      },
      builder: (context, state) {
        return  Stack(
          alignment: AlignmentDirectional.centerStart,
          children: [
            InkWell(
              onTap: () {
                pushNewScreen(context,
                    screen: CarsInformation(
                      datum: widget.cubit.data[widget.index],
                      filterModel: widget.filterModel,
                    ));
              },
              child: Container(
                margin: EdgeInsets.only(
                  bottom: size.height * 0.012,
                  right: size.width*0.03,
                  left: size.width*0.03,
                ),
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                height: MediaQuery.of(context).size.height * 0.26,
                decoration: BoxDecoration(
                  borderRadius:BorderRadius.circular(6),
                  color: Theme.of(context).brightness==Brightness.light?Color(0xffF4F4F6):Color(0xff222249),
                  border: Border.all(
                      color: Theme.of(context).brightness==Brightness.dark?Color(0xff505AC9):Colors.transparent
                  ),
                  boxShadow:[
                    Theme.of(context).brightness==Brightness.light?BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ):BoxShadow(),
                  ] ,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<FavouriteCubit>(context).addToFavourites(widget.cubit.data[widget.index].id.toString(),);
                        setState((){
                          isFavorite = !isFavorite;
                        });
                      },
                      icon: isFavorite
                          ? Icon(
                        Icons.favorite,
                        color: Theme.of(context).brightness==Brightness.light?Theme.of(context).colorScheme.secondary:Color(0xffF08A61),
                      )
                          : Icon(
                        Icons.favorite_border,
                        color: Theme.of(context).brightness==Brightness.light?Theme.of(context).colorScheme.secondary:Color(0xffF08A61),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: widget.state is CarsImageLoadError
                            ? Lottie.asset("assets/images/Loding_car.json")
                            :
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(widget
                                      .cubit.data[widget.index].photo,
                                  ),
                                  onError: (e, s) {
                                    BlocProvider.of<CarsCubit>(context)
                                        .emitPhotoError(e);
                                  })),
                        ),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: Container(
                        color: Theme.of(context).brightness==Brightness.light?Color(0xFFFEE4D5):null,
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: FittedBox(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ///---------command--------
                                      Padding(
                                        padding:  EdgeInsets.only(right: size.width*0.03,left: size.width*0.04,),
                                        child: Text.rich(
                                          TextSpan(
                                            text: "${widget.cubit.data[widget.index].priceAfter} ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                color: Theme.of(context).colorScheme.onPrimary),
                                            children: [
                                              TextSpan(
                                                text:
                                                "${widget.cubit.data[widget.index].priceBefore}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                  fontSize: 16.sp,
                                                  decoration: TextDecoration.lineThrough,
                                                  fontWeight: FontWeight.w100,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "  ${locale!.sar}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary),
                                              ),
                                              TextSpan(
                                                text: "/ ${locale.day}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                    color: Color(0XFFF08A61)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     SizedBox(
                                      //       width: 100.sp,
                                      //       child: Text(
                                      //         widget.filterModel?.selectedBranch
                                      //             ?.name ??
                                      //             "",
                                      //         overflow: TextOverflow.ellipsis,
                                      //         maxLines: 1,
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .bodyMedium,
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                                        child: Text(
                                            widget.cubit.data[widget.index].name.toString().toUpperCase(),
                                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            )),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      widget.cubit.data[widget.index].manufactory.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                                  // Text(
                                  //     widget.cubit.data[widget.index].name.toString().toUpperCase(),
                                  //     style: Theme.of(context).textTheme.bodyMedium),

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: locale.bookNow.toString() == "Book Now"
                  ? MediaQuery.of(context).size.height * 0.03
                  : null,
              left: locale.bookNow.toString() == "Book Now"
                  ? null
                  : MediaQuery.of(context).size.height * 0.03,
              child: InkWell(
                onTap: () async {
                  if (lookLike == true) {
                    // BlocProvider.of<AdditionsCubit>(context).getInit();
                    BlocProvider.of<AdditionsCubit>(context).getCarFeatures(context, widget.cubit.data[widget.index].id.toString());
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              widget.cubit.data[widget.index].name
                                  .toString()
                                  .toUpperCase() +
                                  ' ' +
                                  locale.lookLike1.toString(),
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onPrimary
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8.0))),
                            backgroundColor: Theme.of(context).brightness==Brightness.light?Colors.white:Theme.of(context).colorScheme.primary,
                            content: Text(
                              locale.lookLike.toString(),
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onPrimary
                              ),
                            ),
                            actions: [
                                   GestureDetector(
                                    onTap: () async {

                                      if (widget.filterModel == null && lookLike == true) {
                                        Navigator.pop(context);
                                          pushNewScreen(context,
                                              screen: BranchWithCarScreen(
                                                  carModel:
                                                  widget.cubit.data[widget.index]));
                                      } else {
                                        Navigator.pop(context);
                                     if(state is AdditionsSuccess || state is AdditionsInitial){
                                       pushNewScreen(context,
                                           screen: AdditionsScreen(datum:  widget.cubit.data[widget.index],));
                                     }else if(state is AdditionsFailed){
                                       HelperFunctions.showFlashBar(
                                         context: context,
                                         title:locale.error.toString(),
                                         message:state.error.contains("Error Please LOGIN To Continue")?locale.loginToContinue.toString():state.error.toString().replaceAll("message: Error During Communication. -> Details: Exception:", ''),
                                         icon: Icons.info,  color: Color(0xffF6A9A9),
                                         titlcolor: Colors.red,
                                         iconColor: Colors.red,

                                       );
                                       if( state.error.contains("Error Please LOGIN To Continue")){
                                         navigateAndFinish(context, SignInScreen());
                                       }
                                     }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          MediaQuery.of(context).size.width * 0.08,
                                          vertical:13.h),
                                      child: Center(
                                        child: Container(
                                          width: size.width*0.2,
                                          height: 30.h,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.primary,
                                              borderRadius: BorderRadius.circular(6)
                                          ),
                                          child: Center(
                                            child: Text(
                                              locale.ok.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                            ],
                          );
                        });
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.045,
                  width: MediaQuery.of(context).size.width * 0.11,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Theme.of(context).colorScheme.primary),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },

    );
  }
}
