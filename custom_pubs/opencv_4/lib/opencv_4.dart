import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:opencv_4/factory/colormaps/applycolormap_factory.dart';
import 'package:opencv_4/factory/colorspace/cvtcolor_factory.dart';
import 'package:opencv_4/factory/imagefilter/bilateralfilter_factory.dart';
import 'package:opencv_4/factory/imagefilter/blur_factory.dart';
import 'package:opencv_4/factory/imagefilter/boxfilter_factory.dart';
import 'package:opencv_4/factory/imagefilter/dilate_factory.dart';
import 'package:opencv_4/factory/imagefilter/erode_factory.dart';
import 'package:opencv_4/factory/imagefilter/filter2d_factory.dart';
import 'package:opencv_4/factory/imagefilter/gaussianblur_factoy.dart';
import 'package:opencv_4/factory/imagefilter/laplacian_factory.dart';
import 'package:opencv_4/factory/imagefilter/medianblur_factory.dart';
import 'package:opencv_4/factory/imagefilter/morphologyex_factory.dart';
import 'package:opencv_4/factory/imagefilter/pyrmeanshiftfiltering_factory.dart';
import 'package:opencv_4/factory/imagefilter/scharr_factory.dart';
import 'package:opencv_4/factory/imagefilter/sobel_factory.dart';
import 'package:opencv_4/factory/imagefilter/sqrboxfilter_factory.dart';
import 'package:opencv_4/factory/miscellaneoustransform/adaptivethreshold_factory.dart';
import 'package:opencv_4/factory/miscellaneoustransform/distancetransform_factory.dart';
import 'package:opencv_4/factory/miscellaneoustransform/threshold_factory.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/factory/prepare_ocr/prepare_ocr_factory.dart';

import 'factory/contrast/contrast_factory.dart';

/// class that contains the implementation of OpenCV modules
class Cv2 {
  /// Constants util for [borderType] params
  static const int BORDER_CONSTANT = 0,
      BORDER_REPLICATE = 1,
      BORDER_REFLECT = 2,
      BORDER_WRAP = 3,
      BORDER_REFLECT_101 = 4,
      BORDER_TRANSPARENT = 5,
      BORDER_REFLECT101 = BORDER_REFLECT_101,
      BORDER_DEFAULT = BORDER_REFLECT_101,
      BORDER_ISOLATED = 16;

  ///Constants util for [MorphologyEx]
  static const int MORPH_ERODE = 0,
      MORPH_DILATE = 1,
      MORPH_OPEN = 2,
      MORPH_CLOSE = 3,
      MORPH_GRADIENT = 4,
      MORPH_TOPHAT = 5,
      MORPH_BLACKHAT = 6,
      MORPH_HITMISS = 7;

  static const int CV_GAUSSIAN_5x5 = 7, CV_SCHARR = -1, CV_MAX_SOBEL_KSIZE = 7;

  ///Constants util for [cvtColor]
  static const int COLOR_BGR2BGRA = 0,
      COLOR_RGB2RGBA = COLOR_BGR2BGRA,
      COLOR_BGRA2BGR = 1,
      COLOR_RGBA2RGB = COLOR_BGRA2BGR,
      COLOR_BGR2RGBA = 2,
      COLOR_RGB2BGRA = COLOR_BGR2RGBA,
      COLOR_RGBA2BGR = 3,
      COLOR_BGRA2RGB = COLOR_RGBA2BGR,
      COLOR_BGR2RGB = 4,
      COLOR_RGB2BGR = COLOR_BGR2RGB,
      COLOR_BGRA2RGBA = 5,
      COLOR_RGBA2BGRA = COLOR_BGRA2RGBA,
      COLOR_BGR2GRAY = 6,
      COLOR_RGB2GRAY = 7,
      COLOR_GRAY2BGR = 8,
      COLOR_GRAY2RGB = COLOR_GRAY2BGR,
      COLOR_GRAY2BGRA = 9,
      COLOR_GRAY2RGBA = COLOR_GRAY2BGRA,
      COLOR_BGRA2GRAY = 10,
      COLOR_RGBA2GRAY = 11,
      COLOR_BGR2BGR565 = 12,
      COLOR_RGB2BGR565 = 13,
      COLOR_BGR5652BGR = 14,
      COLOR_BGR5652RGB = 15,
      COLOR_BGRA2BGR565 = 16,
      COLOR_RGBA2BGR565 = 17,
      COLOR_BGR5652BGRA = 18,
      COLOR_BGR5652RGBA = 19,
      COLOR_GRAY2BGR565 = 20,
      COLOR_BGR5652GRAY = 21,
      COLOR_BGR2BGR555 = 22,
      COLOR_RGB2BGR555 = 23,
      COLOR_BGR5552BGR = 24,
      COLOR_BGR5552RGB = 25,
      COLOR_BGRA2BGR555 = 26,
      COLOR_RGBA2BGR555 = 27,
      COLOR_BGR5552BGRA = 28,
      COLOR_BGR5552RGBA = 29,
      COLOR_GRAY2BGR555 = 30,
      COLOR_BGR5552GRAY = 31,
      COLOR_BGR2XYZ = 32,
      COLOR_RGB2XYZ = 33,
      COLOR_XYZ2BGR = 34,
      COLOR_XYZ2RGB = 35,
      COLOR_BGR2YCrCb = 36,
      COLOR_RGB2YCrCb = 37,
      COLOR_YCrCb2BGR = 38,
      COLOR_YCrCb2RGB = 39,
      COLOR_BGR2HSV = 40,
      COLOR_RGB2HSV = 41,
      COLOR_BGR2Lab = 44,
      COLOR_RGB2Lab = 45,
      COLOR_BGR2Luv = 50,
      COLOR_RGB2Luv = 51,
      COLOR_BGR2HLS = 52,
      COLOR_RGB2HLS = 53,
      COLOR_HSV2BGR = 54,
      COLOR_HSV2RGB = 55,
      COLOR_Lab2BGR = 56,
      COLOR_Lab2RGB = 57,
      COLOR_Luv2BGR = 58,
      COLOR_Luv2RGB = 59,
      COLOR_HLS2BGR = 60,
      COLOR_HLS2RGB = 61,
      COLOR_BGR2HSV_FULL = 66,
      COLOR_RGB2HSV_FULL = 67,
      COLOR_BGR2HLS_FULL = 68,
      COLOR_RGB2HLS_FULL = 69,
      COLOR_HSV2BGR_FULL = 70,
      COLOR_HSV2RGB_FULL = 71,
      COLOR_HLS2BGR_FULL = 72,
      COLOR_HLS2RGB_FULL = 73,
      COLOR_LBGR2Lab = 74,
      COLOR_LRGB2Lab = 75,
      COLOR_LBGR2Luv = 76,
      COLOR_LRGB2Luv = 77,
      COLOR_Lab2LBGR = 78,
      COLOR_Lab2LRGB = 79,
      COLOR_Luv2LBGR = 80,
      COLOR_Luv2LRGB = 81,
      COLOR_BGR2YUV = 82,
      COLOR_RGB2YUV = 83,
      COLOR_YUV2BGR = 84,
      COLOR_YUV2RGB = 85,
      COLOR_YUV2RGB_NV12 = 90,
      COLOR_YUV2BGR_NV12 = 91,
      COLOR_YUV2RGB_NV21 = 92,
      COLOR_YUV2BGR_NV21 = 93,
      COLOR_YUV420sp2RGB = COLOR_YUV2RGB_NV21,
      COLOR_YUV420sp2BGR = COLOR_YUV2BGR_NV21,
      COLOR_YUV2RGBA_NV12 = 94,
      COLOR_YUV2BGRA_NV12 = 95,
      COLOR_YUV2RGBA_NV21 = 96,
      COLOR_YUV2BGRA_NV21 = 97,
      COLOR_YUV420sp2RGBA = COLOR_YUV2RGBA_NV21,
      COLOR_YUV420sp2BGRA = COLOR_YUV2BGRA_NV21,
      COLOR_YUV2RGB_YV12 = 98,
      COLOR_YUV2BGR_YV12 = 99,
      COLOR_YUV2RGB_IYUV = 100,
      COLOR_YUV2BGR_IYUV = 101,
      COLOR_YUV2RGB_I420 = COLOR_YUV2RGB_IYUV,
      COLOR_YUV2BGR_I420 = COLOR_YUV2BGR_IYUV,
      COLOR_YUV420p2RGB = COLOR_YUV2RGB_YV12,
      COLOR_YUV420p2BGR = COLOR_YUV2BGR_YV12,
      COLOR_YUV2RGBA_YV12 = 102,
      COLOR_YUV2BGRA_YV12 = 103,
      COLOR_YUV2RGBA_IYUV = 104,
      COLOR_YUV2BGRA_IYUV = 105,
      COLOR_YUV2RGBA_I420 = COLOR_YUV2RGBA_IYUV,
      COLOR_YUV2BGRA_I420 = COLOR_YUV2BGRA_IYUV,
      COLOR_YUV420p2RGBA = COLOR_YUV2RGBA_YV12,
      COLOR_YUV420p2BGRA = COLOR_YUV2BGRA_YV12,
      COLOR_YUV2GRAY_420 = 106,
      COLOR_YUV2GRAY_NV21 = COLOR_YUV2GRAY_420,
      COLOR_YUV2GRAY_NV12 = COLOR_YUV2GRAY_420,
      COLOR_YUV2GRAY_YV12 = COLOR_YUV2GRAY_420,
      COLOR_YUV2GRAY_IYUV = COLOR_YUV2GRAY_420,
      COLOR_YUV2GRAY_I420 = COLOR_YUV2GRAY_420,
      COLOR_YUV420sp2GRAY = COLOR_YUV2GRAY_420,
      COLOR_YUV420p2GRAY = COLOR_YUV2GRAY_420,
      COLOR_YUV2RGB_UYVY = 107,
      COLOR_YUV2BGR_UYVY = 108,
      COLOR_YUV2RGB_Y422 = COLOR_YUV2RGB_UYVY,
      COLOR_YUV2BGR_Y422 = COLOR_YUV2BGR_UYVY,
      COLOR_YUV2RGB_UYNV = COLOR_YUV2RGB_UYVY,
      COLOR_YUV2BGR_UYNV = COLOR_YUV2BGR_UYVY,
      COLOR_YUV2RGBA_UYVY = 111,
      COLOR_YUV2BGRA_UYVY = 112,
      COLOR_YUV2RGBA_Y422 = COLOR_YUV2RGBA_UYVY,
      COLOR_YUV2BGRA_Y422 = COLOR_YUV2BGRA_UYVY,
      COLOR_YUV2RGBA_UYNV = COLOR_YUV2RGBA_UYVY,
      COLOR_YUV2BGRA_UYNV = COLOR_YUV2BGRA_UYVY,
      COLOR_YUV2RGB_YUY2 = 115,
      COLOR_YUV2BGR_YUY2 = 116,
      COLOR_YUV2RGB_YVYU = 117,
      COLOR_YUV2BGR_YVYU = 118,
      COLOR_YUV2RGB_YUYV = COLOR_YUV2RGB_YUY2,
      COLOR_YUV2BGR_YUYV = COLOR_YUV2BGR_YUY2,
      COLOR_YUV2RGB_YUNV = COLOR_YUV2RGB_YUY2,
      COLOR_YUV2BGR_YUNV = COLOR_YUV2BGR_YUY2,
      COLOR_YUV2RGBA_YUY2 = 119,
      COLOR_YUV2BGRA_YUY2 = 120,
      COLOR_YUV2RGBA_YVYU = 121,
      COLOR_YUV2BGRA_YVYU = 122,
      COLOR_YUV2RGBA_YUYV = COLOR_YUV2RGBA_YUY2,
      COLOR_YUV2BGRA_YUYV = COLOR_YUV2BGRA_YUY2,
      COLOR_YUV2RGBA_YUNV = COLOR_YUV2RGBA_YUY2,
      COLOR_YUV2BGRA_YUNV = COLOR_YUV2BGRA_YUY2,
      COLOR_YUV2GRAY_UYVY = 123,
      COLOR_YUV2GRAY_YUY2 = 124,
      COLOR_YUV2GRAY_Y422 = COLOR_YUV2GRAY_UYVY,
      COLOR_YUV2GRAY_UYNV = COLOR_YUV2GRAY_UYVY,
      COLOR_YUV2GRAY_YVYU = COLOR_YUV2GRAY_YUY2,
      COLOR_YUV2GRAY_YUYV = COLOR_YUV2GRAY_YUY2,
      COLOR_YUV2GRAY_YUNV = COLOR_YUV2GRAY_YUY2,
      COLOR_RGBA2mRGBA = 125,
      COLOR_mRGBA2RGBA = 126,
      COLOR_RGB2YUV_I420 = 127,
      COLOR_BGR2YUV_I420 = 128,
      COLOR_RGB2YUV_IYUV = COLOR_RGB2YUV_I420,
      COLOR_BGR2YUV_IYUV = COLOR_BGR2YUV_I420,
      COLOR_RGBA2YUV_I420 = 129,
      COLOR_BGRA2YUV_I420 = 130,
      COLOR_RGBA2YUV_IYUV = COLOR_RGBA2YUV_I420,
      COLOR_BGRA2YUV_IYUV = COLOR_BGRA2YUV_I420,
      COLOR_RGB2YUV_YV12 = 131,
      COLOR_BGR2YUV_YV12 = 132,
      COLOR_RGBA2YUV_YV12 = 133,
      COLOR_BGRA2YUV_YV12 = 134,
      COLOR_BayerBG2BGR = 46,
      COLOR_BayerGB2BGR = 47,
      COLOR_BayerRG2BGR = 48,
      COLOR_BayerGR2BGR = 49,
      COLOR_BayerBG2RGB = COLOR_BayerRG2BGR,
      COLOR_BayerGB2RGB = COLOR_BayerGR2BGR,
      COLOR_BayerRG2RGB = COLOR_BayerBG2BGR,
      COLOR_BayerGR2RGB = COLOR_BayerGB2BGR,
      COLOR_BayerBG2GRAY = 86,
      COLOR_BayerGB2GRAY = 87,
      COLOR_BayerRG2GRAY = 88,
      COLOR_BayerGR2GRAY = 89,
      COLOR_BayerBG2BGR_VNG = 62,
      COLOR_BayerGB2BGR_VNG = 63,
      COLOR_BayerRG2BGR_VNG = 64,
      COLOR_BayerGR2BGR_VNG = 65,
      COLOR_BayerBG2RGB_VNG = COLOR_BayerRG2BGR_VNG,
      COLOR_BayerGB2RGB_VNG = COLOR_BayerGR2BGR_VNG,
      COLOR_BayerRG2RGB_VNG = COLOR_BayerBG2BGR_VNG,
      COLOR_BayerGR2RGB_VNG = COLOR_BayerGB2BGR_VNG,
      COLOR_BayerBG2BGR_EA = 135,
      COLOR_BayerGB2BGR_EA = 136,
      COLOR_BayerRG2BGR_EA = 137,
      COLOR_BayerGR2BGR_EA = 138,
      COLOR_BayerBG2RGB_EA = COLOR_BayerRG2BGR_EA,
      COLOR_BayerGB2RGB_EA = COLOR_BayerGR2BGR_EA,
      COLOR_BayerRG2RGB_EA = COLOR_BayerBG2BGR_EA,
      COLOR_BayerGR2RGB_EA = COLOR_BayerGB2BGR_EA,
      COLOR_BayerBG2BGRA = 139,
      COLOR_BayerGB2BGRA = 140,
      COLOR_BayerRG2BGRA = 141,
      COLOR_BayerGR2BGRA = 142,
      COLOR_BayerBG2RGBA = COLOR_BayerRG2BGRA,
      COLOR_BayerGB2RGBA = COLOR_BayerGR2BGRA,
      COLOR_BayerRG2RGBA = COLOR_BayerBG2BGRA,
      COLOR_BayerGR2RGBA = COLOR_BayerGB2BGRA,
      COLOR_COLORCVT_MAX = 143;

  ///Constants util for [applyColorMap]
  static const int COLORMAP_AUTUMN = 0,
      COLORMAP_BONE = 1,
      COLORMAP_JET = 2,
      COLORMAP_WINTER = 3,
      COLORMAP_RAINBOW = 4,
      COLORMAP_OCEAN = 5,
      COLORMAP_SUMMER = 6,
      COLORMAP_SPRING = 7,
      COLORMAP_COOL = 8,
      COLORMAP_HSV = 9,
      COLORMAP_PINK = 10,
      COLORMAP_HOT = 11,
      COLORMAP_PARULA = 12,
      COLORMAP_MAGMA = 13,
      COLORMAP_INFERNO = 14,
      COLORMAP_PLASMA = 15,
      COLORMAP_VIRIDIS = 16,
      COLORMAP_CIVIDIS = 17,
      COLORMAP_TWILIGHT = 18,
      COLORMAP_TWILIGHT_SHIFTED = 19,
      COLORMAP_TURBO = 20,
      COLORMAP_DEEPGREEN = 21;

  ///Constants util for [threshold]
  static const int THRESH_BINARY = 0,
      THRESH_BINARY_INV = 1,
      THRESH_TRUNC = 2,
      THRESH_TOZERO = 3,
      THRESH_TOZERO_INV = 4,
      THRESH_MASK = 7,
      THRESH_OTSU = 8,
      THRESH_TRIANGLE = 16;

  ///Constants util for [DistanceTransform]
  static const int DIST_USER = -1,
      DIST_L1 = 1,
      DIST_L2 = 2,
      DIST_C = 3,
      DIST_L12 = 4,
      DIST_FAIR = 5,
      DIST_WELSCH = 6,
      DIST_HUBER = 7;

  ///Constants util for [AdaptiveThreshold]
  static const int ADAPTIVE_THRESH_MEAN_C = 0, ADAPTIVE_THRESH_GAUSSIAN_C = 1;

  static const platform = const MethodChannel('opencv_4');

  /// [version] function that returns the OpenCV version
  static Future<String?> version() async {
    String? version;
    try {
      version = await platform.invokeMethod('getVersion');
    } on PlatformException catch (e) {
      version = "Fallo la llamada al metodo: '${e.message}'.";
    }
    return version;
  }

  /// [bilateralFilter] function of Module: Image Filtering
  static Future<Uint8List?> bilateralFilter({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int diameter,
    required int sigmaColor,
    required int sigmaSpace,
    required int borderType,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await BilateralFilterFactory.bilateralFilter(
      pathFrom: pathFrom,
      pathString: pathString,
      diameter: diameter,
      sigmaColor: sigmaColor,
      sigmaSpace: sigmaSpace,
      borderType: borderType,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [blur] function of Module: Image Filtering
  static Future<Uint8List?> blur({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required List<double> kernelSize,
    required List<double> anchorPoint,
    required int borderType,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await BlurFactory.blur(
      pathFrom: pathFrom,
      pathString: pathString,
      kernelSize: kernelSize,
      anchorPoint: anchorPoint,
      borderType: borderType,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [boxFilter] function of Module: Image Filtering
  static Future<Uint8List?> boxFilter({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int outputDepth,
    required List<double> kernelSize,
    required List<double> anchorPoint,
    required bool normalize,
    required int borderType,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await BoxFilterFactory.boxFilter(
      pathFrom: pathFrom,
      pathString: pathString,
      outputDepth: outputDepth,
      kernelSize: kernelSize,
      anchorPoint: anchorPoint,
      normalize: normalize,
      borderType: borderType,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [dilate] function of Module: Image Filtering
  static Future<Uint8List?> dilate({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required List<double> kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await DilateFactory.dilate(
      pathFrom: pathFrom,
      pathString: pathString,
      kernelSize: kernelSize,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [erode] function of Module: Image Filtering
  static Future<Uint8List?> erode({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required List<double> kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await ErodeFactory.erode(
      pathFrom: pathFrom,
      pathString: pathString,
      kernelSize: kernelSize,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [filter2D] function of Module: Image Filtering
  static Future<Uint8List?> filter2D({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int outputDepth,
    required List<int> kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await Filter2DFactory.filter2D(
        pathFrom: pathFrom,
        pathString: pathString,
        outputDepth: outputDepth,
        kernelSize: kernelSize);

    /// Function returns the response from method channel
    return result;
  }

  /// [gaussianBlur] function of Module: Image Filtering
  static Future<Uint8List?> gaussianBlur({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required List<double> kernelSize,
    required double sigmaX,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await GaussianBlurFactory.gaussianBlur(
      pathFrom: pathFrom,
      pathString: pathString,
      kernelSize: kernelSize,
      sigmaX: sigmaX,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [laplacian] function of Module: Image Filtering
  static Future<Uint8List?> laplacian({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int depth,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await LaplacianFactory.laplacian(
      pathFrom: pathFrom,
      pathString: pathString,
      depth: depth,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [medianBlur] function of Module: Image Filtering
  static Future<Uint8List?> medianBlur({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await MedianBlurFactory.medianBlur(
      pathFrom: pathFrom,
      pathString: pathString,
      kernelSize: kernelSize,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [morphologyEx] function of Module: Image Filtering
  static Future<Uint8List?> morphologyEx({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int operation,
    required List<int> kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await MorphologyExFactory.morphologyEx(
      pathFrom: pathFrom,
      pathString: pathString,
      operation: operation,
      kernelSize: kernelSize,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [pyrMeanShiftFiltering] function of Module: Image Filtering
  static Future<Uint8List?> pyrMeanShiftFiltering({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required double spatialWindowRadius,
    required double colorWindowRadius,
  }) async {
    /// Variable to store operation result
    final Uint8List? result =
        await PyrMeanShiftFilteringFactory.pyrMeanShiftFiltering(
            pathFrom: pathFrom,
            pathString: pathString,
            spatialWindowRadius: spatialWindowRadius,
            colorWindowRadius: colorWindowRadius);

    /// Function returns the response from method channel
    return result;
  }

  /// [scharr] function of Module: Image Filtering
  static Future<Uint8List?> scharr({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int depth,
    required int dx,
    required int dy,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await ScharrFactory.scharr(
      pathFrom: pathFrom,
      pathString: pathString,
      depth: depth,
      dx: dx,
      dy: dy,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [sobel] function of Module: Image Filtering
  static Future<Uint8List?> sobel({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int depth,
    required int dx,
    required int dy,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await SobelFactory.sobel(
      pathFrom: pathFrom,
      pathString: pathString,
      depth: depth,
      dx: dx,
      dy: dy,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [sobel] function of Module: Image Filtering
  static Future<Uint8List?> sqrBoxFilter({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int outputDepth,
    required List<double> kernelSize,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await SqrBoxFilterFactory.sqrBoxFilter(
        pathFrom: pathFrom,
        pathString: pathString,
        outputDepth: outputDepth,
        kernelSize: kernelSize);

    /// Function returns the response from method channel
    return result;
  }

  /// [adaptiveThreshold] function of Module: Miscellaneous Image Transformations
  static Future<dynamic> adaptiveThreshold({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required double maxValue,
    required int adaptiveMethod,
    required int thresholdType,
    required int blockSize,
    required double constantValue,
  }) async {
    /// Variable to store operation result
    final dynamic result = await AdaptiveThresholdFactory.adaptiveThreshold(
      pathFrom: pathFrom,
      pathString: pathString,
      maxValue: maxValue,
      adaptiveMethod: adaptiveMethod,
      thresholdType: thresholdType,
      blockSize: blockSize,
      constantValue: constantValue,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [distanceTransform] function of Module: Miscellaneous Image Transformations
  static Future<dynamic> distanceTransform({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int distanceType,
    required int maskSize,
  }) async {
    /// Variable to store operation result
    final dynamic result = await DistanceTransformFactory.distanceTransform(
        pathFrom: pathFrom,
        pathString: pathString,
        distanceType: distanceType,
        maskSize: maskSize);

    /// Function returns the response from method channel
    return result;
  }

  /// [distanceTransform] function of Module: Miscellaneous Image Transformations
  static Future<dynamic> threshold({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required double thresholdValue,
    required double maxThresholdValue,
    required int thresholdType,
  }) async {
    /// Variable to store operation result
    final dynamic result = await ThresholdFactory.threshold(
      pathFrom: pathFrom,
      pathString: pathString,
      thresholdValue: thresholdValue,
      maxThresholdValue: maxThresholdValue,
      thresholdType: thresholdType,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [cvtColor] function of Module: Color Space Conversions
  static Future<Uint8List?> cvtColor({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int outputType,
  }) async {
    final Uint8List? result = await CvtColorFactory.cvtColor(
      pathFrom: pathFrom,
      pathString: pathString,
      outputType: outputType,
    );

    /// Function returns the response from method channel
    return result;
  }

  /// [contour] function of Module: Color Space Conversions
  static Future<List<Uint8List?>> contour({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
  }) async {
    var result = await platform.invokeMethod(
      'contour',
      {"pathString": pathString},
    );
    return List<Uint8List?>.from(result);
  }

  static Future<List<Map<String, int>>> contourVals() async {
    final List vals = await platform.invokeMethod('contourVals');

    List<Map<String, int>> resultList = [];
    vals.forEach((x) => resultList.add(Map<String, int>.from(x)));

    return resultList;
  }

  /// [contrast] Change Contrast
  static Future<Uint8List?> contrast({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required double alpha,
  }) async {
    final Uint8List? result = await ContrastFactory.contrast(
      pathFrom: pathFrom,
      pathString: pathString,
      alpha: alpha,
    );
    return result;
  }

  static Future<Uint8List?> prepareOCR({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
  }) async {
    final Uint8List? result = await PrepareOCRFactory.prepareOCR(
      pathString: pathString,
    );
    return result;
  }

  /// [applyColorMap] function of Module: Color Maps
  static Future<Uint8List?> applyColorMap({
    CVPathFrom pathFrom = CVPathFrom.ASSETS,
    required String pathString,
    required int colorMap,
  }) async {
    /// Variable to store operation result
    final Uint8List? result = await ApplyColorMapFactory.applyColorMap(
      pathFrom: pathFrom,
      pathString: pathString,
      colorMap: colorMap,
    );

    /// Function returns the response from method channel
    return result;
  }
}
