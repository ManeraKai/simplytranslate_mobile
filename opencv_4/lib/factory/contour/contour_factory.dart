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
class ContourFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<List<Uint8List?>> contour({
    required CVPathFrom pathFrom,
    required String pathString,
  }) async {
    File _file;
    Uint8List _fileAssets;
    List<Uint8List?> result;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        var testResult = await platform.invokeMethod(
          'contour',
          {
            "pathString": pathString,
          },
        );

        result = List<Uint8List?>.from(testResult);
        print('finish!!');
        break;
      case CVPathFrom.URL:
        print("starting!");
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('contour', {
          "pathType": 2,
          "pathString": pathString,
          "data": await _file.readAsBytes(),
        });
        print('finish!!');

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('contour', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
        });
        break;
    }

    return result;
  }

  static Future contourVals() async {
    final result = await platform.invokeMethod('contourVals');
    return result;
  }
}
