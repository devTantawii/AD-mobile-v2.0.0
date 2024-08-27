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
import 'package:lottie/lottie.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../profile/blocs/profile_cubit/profile_cubit.dart';
import 'bloc/cubit/cars_cubit.dart';
import 'widget/car_tile.dart';

class CarsScreen extends StatefulWidget {
  final FilterModel? filterModel;
  final bool fromFilter;

  const CarsScreen({Key? key, this.filterModel, this.fromFilter = false})
      : super(key: key);

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> with TickerProviderStateMixin {
  late int pageNumber;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();

  //animation
  late AnimationController filterPanelAnimationController;
  late Animation<double> filterPanelExpansionAnimation;
  late Animation<double> filterPanelInternalAnimation;

  @override
  void initState() {
    pageNumber = 1;
    BlocProvider.of<ProfileCubit>(context).getProfile();
    dynamic customClass = BlocProvider.of<ProfileCubit>(context).custClass;

    //pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber += 1;
        getMoreCars(context, customClass);
      }
    });

    // animation initialize
    filterPanelAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    filterPanelExpansionAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: filterPanelAnimationController, curve: Interval(0, 0.5, curve: Curves.easeIn),),);
    filterPanelInternalAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: filterPanelAnimationController,
        curve: Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    filterPanelAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final locale = AppLocalizations.of(context)!;
    final carsCubit = BlocProvider.of<CarsCubit>(context);
    if (widget.fromFilter) {
      pageNumber = 1;
      carsCubit.getCarsByFilter(pageNumber,
        //available: carsCubit.filterCubit.available,
      );
    } else {
      BlocProvider.of<CarsCubit>(context).getAllCars(
        pageNumber,
        branchId: widget.filterModel?.selectedBranch?.id,
        languageCode: locale.locale.languageCode,
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
        title: Text(
          widget.filterModel?.selectedBranch?.name ?? locale.allCar.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 16),
        ),
        leading: widget.filterModel?.selectedBranch?.name != null ||
                widget.fromFilter
            ? ADBackButton()
            : SizedBox(),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //     onPressed: () => ZoomDrawer.of(context)!.toggle(),
        //     icon: Icon(Icons.menu, size: 25)),
        actions: [
          widget.filterModel?.selectedBranch?.name != null
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    PersistentNavBarNavigator.pushNewScreen(context, screen: FiltersCars());
                  },
                  icon: FittedBox(
                    child: SizedBox(
                        width: 30.0,
                        height: 25.0,
                        child: Image.asset(
                          'assets/filter.png',
                          color: Theme.of(context).colorScheme.primary,
                        )),
                  )),
        ],
      ),
      key: _scaffoldKey,
      body: RefreshIndicator(
        onRefresh: () async {
          if (widget.fromFilter) {
            BlocProvider.of<CarsCubit>(context).getAllCars(1);
          }
        },
        child: Stack(
          children: [
            SafeArea(
              child: BlocConsumer<CarsCubit, CarsState>(
                  listener: (context, state) {
                if (state is CarsLodError) {
                  HelperFunctions.showFlashBar(
                      context: context,
                      title: "",
                      message: state.error,
                      icon: Icons.warning_amber,
                      color: Color(0xffF6A9A9),
                    titlcolor: Colors.red,
                    iconColor: Colors.red,
                  );
                }
              }, builder: (context, state) {
                if (state is CarsInitial) {
                  getMoreCars(
                    context,
                    int.parse(BlocProvider.of<ProfileCubit>(context)
                            .custClass
                            .toString())
                        .toInt(),
                  );
                  return Center(child: CircularProgressIndicator.adaptive());
                } else {
                  var cubit = CarsCubit.get(context).cars;
                  return CarsCubit.get(context).cars == null
                      ? state is CarsLodError
                          ? ErrorImage(
                              refresh: () {
                                BlocProvider.of<CarsCubit>(context).getAllCars(
                                  pageNumber,
                                  branchId:
                                      widget.filterModel?.selectedBranch?.id,
                                  languageCode: locale.locale.languageCode,
                                  castClass:
                                      BlocProvider.of<ProfileCubit>(context)
                                          .custClass
                                          .toString(),
                                );
                              },
                            )
                          : Container()
                      : BlocProvider.of<CarsCubit>(context).cars!.data!.isEmpty
                          ? Center(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset("assets/anim/empty.json",),
                                      Text(
                                        locale.noCarsInBranch.toString(),
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          : Column(
                              children: [
                                // ListOfCategory(),
                                Expanded(
                                  child:
                                    ListView.builder(
                                        controller: _scrollController,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: cubit!.data!.length,
                                        itemBuilder: (context, index) {
                                          return CarTile(
                                            cubit: cubit,
                                            index: index,
                                            filterModel: widget.filterModel,
                                            state: state,
                                          );
                                        }),

                                ),
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

  TickerFuture driveFilterPanelAnimation() =>
      filterPanelAnimationController.isCompleted
          ? filterPanelAnimationController.reverse()
          : filterPanelAnimationController.forward();

  getMoreCars(BuildContext context,  castClass) {
    if (widget.fromFilter) {
      BlocProvider.of<CarsCubit>(context).getCarsByFilter(pageNumber);
    }
    BlocProvider.of<CarsCubit>(context).getAllCars(pageNumber,
        branchId: widget.filterModel?.selectedBranch?.id,
        castClass: castClass.toString());
  }
}
