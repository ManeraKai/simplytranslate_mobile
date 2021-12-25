/* 
 * Copyright (c) 2021 fgsoruco.
 * See LICENSE for more details.
 */
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/factory/utils.dart';

///Class for process [BilateralFilter]
class BilateralFilterFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> bilateralFilter({
    required CVPathFrom pathFrom,
    required String pathString,
    required int diameter,
    required int sigmaColor,
    required int sigmaSpace,
    required int borderType,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;

    int diameterTemp = (diameter >= 0)
        ? (diameter == 0)
            ? 1
            : diameter
        : -1 * diameter;
    int borderTypeTemp = Utils.verBorderType(borderType);

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod('bilateralFilter', {
          "pathType": 1,
          "pathString": pathString,
          "data": Uint8List(0),
          'diameter': diameterTemp,
          "sigmaColor": sigmaColor,
          "sigmaSpace": sigmaSpace,
          "borderType": borderTypeTemp,
        });
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('bilateralFilter', {
          "pathType": 2,
          "pathString": '',
          "data": await _file.readAsBytes(),
          "diameter": diameterTemp,
          "sigmaColor": sigmaColor,
          "sigmaSpace": sigmaSpace,
          "borderType": borderTypeTemp,
        });

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('bilateralFilter', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
          "diameter": diameterTemp,
          "sigmaColor": sigmaColor,
          "sigmaSpace": sigmaSpace,
          "borderType": borderTypeTemp,
        });
        break;
    }

    return result;
  }
}
