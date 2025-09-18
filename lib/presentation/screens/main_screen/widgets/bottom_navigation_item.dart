import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationItem extends StatelessWidget {
  final Function onTap;
  final bool isSelected;
  final String label;
  final String iconPath;
  const BottomNavigationItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.label,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(
              !isSelected ? Colors.white : const Color(0xffff7b7b),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
              color: !isSelected ? Colors.white : const Color(0xffff7b7b),
            ),
          ),
        ],
      ),
    );
  }
}
