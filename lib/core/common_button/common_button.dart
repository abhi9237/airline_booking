import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../font_helper/font_helper.dart';

class HotelFlightCommonButton extends StatelessWidget {
  final RxBool? isLoading;
  final VoidCallback? onTap;
  final String? buttonText;
  const HotelFlightCommonButton(
      {super.key, this.onTap, this.buttonText, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => isLoading?.value == true
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.blue,
            ))
          : InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                height: 45.h,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: Colors.blue,
                ),
                child: Text(
                  buttonText ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontFamily: FontHelper.boldFont,
                  ),
                ),
              ),
            ),
    );
  }
}
