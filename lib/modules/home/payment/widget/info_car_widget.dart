import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:flutter/material.dart';

class InfoCarWidget extends StatelessWidget {
  final DataCars? carModel;

  const InfoCarWidget({Key? key, required this.see, required this.carModel})
      : super(key: key);
  final bool see;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Row(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.only(top: see ? 0 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      carModel!.name.toString(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          carModel!.manufactory,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14),
                        ),
                        SizedBox(height: 20),
                        Text.rich(
                          TextSpan(
                            text: carModel!.priceAfter.toString() + "  ",
                            style: Theme.of(context).textTheme.headline6,
                            children: [
                              TextSpan(
                                text: carModel!.priceBefore.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 16),
                              ),
                              TextSpan(
                                text: locale!.sar.toString(),
                                style: Theme.of(context).textTheme.overline,
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
        ),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(carModel!.photo),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
