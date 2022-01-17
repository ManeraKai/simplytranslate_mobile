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

///Class for process [CvtColor]
class CvtColorFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> cvtColor({
    required CVPathFrom pathFrom,
    required String pathString,
    required int outputType,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod('cvtColor', {
          "pathType": 1,
          "pathString": pathString,
          "data": Uint8List(0),
          'outputType': outputType,
        });
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('cvtColor', {
          "pathType": 2,
          "pathString": '',
          "data": await _file.readAsBytes(),
          'outputType': outputType,
        });

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('cvtColor', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
          'outputType': outputType,
        });
        break;
    }

    return result;
  }
}
