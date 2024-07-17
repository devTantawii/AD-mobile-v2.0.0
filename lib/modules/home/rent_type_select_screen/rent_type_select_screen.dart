import 'package:abudiyab/core/helpers/enums.dart';
import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/payment/widget/screen_background.dart';
import 'package:abudiyab/modules/home/rent_type_select_screen/widget/rent_tile.dart';
import 'package:abudiyab/modules/home/search_screen/blocs/search_bloc/search_cubit.dart';
import 'package:abudiyab/modules/home/search_screen/presentaion/search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class RentTypeSelectionScreen extends StatefulWidget {
  RentTypeSelectionScreen({Key? key}) : super(key: key);

  @override
  State<RentTypeSelectionScreen> createState() =>
      _RentTypeSelectionScreenState();
}

class _RentTypeSelectionScreenState extends State<RentTypeSelectionScreen> {
  RentType? choiceTile;
  bool? choose;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locale = AppLocalizations.of(context);

    return Scaffold(
      floatingActionButton: AnimatedOpacity(
        opacity: choiceTile == null ? 0 : 1,
        duration: Duration(milliseconds: 400),
        child: Padding(
          padding:
              const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 56),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: StadiumBorder(),
            onPressed: () {
              BlocProvider.of<SearchCubit>(context).rentType = choiceTile!;
              pushNewScreen(context, screen: SearchScreen(
              ));
            },
            child: Icon(Icons.arrow_forward_ios_outlined),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            fit: StackFit.loose,
            children: [
              Container(
                width: double.infinity,
                height: size.height,
                child: BackgroundScreen(),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: size.height * 0.07),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      locale!.abudiyab,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 24),
                    ),
                    SizedBox(height: 5),
                    Text(
                      locale.abudiyabWelcome,
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              Container(
                height: size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RentTile(
                        choosedTile: choiceTile,
                        rentType: RentType.classic,
                        changed: (value) {
                          choose = value;
                          setState(() {
                            choiceTile = RentType.classic;
                          });
                        },
                        icon: 'assets/tagerF.png',
                        color: Theme.of(context).colorScheme.onPrimary,
                        text: locale.classicRent),
                    RentTile(
                        choosedTile: choiceTile,
                        rentType: RentType.automated,
                        changed: (value) {
                          setState(() {
                            choose = value;
                            choiceTile = RentType.automated;
                          });
                        },
                        icon: 'assets/tagerZ.png',
                        color: Theme.of(context).colorScheme.onPrimary,
                        text: locale.automatedRent),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
