import 'package:flutter/material.dart';

AppBar appBar(BuildContext context, String title) {
  return AppBar(
    titleSpacing: 0,
    leading: IconButton(
        icon: Icon(
          Icons.chevron_left,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
    elevation: 0,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.5),
    ),
  );
}
