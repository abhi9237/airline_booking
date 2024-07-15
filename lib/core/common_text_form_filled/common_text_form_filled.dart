import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';

import '../../presentation/flights/search_flight/modal/airport_suggestion_modal.dart';
import '../constants/image_constant.dart';
import '../font_helper/font_helper.dart';

class CommonFlightTextFormFilled extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  String? airportLocation;
  final String? flightIcon;
  TextEditingController? controller;
  final Function(String)? onChanged;
  Function(Data)? onSelected;
  String Function()? selectedLocation;
  final VoidCallback? onTap;
  final List<SearchFieldListItem<Data>>? Function(String)? onSearchTextChanged;
  final List<Data>? suggestionList;
  Function(SearchFieldListItem<Data>)? onSuggestionTap;

  CommonFlightTextFormFilled({
    super.key,
    this.labelText,
    this.selectedLocation,
    this.controller,
    this.hintText,
    this.airportLocation,
    this.onChanged,
    this.onSelected,
    this.onSearchTextChanged,
    this.suggestionList,
    this.onTap,
    this.onSuggestionTap,
    this.flightIcon,
  });

  @override
  State<CommonFlightTextFormFilled> createState() =>
      _CommonFlightTextFormFilledState();
}

class _CommonFlightTextFormFilledState
    extends State<CommonFlightTextFormFilled> {
  Widget searchChild(Data x) => SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              x.cityName ?? x.iataCityCode ?? '',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blue,
                fontFamily: FontHelper.boldFont,
              ),
            ),
            Text(
              x.name ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey,
                fontFamily: FontHelper.boldFont,
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2.h,
        // horizontal: 10.w,
      ),
      height: 58.h,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.center,
            height: widget.airportLocation!.isEmpty ? 42.h : 27.h,
            // color: Colors.red,

            // width: Get.width * 0.85,
            child: SearchField<Data>(
              hint: widget.hintText,
              controller: widget.controller,
              // marginColor: Colors.transparent,
              onTap: widget.onTap,
              offset: Offset(0, 40.h),
              itemHeight: 45.h,
              suggestionsDecoration: SuggestionDecoration(
                padding: const EdgeInsets.all(4),
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(5.r)),
              ),
              onSuggestionTap: (v) {
                log('City Name ${v.item?.cityName ?? ''}');
                widget.onSuggestionTap != null
                    ? widget.onSuggestionTap!(v)
                    : null;
                primaryFocus?.unfocus();
                setState(() {});
              },
              onSearchTextChanged: (v) {
                widget.onSearchTextChanged != null
                    ? widget.onSearchTextChanged!(v)
                    : null;
                setState(() {});
              },
              searchStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                fontFamily: FontHelper.boldFont,
              ),
              searchInputDecoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 0.w,
                  bottom: widget.airportLocation!.isEmpty ? 0.h : 10.h,
                  top: widget.airportLocation!.isEmpty ? 10.h : 0.h,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 5.w, top: 5.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: Text(
                          widget.labelText ?? '',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                            fontFamily: FontHelper.semiBoldFont,
                          ),
                        ),
                      ),
                      widget.airportLocation!.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(left: 0.w, top: 3.h),
                              child: Image.asset(
                                widget.flightIcon ??
                                    ImageConstant.flightTakeOffIcon,
                                height: 18.h,
                                width: 18.w,
                                fit: BoxFit.contain,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                border: InputBorder.none,
              ),
              suggestions: (widget.suggestionList ?? [])
                  .map(
                    (e) => SearchFieldListItem<Data>(
                      e.cityName ?? '',
                      item: e,
                      child: searchChild(e),
                    ),
                  )
                  .toList(),
            ),
          ),
          widget.airportLocation!.isEmpty
              ? const SizedBox()
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Image.asset(
                        widget.flightIcon ?? ImageConstant.flightTakeOffIcon,
                        height: 20.h,
                        width: 20.w,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Text(
                      widget.airportLocation ?? '',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                        fontFamily: FontHelper.semiBoldFont,
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}

class CommonPassengnerTextFormFilled extends StatelessWidget {
  final String? title;
  final String? hintText;
  final Widget? prefixIcon;
  final String? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final bool? readOnly;
  final VoidCallback? onTapPrefixIcon;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onChanged;
  const CommonPassengnerTextFormFilled({
    super.key,
    this.title,
    this.textInputFormatter,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onTap,
    this.readOnly,
    this.onTapPrefixIcon,
    this.hintText,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black,
            fontFamily: FontHelper.semiBoldFont, // Replace with your FontHelper
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        SizedBox(
          height: 40.h,
          child: TextFormField(
            onChanged: onChanged,
            keyboardType: keyboardType,
            onTap: onTap,
            readOnly: readOnly ?? false,
            controller: controller,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black,
              fontFamily:
                  FontHelper.semiBoldFont, // Replace with your FontHelper
            ),
            inputFormatters: textInputFormatter,
            decoration: InputDecoration(
              counterText: '',
              hintStyle: TextStyle(
                fontSize: 12.sp,
                color: Colors.black,
                fontFamily:
                    FontHelper.semiBoldFont, // Replace with your FontHelper
              ),
              hintText: hintText,
              prefixIcon: prefixIcon != null
                  ? InkWell(onTap: onTapPrefixIcon, child: prefixIcon)
                  : null,
              suffixIcon: suffixIcon != null
                  ? Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        suffixIcon ?? '',
                        height: 12.h,
                        width: 12.w,
                        color: Colors.black,
                        fit: BoxFit.contain,
                      ),
                    )
                  : const SizedBox(),
              // contentPadding:
              //     EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}
