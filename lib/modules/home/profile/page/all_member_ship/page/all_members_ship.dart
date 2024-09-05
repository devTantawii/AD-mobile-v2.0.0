import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/profile/page/all_member_ship/bloc/all_member_ship_cubit.dart';
import 'package:abudiyab/modules/home/profile/page/all_member_ship/bloc/all_member_ship_state.dart';
import 'package:abudiyab/modules/home/profile/page/widget/card_member.dart';
import 'package:abudiyab/modules/widgets/components/ad_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../service_locator.dart';
import '../../widget/container_tile.dart';
import '../../widget/info_member_ship.dart';

class AllMemberShip extends StatelessWidget {
  const AllMemberShip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: ADBackButton(),
      ),
      body: BlocProvider(
        create: (context) => sl<AllMemberCubit>()..getAllMember(),
        child: BlocBuilder<AllMemberCubit, AllMemberState>(
          builder: (context, state) {
            if (state is AllMemberLoading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (state is AllMemberLoaded) {
              return ListView.separated(
                  padding: EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 56,
                  ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 15,
                      ),
                  itemCount: state.allMember.data.length,
                  itemBuilder: (context, index) {
                    return
                        Center(
                          child: SingleChildScrollView(
                            child: ContainerTileWidget(
                              widgets: [
                                CardMemberWidget(
                                    image: state.allMember.data[index].image),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${locale!.points} : ${state.allMember.data[index].ratioPoints}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Container(
                                        width: 2.0,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.3),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        InfoMemnerShip(
                                          title: locale.rentalDiscount,
                                          data:
                                              "${state.allMember.data[index].rentalDiscount} %",
                                          svgPic: 'assets/icons/rentalDiscount.svg',
                                        ),
                                        InfoMemnerShip(
                                          title: locale.allowedKilos,
                                          data:
                                              "${state.allMember.data[index].allowedKilos} KM",
                                          svgPic: 'assets/icons/allowedKilos.svg',
                                        ),
                                        InfoMemnerShip(
                                          title: locale.extraHours,
                                          data: state
                                              .allMember.data[index].extraHours
                                              .toString(),
                                          svgPic: 'assets/icons/extraHours.svg',
                                        ),
                                        InfoMemnerShip(
                                          title: locale.regionsDiscount,
                                          data:
                                              "${state.allMember.data[index].deliveryDiscountRegions} %",
                                          svgPic: 'assets/icons/regionsDiscount.svg',
                                        ),
                                        InfoMemnerShip(
                                          title: locale.ratioPoints,
                                          data: state
                                              .allMember.data[index].ratioPoints
                                              .toString(),
                                          svgPic: 'assets/icons/ratioPoints.svg',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );

                  });
            } else
              return Container();
          },
        ),
      ),
    );
  }
}
