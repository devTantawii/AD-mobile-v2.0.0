import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:abudiyab/modules/home/cars/presentaion/widget/car_icon_info.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  final DataCars? datum;

  const About({Key? key, required this.datum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(locale.category!,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15)),
                      ),
                      Text("${datum?.category}" ,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15)),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(locale.type.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 15)),
                      ),
                      Text("${datum?.manufactory}" ,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 15)),
                    ],
                  ),
                  // SizedBox(height: 20),
                  // Text(locale.about!,
                  //     style: Theme.of(context)
                  //         .textTheme
                  //         .bodyLarge!
                  //         .copyWith(fontSize: 15)),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      datum?.description ?? "",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CarIconInfo(
                          image: "assets/images/car-door.png",
                          text: "${datum?.doors ?? "1"}"),
                      CarIconInfo(
                          image: "assets/images/seat.png", text: "${datum?.luggage ?? "1"}"),
                      CarIconInfo(
                          image: "assets/images/transmission.png",
                          text: "${datum?.transmission ?? "1"}"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
