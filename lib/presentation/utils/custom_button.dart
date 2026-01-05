import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final double width;
  final double height;
  final double borderRadius;
  final Color color;
  final Color borderColor;
  const CustomButton({
    super.key,
    required this.onTap,
    required this.child,
    this.width = 120,
    this.color = const Color(0xFFbe2b27),
    this.borderRadius = 8,
    this.height = 45,
    this.borderColor = const Color(0xFFbe2b27),
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        constraints: BoxConstraints(minHeight: height),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Center(child: child),
      ),
    );
  }
}
