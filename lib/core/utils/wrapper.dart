import 'package:flutter/material.dart';

Widget wrapWidget(Widget widget, BuildContext context) {
  return InheritedTheme.captureAll(
    context,
    MediaQuery(
      data: MediaQuery.of(context),
      child: Material(type: MaterialType.transparency, child: widget),
    ),
  );
}
