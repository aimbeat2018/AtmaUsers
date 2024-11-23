// ignore_for_file: must_be_immutable

import 'package:doctor/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:doctor/utils/font_style.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final bool filled;
  bool? obscureText;
  String? hintText;
  Color? fillColor;
  Color? hintTextColor;
  Color? cursorColor;
  Color? fontColor;
  double? hintTextSize;
  double? fontSize;
  int? maxLines;
  int? maxLength;
  bool? readOnly;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextStyle? textStyle;
  TextEditingController? controller;
  TextInputAction? textInputAction;
  TextInputType? textInputType;
  String? Function(String?)? validator;
  String? Function(String?)? onChanged;
  List<TextInputFormatter>? inputFormatters;

  CustomTextField({
    super.key,
    required this.filled,
    this.obscureText,
    this.hintText,
    this.fillColor,
    this.fontColor,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.readOnly,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.hintTextColor,
    this.textStyle,
    this.hintTextSize,
    this.fontSize,
    this.textInputAction,
    this.textInputType,
    this.validator,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      maxLength: maxLength,
      validator: validator,
      onChanged: onChanged,
      cursorColor: cursorColor,
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      style: FontStyle.fontStyleW600(
        fontSize: fontSize ?? 13,
        fontColor: fontColor ?? AppColors.primaryAppColor1,
      ),
      textInputAction: textInputAction,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primaryAppColor1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.notificationTitle2),
        ),
        fillColor: fillColor,
        filled: filled,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: FontStyle.fontStyleW500(
          fontSize: hintTextSize ?? 0.0,
          fontColor: hintTextColor ?? AppColors.transparent,
        ),
        errorStyle: FontStyle.fontStyleW500(
          fontSize: 11,
          fontColor: AppColors.notificationTitle2,
        ),
      ),
    );
  }
}
