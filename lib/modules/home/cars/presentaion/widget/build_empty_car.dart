import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/assets/assets.dart';

class BuildEmptyCar extends StatelessWidget {
  const BuildEmptyCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(Assets.img_empty_anim),
          SizedBox(height: 30),
          Text("لا يوجد سيارات حالياً",
          style:TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          ),
        ],
      ),
    );
  }
}
