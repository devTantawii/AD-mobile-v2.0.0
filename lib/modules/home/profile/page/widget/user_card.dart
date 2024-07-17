import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';

import '../profile.dart';

class CardUser extends StatefulWidget {
  final ProfileModel profileModel;

  const CardUser({Key? key, required this.profileModel}) : super(key: key);

  @override
  _CardUserState createState() => _CardUserState();
}

class _CardUserState extends State<CardUser> {
  bool isScubaDive = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MyProfile()));
      },
      child: Container(
        width: size.width * 0.5,
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary,
              blurRadius: 1,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: FittedBox(
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.hardEdge,
                            child: Image.network(
                              "${widget.profileModel.avatar}",
                              width: size.width * 0.15,
                              height: size.width * 0.2,
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Visibility(
                              visible: widget.profileModel.stutusLicence ==
                                  StatusLicence.ACCEPTED,
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.011,
                                    right: size.width * 0.012,
                                    top: size.width * 0.006,
                                    bottom: size.width * 0.006),
                                decoration: BoxDecoration(
                                    color: Color(0xff135C89).withOpacity(0.85),
                                    borderRadius: BorderRadius.only(
                                        topLeft:
                                            Radius.circular(size.width * 0.016),
                                        bottomRight: Radius.circular(10))),
                                child: Icon(
                                  Icons.verified_user,
                                  color: Colors.white,
                                  size: size.width * 0.03,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.025),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 90,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: FittedBox(
                            child: Text(
                              widget.profileModel.name.toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: size.width * 0.006),
                          child: FittedBox(
                            child: Text(
                              widget.profileModel.email.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: size.width * 0.008),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(
                                        "Points",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.width * 0.008,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    FittedBox(
                                      child: Text(
                                        widget.profileModel.points.toString(),
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .overline,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: FittedBox(
                    child: Text(
                      "Bronze",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Container(
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                        color: Color(0xffA2B0B6).withOpacity(0.17),
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    child: Center(
                        child: FittedBox(
                      child: Text(
                        "View profile",
                        style: Theme.of(context).textTheme.overline!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    )),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
