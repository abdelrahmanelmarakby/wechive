import 'package:flutter/material.dart';

class LoaderHUD extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator = Container(
    width: 200,
    height: 100,
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: ThemeData().primaryColor.withOpacity(0.7),
    ),
    child: const Center(child: CircularProgressIndicator()),
  );
  final bool dismissible;
  final Widget child;

  LoaderHUD({
    required this.inAsyncCall,
    required this.child,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.dismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    if (!inAsyncCall) return child;

    return Stack(
      children: [
        child,
        Opacity(
          child: ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        Center(child: progressIndicator),
      ],
    );
  }
}
