import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/components/ad_back_button.dart';

class ImageCarPage extends StatelessWidget {
  const ImageCarPage({Key? key, required this.photo}) : super(key: key);
  final List<Photo> photo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ADBackButton(),
      ),
      body: PageView.builder(
        itemCount: photo.length,
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                onError: (e, s) {
                  Center(child: CircularProgressIndicator.adaptive());
                },
                image: NetworkImage(photo[index].url!),
              ),
            ),
          );
        },
      ),
    );
  }
}
