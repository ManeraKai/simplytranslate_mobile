/* 
 * Copyright (c) 2021 fgsoruco.
 * See LICENSE for more details.
 */
import 'dart:typed_data';
import 'package:flutter/services.dart';

///class with useful methods
class Utils {
  static Future<Uint8List> imgAssets2Uint8List(String path) async {
    final byteData = await rootBundle.load('$path');
    Uint8List resp = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return resp;
  }

  static List<double> verKernelSize(List<double> kernelSize) {
    List<double> respuesta = [1, 1];

    (kernelSize[0] <= 0) ? respuesta[0] = 1 : respuesta[0] = kernelSize[0];

    (kernelSize[1] <= 0) ? respuesta[1] = 1 : respuesta[1] = kernelSize[1];

    return respuesta;
  }

  static List<int> verKernelSizeInt(List<int> kernelSize) {
    List<int> respuesta = [1, 1];

    (kernelSize[0] <= 0) ? respuesta[0] = 1 : respuesta[0] = kernelSize[0];

    (kernelSize[1] <= 0) ? respuesta[1] = 1 : respuesta[1] = kernelSize[1];

    return respuesta;
  }

  static int verBorderType(int borderType) {
    return (borderType <= 0)
        ? 0
        : (borderType <= 5)
            ? borderType
            : 16;
  }
}
