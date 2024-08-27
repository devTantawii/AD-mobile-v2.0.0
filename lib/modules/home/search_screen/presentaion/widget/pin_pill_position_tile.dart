import 'package:abudiyab/language/locale.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/pin_information.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class PinPillPositionTile extends StatelessWidget {
  final double pinPillPosition;

  final PinInformation currentlySelectedPin;
  final bool isMarker;

  const PinPillPositionTile({
    Key? key,
    required this.isMarker,
    required this.pinPillPosition,
    required this.currentlySelectedPin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);

    return AnimatedPositioned(
      bottom: pinPillPosition,
      right: 0,
      left: 0,
      duration: Duration(milliseconds: 200),
      child: InkWell(
        onTap: currentlySelectedPin.onTap,
        child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(8.0),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset.zero,
                        color: Colors.grey.withOpacity(0.5))
                  ]),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: ClipOval(
                            child: Image.asset(currentlySelectedPin.avatarPath!,
                                fit: BoxFit.cover))),
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: AlignmentDirectional.bottomStart,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(currentlySelectedPin.locationName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14)),
                              Text(
                                currentlySelectedPin.locationAddress ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                              isMarker
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "${locale!.allDays}:  ${currentlySelectedPin.allDayDate} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        AutoSizeText(
                                          "${locale.fri}: ${currentlySelectedPin.friDate} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
