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

///Class for process [AdaptiveThreshol]
class AdaptiveThresholdFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> adaptiveThreshold({
    required CVPathFrom pathFrom,
    required String pathString,
    required double maxValue,
    required int adaptiveMethod,
    required int thresholdType,
    required int blockSize,
    required double constantValue,
  }) async {
    File _file;
    Uint8List _fileAssets;

    Uint8List? result;
    int adaptiveMethodTemp = (adaptiveMethod > 1)
        ? 1
        : (adaptiveMethod < 0)
            ? 0
            : adaptiveMethod;

    int thresholdTypeTemp = (thresholdType > 1)
        ? 1
        : (thresholdType < 0)
            ? 0
            : thresholdType;

    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 1,
          "pathString": pathString,
          "data": Uint8List(0),
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethodTemp,
          'thresholdType': thresholdTypeTemp,
          'blockSize': blockSize,
          'constantValue': constantValue,
        });
        break;
      case CVPathFrom.URL:
        _file = await DefaultCacheManager().getSingleFile(pathString);
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 2,
          "pathString": '',
          "data": await _file.readAsBytes(),
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethodTemp,
          'thresholdType': thresholdTypeTemp,
          'blockSize': blockSize,
          'constantValue': constantValue
        });

        break;
      case CVPathFrom.ASSETS:
        _fileAssets = await Utils.imgAssets2Uint8List(pathString);
        result = await platform.invokeMethod('adaptiveThreshold', {
          "pathType": 3,
          "pathString": '',
          "data": _fileAssets,
          'maxValue': maxValue,
          'adaptiveMethod': adaptiveMethodTemp,
          'thresholdType': thresholdTypeTemp,
          'blockSize': blockSize,
          'constantValue': constantValue
        });
        break;
    }

    return result;
  }
}
