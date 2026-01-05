import 'package:flutter/material.dart';

class GenreTag extends StatelessWidget {
  final String label;
  final Widget trailing;
  final VoidCallback? onTap;
  final LocalKey? widgetKey;

  const GenreTag({
    required this.label,
    required this.trailing,
    this.onTap,
    this.widgetKey,
  }) : super(key: widgetKey);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 110, maxWidth: 140),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withAlpha(100), width: 0.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 7,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
          onTap != null ? InkWell(onTap: onTap, child: trailing) : trailing,
        ],
      ),
    );
  }
}
