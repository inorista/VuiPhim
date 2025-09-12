import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  final double borderRadius;
  const Shimmer({super.key, this.height, this.width, this.borderRadius = 8});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xfff1f1f1),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
    );
  }
}

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: Color(0xfff1f1f1),
        shape: BoxShape.circle,
      ),
    );
  }
}
