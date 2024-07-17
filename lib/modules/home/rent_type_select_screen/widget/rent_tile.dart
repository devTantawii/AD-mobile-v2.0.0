import 'dart:ui';
import 'package:abudiyab/core/helpers/enums.dart';
import 'package:flutter/material.dart';

class RentTile extends StatefulWidget {
  RentTile(
      {Key? key,
      required this.icon,
      required this.color,
      required this.text,
      required this.changed,
      required this.choosedTile,  required this.rentType})
      : super(key: key);
  final String icon;
  final Color color;
  final String text;
  final ValueChanged changed;
  final RentType? choosedTile;
  final  RentType rentType;

  @override
  State<RentTile> createState() => _RentTileState();
}

class _RentTileState extends State<RentTile> {
  bool choose = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _CardBackground(
      child: GestureDetector(
        onTap: () {
          widget.changed(choose);
        },
        child: Container(
          height: 180,
          margin: const EdgeInsets.all(5.0),
          width: size.width * 0.4,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                blurRadius: 1,
                offset: const Offset(2, 3),
              ),
            ],
            color: widget.choosedTile == widget.rentType
                ? Theme.of(context).colorScheme.onSecondary.withOpacity(0.5)
                : Theme.of(context).scaffoldBackgroundColor,
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topLeft,
              colors: <Color>[
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).colorScheme.onSecondary,
                //Color(0xff3a3b55),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    //margin: const EdgeInsets.all(8),
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.icon),
                        fit: BoxFit.contain,
                      ),
                      // shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    this.widget.text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({required this.child});

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: this.child,
          ),
        ),
      );
}
