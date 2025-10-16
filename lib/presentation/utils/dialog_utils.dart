import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vuiphim/presentation/utils/straggered_animation_widget.dart';

class DialogUtils {
  static Future<void> showBluredDialogWithCustomChildren(
    BuildContext context, {
    Widget? child,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        final height = MediaQuery.sizeOf(context).height;
        final width = MediaQuery.sizeOf(context).width;
        return StaggeredAnimationWidget(
          child: Stack(
            alignment: Alignment.center,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.black.withAlpha(50),
                ),
              ),

              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: Colors.black.withAlpha(20)),

                child: Center(
                  child: Container(
                    color: Colors.white,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
