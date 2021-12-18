import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

import 'package:path_provider/path_provider.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'dart:math';

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

          final Uint8List? grayByte = await Cv2.cvtColor(
            pathFrom: CVPathFrom.GALLERY_CAMERA,
            pathString: img.path,
            outputType: Cv2.COLOR_BGR2GRAY,
          );
          final gray = await byte2File(grayByte!);

          final thresh1Byte = await Cv2.threshold(
            pathFrom: CVPathFrom.GALLERY_CAMERA,
            pathString: gray.path,
            thresholdValue: 0,
            maxThresholdValue: 255,
            thresholdType: Cv2.THRESH_OTSU | Cv2.THRESH_BINARY_INV,
          );
          final thresh1 = await byte2File(thresh1Byte);

          var text = await FlutterTesseractOcr.extractText(
            thresh1.path,
            language: 'eng',
          );
          setStateOverlord(() => googleInCtrl.text = text);
          FocusScope.of(context).unfocus();
          try {
            final translatedText = await translate(
              input: googleInCtrl.text,
              fromLang: fromLangVal,
              toLang: toLangVal,
              context: contextOverlordData,
            );
            if (!isTranslationCanceled)
              setStateOverlord(() {
                googleOutput = translatedText;
                loading = false;
              });
          } catch (_) {
            setStateOverlord(() => loading = false);
          }
        }
      },
      icon: Icon(Icons.camera_alt),
    );
  }
}
