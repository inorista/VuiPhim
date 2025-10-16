import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StraggeredAnimationList extends StatefulWidget {
  final List<Widget> children;
  const StraggeredAnimationList({super.key, required this.children});

  @override
  State<StraggeredAnimationList> createState() =>
      _StraggeredAnimationListState();
}

class _StraggeredAnimationListState extends State<StraggeredAnimationList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _buildAnimatedBox(widget.children[index], index);
          }, childCount: widget.children.length),
        ),
      ],
    );
  }

  Widget _buildAnimatedBox(Widget item, int index) {
    final delay = index * 0.1;
    final animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(delay, delay + 0.6, curve: Curves.easeOut),
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0.0, (1 - animation.value) * 50),
            child: item,
          ),
        );
      },
    );
  }
}
