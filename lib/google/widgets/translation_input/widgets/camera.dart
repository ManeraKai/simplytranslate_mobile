import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

import 'package:path_provider/path_provider.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'dart:math';

import 'package:simplytranslate_mobile/google/widgets/translation_input/widgets/camera_screen.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

Future<File> byte2File(Uint8List byte) async {
  final tempDir = await getTemporaryDirectory();
  final random = Random().nextInt;
  final file = await new File('${tempDir.path}/$random.jpg').create();
  file.writeAsBytesSync(byte);
  return file;
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: () async {
        setStateOverlord(() => loading = true);
        isTranslationCanceled = false;
        final pickedImageX =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (pickedImageX != null) {
          final img = File(pickedImageX.path);

          final List<Uint8List?> croppedImgs = await Cv2.contour(
            pathFrom: CVPathFrom.GALLERY_CAMERA,
            pathString: img.path,
          );

          final contourVals = await Cv2.contourVals();

          List<Map<String, int>> filteredContourVals = [];

          for (var i = 0; i < croppedImgs.length; i++) {
            final contour = contourVals[i];
            final croppedImg = await byte2File(croppedImgs[i]!);

            final Uint8List? grayByte = await Cv2.cvtColor(
              pathFrom: CVPathFrom.GALLERY_CAMERA,
              pathString: croppedImg.path,
              outputType: Cv2.COLOR_RGB2GRAY,
            );
            final gray = await byte2File(grayByte!);

            final Uint8List? dilateByte = await Cv2.dilate(
              pathFrom: CVPathFrom.GALLERY_CAMERA,
              pathString: gray.path,
              kernelSize: [1, 1],
            );

            final dilate = await byte2File(dilateByte!);

            final Uint8List? thresh1Byte = await Cv2.threshold(
              pathFrom: CVPathFrom.GALLERY_CAMERA,
              pathString: dilate.path,
              thresholdValue: 0,
              maxThresholdValue: 255,
              thresholdType: Cv2.THRESH_BINARY | Cv2.THRESH_OTSU,
            );

            final thresh1 = await byte2File(thresh1Byte!);

            var text = await FlutterTesseractOcr.extractText(
              thresh1.path,
              language: 'tur',
            );
            if (text.trim() != "") {
              textList.add(text);
              filteredContourVals.add(contour);
            }
          }
          FocusScope.of(context).unfocus();
          if (!isTranslationCanceled) setStateOverlord(() => loading = false);
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CameraScreen(
                image: img,
                contourVals: contourVals,
              ),
            ),
          );
          setStateOverlord(() => loading = true);
          final translatedText = await translate(
            input: googleInCtrl.text,
            fromLang: fromLangVal,
            toLang: toLangVal,
            context: context,
          );
          setStateOverlord(() {
            googleOutput = translatedText;
            loading = false;
          });
        }
      },
      icon: Icon(Icons.camera_alt),
    );
  }
}


// final thresh1Byte = await Cv2.adaptiveThreshold(
//     pathFrom: CVPathFrom.GALLERY_CAMERA,
//     pathString: dilate.path,
//     maxValue: 255,
//     adaptiveMethod: Cv2.ADAPTIVE_THRESH_MEAN_C,
//     thresholdType: Cv2.THRESH_BINARY,
//     blockSize: 15,
//     constantValue: 40);
