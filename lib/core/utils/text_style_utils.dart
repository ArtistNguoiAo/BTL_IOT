
import 'package:btl_iot/core/utils/color_utils.dart';
import 'package:btl_iot/core/utils/font_utils.dart';
import 'package:flutter/material.dart';

class TextStyleUtils {
  //font
  static TextStyle textStyleNunito = const TextStyle(fontFamily: FontUtils.nunito);

  // size
  static TextStyle textStyleNunitoS16 = textStyleNunito.copyWith(fontSize: 16);
  static TextStyle textStyleNunitoS18 = textStyleNunito.copyWith(fontSize: 18);
  static TextStyle textStyleNunitoS20 = textStyleNunito.copyWith(fontSize: 20);
  static TextStyle textStyleNunitoS24 = textStyleNunito.copyWith(fontSize: 24);

  // // weight
  static TextStyle textStyleNunitoS16W400 = textStyleNunitoS16.copyWith(fontWeight: FontWeight.w400);
  static TextStyle textStyleNunitoS20W700 = textStyleNunitoS20.copyWith(fontWeight: FontWeight.w700);
  static TextStyle textStyleNunitoS24W700 = textStyleNunitoS24.copyWith(fontWeight: FontWeight.w700);

  // color
  static TextStyle textStyleNunitoS16W400Black = textStyleNunitoS16W400.copyWith(color: ColorUtils.black);
  static TextStyle textStyleNunitoS16W400White = textStyleNunitoS16W400.copyWith(color: ColorUtils.white);
  static TextStyle textStyleNunitoS20W700Black = textStyleNunitoS20W700.copyWith(color: ColorUtils.black);
  static TextStyle textStyleNunitoS20W700White = textStyleNunitoS20W700.copyWith(color: ColorUtils.white);
  static TextStyle textStyleNunitoS24W700Black = textStyleNunitoS24W700.copyWith(color: ColorUtils.black);
  static TextStyle textStyleNunitoS24W700White = textStyleNunitoS24W700.copyWith(color: ColorUtils.white);
}