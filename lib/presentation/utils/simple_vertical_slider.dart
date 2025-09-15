import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/vertical_slider.dart';

class SimpleVerticalSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final Color activeColor;
  final double width;
  final double height;

  const SimpleVerticalSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor = Colors.red,
    this.width = 30.0,
    this.height = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return VerticalSlider(
      value: value,
      onChanged: onChanged,
      min: min,
      max: max,
      activeColor: activeColor,
      thumbColor: Colors.white,
      width: width,
      height: height,
    );
  }
}
