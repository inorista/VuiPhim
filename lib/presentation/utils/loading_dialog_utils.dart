import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:developer';

class LoadingDialogUtils {
  /// show loading and return the dialog
  static Future<void> showLoading({String message = 'Please wait...'}) async {
    await EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      indicator: const CupertinoActivityIndicator(radius: 20),
    );
  }

  static Future<void> hideLoading() async {
    try {
      if (EasyLoading.isShow) {
        await EasyLoading.dismiss();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  /// Show loading dialog before call the [load] function async
  /// Hide loading after [load] finshing
  /// Return result of [load] method
  static Future<T> loading<T>(Future<T> Function() load) async {
    await showLoading();
    T result;
    try {
      result = await load();
    } catch (e) {
      log(e.toString());
      rethrow;
    } finally {
      await hideLoading();
    }
    return result;
  }
}
