import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/data/models/profile_model.dart';
import 'package:abudiyab/modules/home/profile/page/widget/container_tile.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widget/card_member.dart';
import 'widget/info_member_ship.dart';

class MemberShipScrean extends StatelessWidget {
  const MemberShipScrean({Key? key, required this.member}) : super(key: key);
  final ProfileModel member;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale!.memberShip!.toString(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
        ),
        leading: ADBackButton(),
      ),
      body:
          Center(
            child: SingleChildScrollView(
              child: ContainerTileWidget(
                widgets: [
                  CardMemberWidget(image: member.membership!.image!),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${locale.points} : ${member.membership!.ratioPoints}",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [

                          InfoMemnerShip(
                            title: locale.rentalDiscount,
                            data: "${member.membership!.rentalDiscount} %",
                            svgPic: 'assets/icons/rentalDiscount.svg',
                          ),
                          InfoMemnerShip(
                            title: locale.allowedKilos,
                            data: "${member.membership!.allowedKilos} KM",
                            svgPic: 'assets/icons/allowedKilos.svg',
                          ),
                          InfoMemnerShip(
                            title: locale.extraHours,
                            data: member.membership!.extraHours.toString(),
                            svgPic: 'assets/icons/extraHours.svg',
                          ),
                          InfoMemnerShip(
                            title: locale.regionsDiscount,
                            data:
                                "${member.membership!.deliveryDiscountRegions} %",
                            svgPic: 'assets/icons/regionsDiscount.svg',
                          ),
                          InfoMemnerShip(
                            title: locale.ratioPoints,
                            data: member.membership!.ratioPoints.toString(),
                            svgPic: 'assets/icons/ratioPoints.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                 /* Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Bounce(
                      onTap: () {
                        // Navigator.of(context).push(
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) =>
                        //         const (),
                        //   ),
                        // );
                        pushNewScreen(context, screen: AllMemberShip());
                      },
                      child: Text.rich(
                        TextSpan(
                          text: locale.moreMembershipDetails,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                          children: [
                            TextSpan(
                                text: locale.clickHere,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontSize: 14))
                          ],
                        ),
                      ),
                    ),
                  )*/
                ],
              ),
            ),
          ),
    );
  }
}
