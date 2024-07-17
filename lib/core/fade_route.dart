import 'package:flutter/material.dart' hide Builder;

/// Move ToNewScreen With Using  the FadeRoute `Animation`
///
/// ``` dart
/// FadeRoute( builder: (context) =>  ScreenName ,DurationTime );
/// ```
class FadeRoute extends PageRouteBuilder {
  final Builder builder;
  final int duration;

  FadeRoute({required this.builder, this.duration = 300})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: duration),
        );
}

typedef Builder = Widget Function(BuildContext context);
