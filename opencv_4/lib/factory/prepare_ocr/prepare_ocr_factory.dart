/* 
 * Copyright (c) 2021 fgsoruco.
 * See LICENSE for more details.
 */
import 'dart:typed_data';

import 'package:flutter/services.dart';

///Class for process [prepareOCR]
class PrepareOCRFactory {
  static const platform = const MethodChannel('opencv_4');

  static Future<Uint8List?> prepareOCR({
    required String pathString,
  }) async {
    Uint8List? result = await platform.invokeMethod(
      'prepareOCR',
      {
        "pathString": pathString,
      },
    );
    return result;
  }
}
