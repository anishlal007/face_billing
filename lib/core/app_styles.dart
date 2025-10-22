import 'package:facebilling/core/colors.dart';
import 'package:flutter/material.dart';

TextStyle labelStyle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12);
TextStyle textStyle =
    const TextStyle(fontWeight: FontWeight.w700, fontSize: 11);
TextStyle blueTextStyle = const TextStyle(fontSize: 13, color: primary);
TextStyle revenueCardTextStyle =
    const TextStyle(fontWeight: FontWeight.w400, fontSize: 10);
TextStyle cardTitleStyle =
    textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.w500);
TextStyle normalTextStyle =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 11);
TextStyle normalGreyTextStyle =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 11, color: gray);
TextStyle normalLightBlackTextStyle =
    const TextStyle(fontWeight: FontWeight.normal, fontSize: 11, color: black);
TextStyle tableHeadingStyle =
    const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: white);

InputDecoration boxBorderStyle = const InputDecoration(
    isDense: true,
    filled: true,
    fillColor: white,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: gray, width: 0.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: gray,
        width: 2.0,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: gray,
        width: 2.0,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: gray,
        width: 2.0,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: gray,
        width: 2.0,
      ),
    ));

Decoration boxCurvedDecoration = BoxDecoration(
    border: Border.all(color: gray, width: 1),
    color: white,
    borderRadius: const BorderRadius.all(Radius.circular(10)));
Decoration boxDecoration = BoxDecoration(
  border: Border.all(color: gray, width: 1),
  color: primary,
);
Decoration boxTransporentCurvedDecoration = BoxDecoration(
    border: Border.all(color: gray, width: 1),
    borderRadius: const BorderRadius.all(Radius.circular(10)));
