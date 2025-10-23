import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';

class Shimmer extends StatelessWidget {
  final double borderRadius;
  const Shimmer({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8,
    this.baseColor,
  });

  final double height, width;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: borderRadius,
      baseColor: baseColor ?? const Color(0xfff1f1f1),
      fadeTheme: FadeTheme.dark,
    );
  }
}

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({super.key, required this.height, required this.width});
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return FadeShimmer(
      height: height,
      width: width,
      radius: 100,
      baseColor: const Color(0xfff1f1f1),
      fadeTheme: FadeTheme.dark,
    );
  }
}
