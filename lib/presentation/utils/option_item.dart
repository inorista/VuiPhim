import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String imgPath;
  const OptionItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTap.call();
      },
      child: Row(
        spacing: 10,
        children: [
          SvgPicture.asset(
            imgPath,
            width: 30,
            height: 30,
            colorFilter: const ColorFilter.mode(
              Colors.white70,
              BlendMode.srcIn,
            ),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
