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

///Class for process [Filter2D]
class Filter2DFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> filter2D({
    required CVPathFrom pathFrom,
    required String pathString,
    required int outputDepth,
    required List<int> kernelSize,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    List<int> kernelSizeTemp = Utils.verKernelSizeInt(kernelSize);
    int outputDepthTemp = (outputDepth <= 0)
        ? (outputDepth == 0)
            ? -1
            : outputDepth
        : -1 * outputDepth;

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod(
          'filter2D',
          {
            "pathType": 1,
            'pathString': pathString,
            "data": Uint8List(0),
            'outputDepth': outputDepthTemp,
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod(
          'filter2D',
          {
            "pathType": 2,
            "pathString": '',
            "data": await _file.readAsBytes(),
            'outputDepth': outputDepthTemp,
            'kernelSize': kernelSizeTemp,
          },
        );

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod(
          'filter2D',
          {
            "pathType": 3,
            "pathString": '',
            "data": _fileAssets,
            'outputDepth': outputDepthTemp,
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
    }
    return result;
  }
}
