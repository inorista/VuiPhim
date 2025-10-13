import 'package:flutter/material.dart';

class VerticalSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final Color? activeColor;
  final Color? thumbColor;
  final double width;
  final double height;
  final bool showTooltip;
  final String? tooltipText;

  const VerticalSlider({
    super.key,
    required this.value,
    this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.activeColor,
    this.thumbColor,
    this.width = 30.0,
    this.height = 200.0,
    this.showTooltip = false,
    this.tooltipText,
  });

  @override
  State<VerticalSlider> createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  double _currentValue = 0.0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant VerticalSlider oldWidget) {
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
          final double percentage =
              (_currentValue - widget.min) / (widget.max - widget.min);
          final double thumbPosition =
              constraints.maxHeight * (1.0 - percentage);

          return Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onPanDown: (details) => _onPanDown(details, constraints),
                onPanUpdate: (details) => _onPanUpdate(details, constraints),
                onPanEnd: _onPanEnd,
                child: CustomPaint(
                  painter: _VerticalSliderPainter(
                    value: _currentValue,
                    min: widget.min,
                    max: widget.max,
                    activeColor:
                        widget.activeColor ?? Theme.of(context).primaryColor,
                    thumbColor: widget.thumbColor ?? Colors.white,
                    thumbPosition: thumbPosition,
                    isDragging: _isDragging,
                    trackWidth: 4.0,
                    thumbRadius: 8.0,
                  ),
                  size: Size(constraints.maxWidth, constraints.maxHeight),
                ),
              ),
              if (widget.showTooltip && _isDragging)
                Positioned(
                  bottom: thumbPosition,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.tooltipText ?? '${(_currentValue * 100).toInt()}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _VerticalSliderPainter extends CustomPainter {
  final double value;
  final double min;
  final double max;
  final Color activeColor;
  final Color thumbColor;
  final double thumbPosition;
  final bool isDragging;
  final double trackWidth;
  final double thumbRadius;

  _VerticalSliderPainter({
    required this.value,
    required this.min,
    required this.max,
    required this.activeColor,
    required this.thumbColor,
    required this.thumbPosition,
    required this.isDragging,
    required this.trackWidth,
    required this.thumbRadius,
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
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0.1),
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

    final Paint activeTrackPaint = Paint()
      ..shader =
          LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              activeColor.withOpacity(0.9),
              activeColor.withOpacity(0.7),
            ],
          ).createShader(
            Rect.fromPoints(
              Offset(trackCenterX - trackWidth / 2, thumbPosition),
              Offset(trackCenterX + trackWidth / 2, trackHeight),
            ),
          )
      ..style = PaintingStyle.stroke
      ..strokeWidth = trackWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(trackCenterX, trackHeight),
      Offset(trackCenterX, thumbPosition),
      activeTrackPaint,
    );

    final Paint thumbPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill
      ..shader = const RadialGradient(colors: [Colors.white, Colors.grey])
          .createShader(
            Rect.fromCircle(
              center: Offset(trackCenterX, thumbPosition),
              radius: thumbRadius * 2,
            ),
          );

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(trackCenterX, thumbPosition + 1),
      thumbRadius + 1,
      shadowPaint,
    );

    canvas.drawCircle(
      Offset(trackCenterX, thumbPosition),
      thumbRadius,
      thumbPaint,
    );

    if (isDragging) {
      final Paint glowPaint = Paint()
        ..color = activeColor.withOpacity(0.5)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(trackCenterX, thumbPosition),
        thumbRadius * 2.5,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
