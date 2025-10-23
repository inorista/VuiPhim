import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAnimationAppbar extends StatefulWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final ScrollController? scrollController;
  final double? appBarHeight;
  final bool isBackable;
  const CustomAnimationAppbar({
    super.key,
    this.title,
    this.scrollController,
    this.appBarHeight,
    this.leading,
    this.actions,
    this.isBackable = true,
  });

  @override
  State<CustomAnimationAppbar> createState() => _CustomAnimationAppbarState();
}

class _CustomAnimationAppbarState extends State<CustomAnimationAppbar> {
  double get _appBarHeight =>
      widget.appBarHeight ?? (Platform.isIOS ? 115.0 : 80.0);
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
          child: SizedBox(
            height: _appBarHeight,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: _appBarHeight,
                  color: Colors.black.withAlpha(40),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          height: _appBarHeight,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.leading != null
                      ? widget.leading!
                      : widget.isBackable
                      ? InkWell(
                          onTap: () {
                            context.pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(150),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              CupertinoIcons.back,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  widget.title != null
                      ? Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              widget.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white.withOpacity(_opacity),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  if (widget.actions != null)
                    Row(children: widget.actions!)
                  else
                    const SizedBox(width: 14),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
