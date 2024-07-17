// import 'dart:io';
// import 'dart:ui';

// import 'package:abudiyab/modules/auth/onboarding/bloc/onboarding_cubt_cubit.dart';
// import 'package:abudiyab/modules/auth/register/presentaion/pages/register_page.dart';
// import 'package:abudiyab/modules/auth/signin/presentation/pages/signin_screen.dart';
// import 'package:abudiyab/service_locator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Authentication extends StatefulWidget {
//   const Authentication({Key? key, this.pushAddition = false}) : super(key: key);
//   final bool pushAddition;

//   @override
//   State<Authentication> createState() => _AuthenticationState();
// }

// class _AuthenticationState extends State<Authentication> {
//   bool isLogin = true;

//   void changeAuth() {
//     setState(() {
//       isLogin = !isLogin;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return WillPopScope(
//       onWillPop: () async => exit(0),
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: GestureDetector(
//           onTap: () => FocusScope.of(context).unfocus(),
//           child: BlocProvider(
//             create: (context) => sl<OnBoardingCubit>(),
//             child: BlocBuilder<OnBoardingCubit, bool>(
//               builder: (context, state) {
//                 var cubit = OnBoardingCubit.get(context);
//                 return Scaffold(
//                   body: Stack(
//                     children: [
//                       Container(
//                         foregroundDecoration: BoxDecoration(
//                             gradient: LinearGradient(colors: [
//                           Colors.transparent,
//                           Color(0xff262533).withOpacity(0.8),
//                         ], begin: Alignment.bottomLeft)),
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/car4.jpg"),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         child: BackdropFilter(
//                           filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.0)),
//                           ),
//                         ),
//                       ),
//                       AnimatedPositioned(
//                         curve: Curves.easeInOutBack,
//                         duration: const Duration(milliseconds: 700),
//                         right: cubit.isLogin ? 0 : size.width,
//                         left: cubit.isLogin ? 0 : -size.width,
//                         child: Signin(
//                             cubit: cubit,
//                             isLogin: cubit.onChangeScreen,
//                             pushAddition: widget.pushAddition),
//                       ),
//                       AnimatedPositioned(
//                         right: !cubit.isLogin ? 0 : -size.width,
//                         left: !cubit.isLogin ? 0 : size.width,
//                         duration: const Duration(milliseconds: 700),
//                         curve: Curves.easeInOutBack,
//                         child: RegisterPage(
//                           onBoardingCubit: cubit,
//                           isLogin: changeAuth,
//                           pushAddition: widget.pushAddition,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
