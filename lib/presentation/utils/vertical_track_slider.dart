import 'package:flutter/material.dart';

class VerticalTrackSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final Color? activeColor;
  final Color? inactiveColor;
  final double width;
  final double height;

  const VerticalTrackSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor,
    this.inactiveColor,
    this.width = 30.0,
    this.height = 200.0,
  });

  @override
  State<VerticalTrackSlider> createState() => _VerticalTrackSliderState();
}

class _VerticalTrackSliderState extends State<VerticalTrackSlider> {
  double _currentValue = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant VerticalTrackSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _currentValue = widget.value;
    }
  }

  void _onPanDown(DragDownDetails details, BoxConstraints constraints) {
    setState(() {
      _isDragging = true;
      _updateValue(details.localPosition, constraints);
    });
  }

  void _onPanUpdate(DragUpdateDetails details, BoxConstraints constraints) {
    _updateValue(details.localPosition, constraints);
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  void _updateValue(Offset localPosition, BoxConstraints constraints) {
    final double dragPosition = localPosition.dy;
    final double clampedPosition = dragPosition.clamp(
      0.0,
      constraints.maxHeight,
    );
    final double percentage = 1.0 - (clampedPosition / constraints.maxHeight);
    final double newValue =
        widget.min + (percentage * (widget.max - widget.min));

    setState(() {
      _currentValue = newValue;
    });

    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return GestureDetector(
            onPanDown: (details) => _onPanDown(details, constraints),
            onPanUpdate: (details) => _onPanUpdate(details, constraints),
            onPanEnd: _onPanEnd,
            child: CustomPaint(
              painter: _VerticalTrackSliderPainter(
                value: _currentValue,
                min: widget.min,
                max: widget.max,
                activeColor:
                    widget.activeColor ?? Theme.of(context).primaryColor,
                inactiveColor:
                    widget.inactiveColor ?? Colors.grey.withOpacity(0.3),
                isDragging: _isDragging,
                trackWidth: 4.0,
              ),
              size: Size(constraints.maxWidth, constraints.maxHeight),
            ),
          );
        },
      ),
    );
  }
}

class _VerticalTrackSliderPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final Color activeColor;
  final Color inactiveColor;
  final bool isDragging;
  final double trackWidth;

  _VerticalTrackSliderPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.inactiveColor,
    required this.isDragging,
    required this.trackWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double trackHeight = size.height;
    final double trackCenterX = size.width / 2;

    final Paint inactiveTrackPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              inactiveColor.withOpacity(0.3),
              inactiveColor.withOpacity(0.1),
            ],
          ).createShader(
            Rect.fromPoints(
              Offset(trackCenterX - trackWidth / 2, 0),
              Offset(trackCenterX + trackWidth / 2, trackHeight),
            ),
          )
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(trackCenterX, 0),
      Offset(trackCenterX, trackHeight),
      inactiveTrackPaint,
    );

    final double percentage = (value - min) / (max - min);
    final double activeHeight = trackHeight * percentage;

    final Paint activeTrackPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              activeColor.withOpacity(0.9),
              activeColor.withOpacity(0.7),
            ],
          ).createShader(
            Rect.fromPoints(
              Offset(trackCenterX - trackWidth / 2, trackHeight - activeHeight),
              Offset(trackCenterX + trackWidth / 2, trackHeight),
            ),
          )
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(trackCenterX, trackHeight),
      Offset(trackCenterX, trackHeight - activeHeight),
      activeTrackPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
