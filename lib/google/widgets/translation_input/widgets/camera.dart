import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';
import 'package:simplytranslate_mobile/google/widgets/translation_input/widgets/camera_screen.dart';

import '/data.dart';
import 'text_recognition_screen.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    cameraFunc() async {
      setStateOverlord(() => loading = true);
      isTranslationCanceled = false;
      XFile? pickedImageX = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CameraScreen(),
        ),
      );
      setStateOverlord(() => loading = false);
      if (pickedImageX != null) {
        var img = File(pickedImageX.path);
        final croppedImgs = await Cv2.contour(
          pathFrom: CVPathFrom.GALLERY_CAMERA,
          pathString: img.path,
        );
        final contourVals = await Cv2.contourVals();
        List<String> textList = [];
        List<File> croppedImgsProcessedList = [];
        List<Map<String, int>> filteredContourValsList = [];

        for (var i = 0; i < croppedImgs.length; i++) {
          final contour = contourVals[i];
          final croppedImg = await byte2File(croppedImgs[i]!);
          final preparedImg = await prepareOCR(croppedImg);
          final String text = await FlutterTesseractOcr.extractText(
            preparedImg.path,
            language: two2three[fromLangVal],
          );
          if (text.trim() != "") {
            textList.add(text);
            croppedImgsProcessedList.add(preparedImg);
            filteredContourValsList.add(contour);
          }
        }
        try {
          FocusScope.of(context).unfocus();
        } catch (err) {}
        if (!isTranslationCanceled) setStateOverlord(() => loading = false);
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TextRecognitionScreen(
              image: img,
              contourVals: filteredContourValsList,
              croppedImgs: croppedImgsProcessedList,
              textList: textList,
            ),
          ),
        );
      }
    }

    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: fromLangVal == 'auto'
          ? null
          : !downloadedList.contains(fromLangVal)
              ? () {
                  showDialog(
                    context: context,
                    builder: (contextDialog) {
                      var downloadLoading = false;
                      return StatefulBuilder(
                        builder: (context, setStateAlert) {
                          return AlertDialog(
                            title: Text(
                                "${fromSelLangMap[fromLangVal]!} Text Recognition"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Trained data files aren't installed."),
                                SizedBox(height: downloadLoading ? 20 : 24),
                                if (downloadLoading)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: downloadLoading
                                    ? null
                                    : () async {
                                        downloadedList.add(fromLangVal);
                                        setStateAlert(
                                            () => downloadLoading = true);
                                        bool result = await downloadOCRLanguage(
                                            two2three[fromLangVal]);
                                        if (result) {
                                          setStateAlert(
                                              () => downloadLoading = false);
                                          setStateOverlord(() {});
                                          Navigator.of(context).pop();
                                          cameraFunc();
                                        }
                                      },
                                child: Text("Install"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                }
              : () => cameraFunc(),
      icon: Icon(Icons.camera_alt),
    );
  }
}
