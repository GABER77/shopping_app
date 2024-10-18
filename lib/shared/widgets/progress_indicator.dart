import 'package:flutter/material.dart';

class ConditionalProgressIndicator extends StatelessWidget {
  final bool condition;
  final Widget widgetIfTrue;

  const ConditionalProgressIndicator({
    super.key,
    required this.condition,
    required this.widgetIfTrue,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? widgetIfTrue
        : const Center(child: CircularProgressIndicator());
  }
}