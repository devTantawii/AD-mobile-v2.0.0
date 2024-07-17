import 'package:abudiyab/core/constants/assets/assets.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/widgets/components/constants.dart';
import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      // physics: ScrollPhysics(),
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              locale.dummyRating!,
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(Icons.star, size: 10, color: Colors.white)
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("98" + locale.peopleRated!,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(fontSize: 12))
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      List profile = [
                        Assets.layer_10,
                        Assets.layer_12,
                        Assets.layer_13
                      ];
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            AssetImage(profile[index]),
                                      ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          locale.dummyName1!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(fontSize: 13),
                                        ),
                                        Text(
                                          locale.dummyDate1!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2!
                                              .copyWith(fontSize: 10),
                                        )
                                      ],
                                    )
                                  ],
                                ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 13,
                                        color: Colors.orange,
                                      )
                                    ],
                                  ),

                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              locale.lorem!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 12, color: Colors.grey[300]),
                            ),
                            Divider()
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
