import 'package:flutter/material.dart';
import 'dart:ui' as ui;
//系统默认的appBar等高度
//位于Dart Packages/flutter/src/material/constans.dart

/**
 * @Author: thl
 * @GitHub: https://github.com/Sky24n
 * @Email: 863764940@qq.com
 * @Email: sky24no@gmail.com
 * @Description: Screen Util.
 * @Date: 2018/9/8
 */

///默认设计稿尺寸（单位 dp or pt）
double _designW = 360.0;
double _designH = 640.0;
double _designD = 3.0;

/**
 * 配置设计稿尺寸（单位 dp or pt）
 * w 宽
 * h 高
 * density 像素密度
 */

/// 配置设计稿尺寸 屏幕 宽，高，密度。
/// Configuration design draft size  screen width, height, density.
void setDesignWHD(double w, double h, {double density = 3.0}) {
  _designW = w;
  _designH = h;
  _designD = density;
}

/// Screen Util.
class ScreenUtils {
  double _screenWidth = 0.0;
  double _screenHeight = 0.0;
  double _screenDensity = 0.0;
  double _statusBarHeight = 0.0;
  double _bottomBarHeight = 0.0;
  double _appBarHeight = 0.0;
  MediaQueryData _mediaQueryData;

  static final ScreenUtils _singleton = ScreenUtils();

  static ScreenUtils getInstance() {
    _singleton._init();
    return _singleton;
  }

  _init() {
    MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);
    if (_mediaQueryData != mediaQuery) {
      _mediaQueryData = mediaQuery;
      _screenWidth = mediaQuery.size.width;
      _screenHeight = mediaQuery.size.height;
      _screenDensity = mediaQuery.devicePixelRatio;
      _statusBarHeight = mediaQuery.padding.top;
      _bottomBarHeight = mediaQuery.padding.bottom;
      _appBarHeight = kToolbarHeight;
    }
  }

  /// screen width
  /// 屏幕 宽
  double get screenWidth => _screenWidth;

  /// screen height
  /// 屏幕 高
  double get screenHeight => _screenHeight;

  /// appBar height
  /// appBar 高
  double get appBarHeight => _appBarHeight;

  /// screen density
  /// 屏幕 像素密度
  double get screenDensity => _screenDensity;

  /// status bar Height
  /// 状态栏高度
  double get statusBarHeight => _statusBarHeight;

  /// bottom bar Height
  double get bottomBarHeight => _bottomBarHeight;

  /// media Query Data
  MediaQueryData get mediaQueryData => _mediaQueryData;

  /// screen width
  /// 当前屏幕 宽
  static double screenW(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width;
  }

  /// screen height
  /// 当前屏幕 高
  static double screenH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.height;
  }

  /// screen density
  /// 当前屏幕 像素密度
  static double getScreenDensity(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.devicePixelRatio;
  }

  /// status bar Height
  /// 当前状态栏高度
  static double getStatusBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.top;
  }

  /// status bar Height
  /// 当前BottomBar高度
  static double getBottomBarH(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.padding.bottom;
  }

  /// 当前MediaQueryData
  static MediaQueryData getMediaQueryData(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery;
  }

  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  static double getScaleW(BuildContext context, double size) {
    if (context == null || screenW(context) == 0.0) return size;
    return size * screenW(context) / _designW;
  }

  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸 （单位 dp or pt）
  /// size unit dp or pt
  static double getScaleH(BuildContext context, double size) {
    if (context == null || screenH(context) == 0.0) return size;
    return size * screenH(context) / _designH;
  }

  /// returns the font size after adaptation according to the screen density.
  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  static double getScaleSp(BuildContext context, double fontSize) {
    if (context == null || getScreenDensity(context) == 0.0) return fontSize;
    return fontSize * screenW(context) / _designW;
  }

  /// Orientation
  /// 设备方向(portrait, landscape)
  static Orientation getOrientation(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation;
  }

  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// size 单位 dp or pt
  double getWidth(double size) {
    return _screenWidth == 0.0 ? size : (size * _screenWidth / _designW);
  }

  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// size unit dp or pt
  double getHeight(double size) {
    return _screenHeight == 0.0 ? size : (size * _screenHeight / _designH);
  }

  /// returns the size after adaptation according to the screen width.(unit dp or pt)
  /// 返回根据屏幕宽适配后尺寸（单位 dp or pt）
  /// sizePx unit px
  double getWidthPx(double sizePx) {
    return _screenWidth == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenWidth / (_designW * _designD));
  }

  /// returns the size after adaptation according to the screen height.(unit dp or pt)
  /// 返回根据屏幕高适配后尺寸（单位 dp or pt）
  /// sizePx unit px
  double getHeightPx(double sizePx) {
    return _screenHeight == 0.0
        ? (sizePx / _designD)
        : (sizePx * _screenHeight / (_designH * _designD));
  }

  /// returns the font size after adaptation according to the screen density.
  /// 返回根据屏幕宽适配后字体尺寸
  /// fontSize 字体尺寸
  double getSp(double fontSize) {
    if (_screenDensity == 0.0) return fontSize;
    return fontSize * _screenWidth / _designW;
  }
}