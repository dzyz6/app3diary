// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
class Adapt {
  
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double physicalWidth = 0;
  static double physicalHeight = 0;
  static double dpr = 0;
  static double ratio = 1.0;
  static double statusBarHeight = 0;
  static double bottomHeight = 0;
  static double ratio2 = 1.0;

  static void initialize(BuildContext context, {double UIWidth = 430,double UIHeight =932}) {
    // 1.媒体查询信息
    final mediaQueryData = MediaQuery.of(context);

    // 2.获取宽度和高度
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;
    //像素比
    dpr = window.devicePixelRatio;

    // 3.状态栏的高度
    // 顶部有刘海:47pt 没有刘海的屏幕为20pt
    statusBarHeight = mediaQueryData.padding.top;
    // 底部有刘海:34pt 没有刘海的屏幕0pt
    bottomHeight = mediaQueryData.padding.bottom;
    //比例
    ratio = screenWidth/UIWidth;
    ratio2 = screenHeight/UIHeight;
  }

  static pt(size){
    return size * Adapt.ratio;
  }//使用宽为比例
  static hpt(size){
    return size * Adapt.ratio2;
  }//使用高为比例
}
