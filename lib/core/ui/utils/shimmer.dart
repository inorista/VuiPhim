import 'package:flutter/material.dart';

class Shimmer extends StatelessWidget {
  const Shimmer({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xfff1f1f1),
        borderRadius: BorderRadius.all(Radius.circular(4)),
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
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}
