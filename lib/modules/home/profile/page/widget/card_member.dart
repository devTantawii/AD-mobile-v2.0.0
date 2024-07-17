import 'package:flutter/material.dart';

class CardMemberWidget extends StatelessWidget {
  const CardMemberWidget({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(image),
        ),
      ),
    );
  }
}
