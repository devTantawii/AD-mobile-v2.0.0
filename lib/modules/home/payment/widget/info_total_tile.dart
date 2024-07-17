import 'package:flutter/material.dart';

class InfoTotalTileWidget extends StatelessWidget {
  InfoTotalTileWidget(
      {Key? key,
        required this.text,
        required this.price,
        this.showDivider = true})
      : super(key: key);
  final String text;
  final String price;
  final bool showDivider;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.4)
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Text(
                  price,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
