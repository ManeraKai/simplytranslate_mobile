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

///Class for process [Blur]
class BlurFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> blur({
    required CVPathFrom pathFrom,
    required String pathString,
    required List<double> kernelSize,
    required List<double> anchorPoint,
    required int borderType,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;

    int borderTypeTemp = Utils.verBorderType(borderType);
    List<double> kernelSizeTemp = Utils.verKernelSize(kernelSize);

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod(
          'blur',
          {
            "pathType": 1,
            'pathString': pathString,
            "data": Uint8List(0),
            "kernelSize": kernelSizeTemp,
            "anchorPoint": anchorPoint,
            "borderType": borderTypeTemp,
          },
        );
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod(
          'blur',
          {
            "pathType": 2,
            "pathString": '',
            "data": await _file.readAsBytes(),
            "kernelSize": kernelSizeTemp,
            "anchorPoint": anchorPoint,
            "borderType": borderTypeTemp,
          },
        );

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod(
          'blur',
          {
            "pathType": 3,
            "pathString": '',
            "data": _fileAssets,
            "kernelSize": kernelSizeTemp,
            "anchorPoint": anchorPoint,
            "borderType": borderTypeTemp,
          },
        );
        break;
    }
    return result;
  }
}
