import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';

import '/data.dart';
import '/google/widgets/translation_input/widgets/camera_screen.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
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
            await ImagePicker().pickImage(source: ImageSource.camera);
        if (pickedImageX != null) {
          var img = File(pickedImageX.path);
          final List<Uint8List?> croppedImgs = await Cv2.contour(
            pathFrom: CVPathFrom.GALLERY_CAMERA,
            pathString: img.path,
          );

          final contourVals = await Cv2.contourVals();

          List<String> textList = [];
          List<File> croppedImgsProcessed = [];
          List<Map<String, int>> filteredContourVals = [];

          for (var i = 0; i < croppedImgs.length; i++) {
            final contour = contourVals[i];
            final croppedImg = await byte2File(croppedImgs[i]!);
            final preparedImg = await prepareOCR(croppedImg);

            var text = await FlutterTesseractOcr.extractText(
              preparedImg.path,
              language: 'tur',
            );
            if (text.trim() != "") {
              textList.add(text);
              croppedImgsProcessed.add(preparedImg);
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
                contourVals: filteredContourVals,
                croppedImgs: croppedImgsProcessed,
                textList: textList,
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
