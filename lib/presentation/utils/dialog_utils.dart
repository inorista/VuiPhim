import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vuiphim/presentation/utils/straggered_animation_widget.dart';

class DialogUtils {
  static Future<void> showBottomSheetWithCustomChildren(
    BuildContext context, {
    Widget? child,
    double initialChildSize = 0.2,
    double minChildSize = 0.2,
    double maxChildSize = 0.25,
  }) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff2b2b2b),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: initialChildSize,
          minChildSize: minChildSize,
          maxChildSize: maxChildSize,
          snap: false,
          expand: false,
          builder: (context, scrollController) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: const BoxDecoration(
                    color: Color(0xff2b2b2b),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  static Future<void> showYesNoDialog(
    BuildContext context, {
    required String title,
    required String content,
    required VoidCallback onYesPressed,
    required VoidCallback onNoPressed,
    required String yesText,
    required String noText,
  }) async {
    const Color dialogBackgroundColor = Color(0xFFF5F1ED);
    const Color primaryTextColor = Color(0xFF1E293B);
    const Color secondaryTextColor = Color(0xFF475569);
    const Color deleteButtonColor = Color(0xFFD95374);
    const Color cancelButtonBorderColor = Color(0xFFCBD5E1);
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: 250,
            width: 450,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: dialogBackgroundColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        content,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: secondaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                side: const BorderSide(
                                  color: cancelButtonBorderColor,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: onNoPressed,
                              child: Text(
                                noText,
                                style: const TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: deleteButtonColor,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              onPressed: onYesPressed,
                              child: Text(
                                yesText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Nút X để đóng
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: secondaryTextColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: height,
                  width: width,
                  color: Colors.white.withAlpha(20),
                ),
              ),

              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(color: Colors.black.withAlpha(50)),

                child: Center(child: child),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: IgnorePointer(
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(200),
                        ],
                        stops: const [0.4, 1.0],
                      ).createShader(
                        Rect.fromLTRB(0, 0, rect.width, rect.height),
                      );
                    },
                    blendMode: BlendMode.dstIn,
                    child: Container(height: 300, color: Colors.black),
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.pop();
                    },
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
