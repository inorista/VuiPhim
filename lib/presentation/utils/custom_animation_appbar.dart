import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAnimationAppbar extends StatefulWidget {
  final String title;
  final ScrollController? scrollController;
  const CustomAnimationAppbar({
    super.key,
    required this.title,
    this.scrollController,
  });

  @override
  State<CustomAnimationAppbar> createState() => _CustomAnimationAppbarState();
}

class _CustomAnimationAppbarState extends State<CustomAnimationAppbar> {
  final _appBarHeight = Platform.isIOS ? 115.0 : 80.0;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (widget.scrollController != null) {
      double offset = widget.scrollController!.offset;
      double newOpacity = (offset / 100).clamp(0.0, 1.0);
      if (newOpacity != _opacity) {
        setState(() {
          _opacity = newOpacity;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Opacity(
          opacity: _opacity,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                height: _appBarHeight,
                color: Colors.black.withAlpha(150),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(150),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.back, color: Colors.black),
                  ),
                ),

                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(_opacity),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // On SHARE
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(150),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      CupertinoIcons.share_up,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
