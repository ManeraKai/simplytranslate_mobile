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

///Class for process [Dilate]
class DilateFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> dilate({
    required CVPathFrom pathFrom,
    required String pathString,
    required List<double> kernelSize,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;

    List<double> kernelSizeTemp = Utils.verKernelSize(kernelSize);

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod(
          'dilate',
          {
            "pathType": 1,
            'pathString': pathString,
            "data": Uint8List(0),
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod(
          'dilate',
          {
            "pathType": 2,
            "pathString": '',
            "data": await _file.readAsBytes(),
            'kernelSize': kernelSizeTemp,
          },
        );

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod(
          'dilate',
          {
            "pathType": 3,
            "pathString": '',
            "data": _fileAssets,
            'kernelSize': kernelSizeTemp,
          },
        );
        break;
    }
    return result;
  }
}
