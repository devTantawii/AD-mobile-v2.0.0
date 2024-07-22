import 'package:abudiyab/core/helpers/helper_fun.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/presentaion/page/filter_cars.dart';
import 'package:abudiyab/modules/home/cars/presentaion/widget/filter_widget.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/filter_model.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:abudiyab/modules/widgets/components/error_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../profile/blocs/profile_cubit/profile_cubit.dart';
import '../../profile/data/models/profile_model.dart';
import 'bloc/all_cars_cubit/all_cars_cubit.dart';
import 'bloc/cubit/cars_cubit.dart';
import 'widget/car_tile.dart';

class AllCarsScreen extends StatefulWidget {
  final FilterModel? filterModel;
  final bool fromFilter;
  final ProfileModel? model;

  const AllCarsScreen(
      {Key? key, this.filterModel, this.fromFilter = false, this.model})
      : super(key: key);

  @override
  State<AllCarsScreen> createState() => _AllCarsScreenState();
}

class _AllCarsScreenState extends State<AllCarsScreen>
    with TickerProviderStateMixin {
  late int pageNumber;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  //animation
  late AnimationController filterPanelAnimationController;
  late Animation<double> filterPanelExpansionAnimation;
  late Animation<double> filterPanelInternalAnimation;

  @override
  void initState() {
    ///Check Cast Class
    //  BlocProvider.of<ProfileCubit>(context).getProfile();
    dynamic customClass = BlocProvider.of<ProfileCubit>(context).custClass;
    pageNumber=1;
    ///Start pagination
    widget.fromFilter?null:_scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        pageNumber += 1;
         getMoreCars(context, customClass,pageNumber);
      }
    });
    // animation initialize
    ///End pagination

    ///-----------Start animation---------------
    filterPanelAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    filterPanelExpansionAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: filterPanelAnimationController,
        curve: Interval(0, 0.5, curve: Curves.easeIn),
      ),);
    filterPanelInternalAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: filterPanelAnimationController,
        curve: Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );
    ///-----------END animation---------------
    super.initState();
  }

  @override
  void dispose() {
    filterPanelAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (widget.fromFilter) {
      pageNumber = 1;
      BlocProvider.of<AllCarsCubit>(context).getCarsByFilter(
        pageNumber,
        customerClass: BlocProvider.of<ProfileCubit>(context).custClass.toString(),
      );
    } else {
      ///trace the code here *-----*
      BlocProvider.of<AllCarsCubit>(context).getAllCars(
        pageNumber,
        branchId: widget.filterModel?.selectedBranch?.id,
        castClass: BlocProvider.of<ProfileCubit>(context).custClass.toString(),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.filterModel?.selectedBranch?.name ?? locale.allCar.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontSize: 16.sp,),
        ),
        leading: widget.filterModel?.selectedBranch?.name != null ||
                widget.fromFilter
            ? ADBackButton()
            : SizedBox(),
        elevation: 0.0,
        actions: [
          widget.fromFilter
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    pushNewScreen(context, screen: FiltersCars());
                  },
                  icon: SvgPicture.asset(
                    'assets/images/bxs_filter-alt.svg',
                  ),
          ),
        ],
      ),
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () async {
          if (widget.fromFilter) {
            await BlocProvider.of<AllCarsCubit>(context).getCarsByFilter(1);
          } else {
            await BlocProvider.of<AllCarsCubit>(context).getAllCars(1);
          }
        },
        child: Stack(
          children: [
            SafeArea(
              child: BlocConsumer<AllCarsCubit, AllCarsState>(
                  listener: (context, state) {
                if (state is AllCarsLodError) {
                  HelperFunctions.showFlashBar(
                      context: context,
                      title: locale.error.toString(),
                      message: state.error,
                      icon: Icons.warning_amber,
                    color: Color(0xffF6A9A9),
                    titlcolor: Colors.red,
                    iconColor: Colors.red
                  );
                }
              }, builder: (context, state) {
                if (state is CarsInitial) {
                  getMoreCars(
                      context,
                      BlocProvider.of<ProfileCubit>(context)
                          .custClass
                          .toString(),pageNumber);
                  return Center(child: CircularProgressIndicator.adaptive(backgroundColor: Theme.of(context).colorScheme.onPrimary,));
                } else {
                  var cubit = AllCarsCubit.get(context).cars;
                  return AllCarsCubit.get(context).cars == null
                      ? state is CarsLodError
                          ? ErrorImage(
                              refresh: () {
                                BlocProvider.of<AllCarsCubit>(context)
                                    .getAllCars(
                                  pageNumber,
                                  branchId:
                                      widget.filterModel?.selectedBranch?.id,
                                  castClass:
                                      BlocProvider.of<ProfileCubit>(context)
                                          .custClass
                                          .toString(),
                                );
                              },
                            )
                          : Container()
                      : BlocProvider.of<AllCarsCubit>(context)
                              .cars!
                              .data!
                              .isEmpty
                          ? Center(
                              child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Lottie.asset("assets/images/empty.json")),
                            ) : Column(
                              children: [
                                Container(
                                  // color: Theme.of(context).colorScheme.primaryContainer,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            locale.chooseCar.toString(),
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16.sp,fontWeight: FontWeight.w600,
                                             color: Theme.of(context).brightness==Brightness.light?Colors.black:Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(

                                          children: [
                                            Text(
                                               locale.avilable.toString() ,
                                               style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                            Text(
                                               " ${cubit!.meta!.total.toString()} " ,
                                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            Text(
                                               locale.car.toString(),
                                              style: Theme.of(context).textTheme.labelSmall,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child:
                                    ListView.builder(
                                        controller: _scrollController,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: cubit.data!.length,
                                        itemBuilder: (context, index) {
                                          if (index == cubit.data!.length - 1)
                                            return Center(child: CircularProgressIndicator.adaptive(
                                              backgroundColor: Theme.of(context).colorScheme.onPrimary,
                                            ));
                                          else
                                            return CarTile(
                                              cubit: cubit,
                                              index: index,
                                              filterModel: widget.filterModel,
                                              state: state,
                                            );
                                        }),
                                ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                              ],
                            );
                }
              }),
            ),
            if (!widget.fromFilter)
              AnimatedBuilder(
                animation: filterPanelExpansionAnimation,
                builder: (context, child) {
                  final value = filterPanelExpansionAnimation.value;
                  return Opacity(
                      opacity: value,
                      child: Visibility(
                        visible: value > 0,
                        child: child!,
                      ));
                },
                child: FilterWidget(),
              ),
          ],
        ),
      ),
    );
  }
  //
  // TickerFuture driveFilterPanelAnimation() =>
  //     filterPanelAnimationController.isCompleted
  //         ? filterPanelAnimationController.reverse()
  //         : filterPanelAnimationController.forward();

  getMoreCars(BuildContext context, cast_class,int page_num) {
    if (widget.fromFilter) {
      BlocProvider.of<AllCarsCubit>(context).getCarsByFilter(
        pageNumber,
        customerClass:
        BlocProvider.of<ProfileCubit>(context).custClass.toString(),
      );
    }
    BlocProvider.of<AllCarsCubit>(context).getAllCars(
      page_num,
      branchId: widget.filterModel?.selectedBranch?.id,
      castClass: cast_class.toString(),
    );
  }
}
