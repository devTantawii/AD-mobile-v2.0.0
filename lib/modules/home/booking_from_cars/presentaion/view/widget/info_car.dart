import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:flutter/material.dart';

class InfoCar extends StatelessWidget {
  const InfoCar({Key? key, required this.carModel}) : super(key: key);
  final DataCars carModel;
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FittedBox(
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    carModel.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        carModel.manufactory,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 14),
                      ),
                      SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          text: '${carModel.priceAfter}' + "  ",
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: [
                            TextSpan(
                              text: "${carModel.priceBefore}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                    // color: Color(0xff6e9ed3),
                                  ),
                            ),
                            TextSpan(
                              text: " ${locale!.sar}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(carModel.photo),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
