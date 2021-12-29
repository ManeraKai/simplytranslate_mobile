/* 
 * Copyright (c) 2021 fgsoruco.
 * See LICENSE for more details.
 */
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:opencv_4/factory/pathfrom.dart';

///Class for process [Contrast]
class ContrastFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> contrast({
    required CVPathFrom pathFrom,
    required String pathString,
    required double alpha,
  }) async {
    int myType = 1;
    switch (pathFrom) {
      case CVPathFrom.GALLERY_CAMERA:
        myType = 1;
        break;
      case CVPathFrom.URL:
        myType = 2;
        break;
      case CVPathFrom.ASSETS:
        myType = 3;
        break;
    }

    Uint8List? result = await platform.invokeMethod(
      'contrast',
      {
        "pathType": myType,
        "pathString": pathString,
        "alpha": alpha,
      },
    );
    return result;
  }
}
