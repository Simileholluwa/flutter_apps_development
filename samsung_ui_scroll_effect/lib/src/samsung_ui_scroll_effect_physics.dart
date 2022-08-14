import 'package:flutter/material.dart';
import 'package:samsung_ui_scroll_effect/src/samsung_ui_scroll_effect_simulation.dart';

class SamsungUiScrollPhysics extends ScrollPhysics {
  const SamsungUiScrollPhysics(this.expandedHeight, {ScrollPhysics? parent})
      : super(parent: parent);

  final double expandedHeight;

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SamsungUiScrollPhysics(expandedHeight,
        parent: buildParent(ancestor));
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    if ((velocity.abs() < tolerance.velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return null;
    }
    return SamsungUiScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      expandedHeight: expandedHeight,
    );
  }
}
