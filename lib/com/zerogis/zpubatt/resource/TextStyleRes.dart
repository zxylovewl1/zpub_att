import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:zpub_bas/zpub_bas.dart';

/*
 * 类描述：文本常用风格
 * 作者：郑朝军 on 2019/5/6
 * 邮箱：1250393285@qq.com
 * 公司：武汉智博创享科技有限公司
 * 修改人：郑朝军 on 2019/5/6
 * 修改备注：
 */
class TextStyleRes
{
  static const TextStyle text_smallest_fontw900 = TextStyle(
      fontSize: 12, fontWeight: FontWeight.w900);

  static const TextStyle text_color_text1_smallest = TextStyle(
      fontSize: 12, color: ColorRes.text_color_text1, fontFamily: 'iconfont'); // 12

  static const TextStyle text_color_text_grey_smaller = TextStyle(
      fontSize: 13, color: Colors.grey, fontFamily: 'iconfont'); // 13

  static const TextStyle text_color_text1_smaller = TextStyle(
      fontSize: 13,
      color: ColorRes.text_color_text1,
      fontFamily: 'iconfont'); // 13

  static const TextStyle text_color_text1_small = TextStyle(
      fontSize: 15,
      color: ColorRes.text_color_text1,
      fontFamily: 'iconfont'); // 15

  static const TextStyle text_color_text1_larger_fontw900 = TextStyle(
      fontSize: 17, color: ColorRes.text_color_text1, fontWeight: FontWeight.w900, fontFamily: 'iconfont'); // 17

  static const TextStyle text_red_color_text1_small = TextStyle(
      fontSize: 15,
      color: Colors.red,
      fontFamily: 'iconfont'); // 15

  static const TextStyle text_color_text1_larger = TextStyle(
      fontSize: 17,
      color: ColorRes.text_color_text1,
      fontFamily: 'iconfont'); // 17

  static const TextStyle text_color_text4_larger = TextStyle(
      fontSize: 17,
      color: ColorRes.text_color_text4,
      fontFamily: 'iconfont'); // 17


  static const TextStyle text_color_text1_largest = TextStyle(
      fontSize: 20,
      color: ColorRes.text_color_text1,
      fontFamily: 'iconfont'); // 20
}
