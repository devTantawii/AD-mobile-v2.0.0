import 'dart:async';

import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_state.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/slider_model.dart';
import 'package:bounce/bounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion/motion.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CardTopHeadlines extends StatefulWidget {
  CardTopHeadlines({Key? key}) : super(key: key);

  @override
  State<CardTopHeadlines> createState() => _CardTopHeadlinesState();
}

class _CardTopHeadlinesState extends State<CardTopHeadlines> {
  late final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 1500), (Timer timer) {
      final SliderModel images =
          context.read<HeadlinesCubit>().state.props.first as SliderModel;
      if (currentPage < images.data.length) {
        pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
        currentPage++;
      } else {
        currentPage = 0;
        pageController.animateToPage(
          currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<HeadlinesCubit, HeadlinesState>(
      builder: (context, state) {
        if (state is HeadlinesLoading) {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state is HeadlinesLoaded) {
          return Motion(
            child: Bounce(
              onTap: () {
                timer!.cancel();
                if (currentPage < state.sliderModel.data.length) {
                  pageController.animateToPage(
                    currentPage,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                  currentPage++;
                } else {
                  currentPage = 0;
                  pageController.animateToPage(
                    currentPage,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                }
              },
              child: Stack(
                children: [
                  PageView.builder(
                    allowImplicitScrolling: true,
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: state.sliderModel.data.length,
                    itemBuilder: (context, pagePosition) {
                      return Container(
                        // margin: const EdgeInsets.all(8.0),
                        // height: height * 0.2,
                        width: width,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                state.sliderModel.data[pagePosition].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    width: width,
                    // height: height * 0.32,
                    decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(20),
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Theme.of(context).scaffoldBackgroundColor,
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //     Colors.transparent,
                        //     Theme.of(context)
                        //         .scaffoldBackgroundColor
                        //         .withOpacity(0.7),
                        //   ],
                        //   begin: Alignment.bottomCenter,
                        //   end: Alignment.topCenter,
                        // ),
                        ),
                  ),
                  Positioned(
                      top: height * 0.27,
                      child: Container(
                        width: width,
                        child: Center(
                          child: SmoothPageIndicator(
                            controller: pageController,
                            count: state.sliderModel.data.length,
                            axisDirection: Axis.horizontal,
                            effect: WormEffect(
                                // jumpScale: 2,
                                // offset: 25.0,
                                // verticalOffset: 18,
                                offset: 25,
                                type: WormType.thin,
                                spacing: 8.0,
                                radius: 8.0,
                                dotWidth: 20.0,
                                dotHeight: 8,
                                paintStyle: PaintingStyle.stroke,
                                strokeWidth: 0.5,
                                dotColor: Colors.grey,
                                activeDotColor:
                                    Theme.of(context).colorScheme.primary),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

// import 'dart:async';
//
// import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_cubit.dart';
// import 'package:abudiyab/modules/home/search_screen/blocs/headlines_bloc/headlines_state.dart';
// import 'package:abudiyab/modules/home/search_screen/data/models/slider_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class CardTopHeadlines extends StatefulWidget {
//   CardTopHeadlines({Key? key}) : super(key: key);
//
//   @override
//   State<CardTopHeadlines> createState() => _CardTopHeadlinesState();
// }
//
// class _CardTopHeadlinesState extends State<CardTopHeadlines> {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return BlocBuilder<HeadlinesCubit, HeadlinesState>(
//       builder: (context, state) {
//           return Bounce(
//             child: Stack(
//               children: [
//                 Image.asset(
//                   'assets/images/layImage.png',
//                 width: double.infinity,
//                 fit: BoxFit.cover,
//                 ),
//               ],
//             ),
//           );
//       },
//     );
//   }
// }
