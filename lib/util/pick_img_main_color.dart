//import 'package:palette_generator/palette_generator.dart';
import 'package:doubanapp/util/palette_generator.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

typedef ColorCallBack = void Function(Color color);

///提取图片的主色调
class PickImgMainColor {
  static Future<void> pick(
      ImageProvider imageProvider, ColorCallBack callBack) async {
    var paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      callBack(paletteGenerator.colors.toList()[0]);
    } else {
      callBack(null);
    }
  }

  static Future<void> pick2(
      ImageProvider imageProvider) async {
    var paletteGenerator =
    await PaletteGenerator.fromImageProvider(imageProvider);
    if (paletteGenerator != null && paletteGenerator.colors.isNotEmpty) {
      return (paletteGenerator.colors.toList()[0]);
    } else {
      return (null);
    }
  }
}
