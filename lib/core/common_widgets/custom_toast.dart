import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../font_helper/font_helper.dart';

class CustomToast {
  static showToast(
    final String mesage, {
    final Color? bgColor,
    final Color? textColor,
  }) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 3),
      messageText: Text(
        mesage ?? '',
        style: TextStyle(
          color: textColor ?? Colors.blue,
          fontSize: 14.sp,
          fontFamily: FontHelper.boldFont,
        ),
      ),
      backgroundColor: bgColor ?? Colors.white,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(Get.context!);
  }
}
