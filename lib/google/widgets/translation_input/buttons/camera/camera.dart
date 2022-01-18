import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/google/widgets/translation_input/buttons/camera/data.dart';

import '/data.dart';
import 'camera_screen.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    cameraFunc() async {
      cameras = await availableCameras();
      isTranslationCanceled = false;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CameraScreen()),
      );
    }

    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: fromLangVal == 'auto'
          ? null
          : downloadingList[fromLangVal] != TrainedDataState.Downloaded
              ? () async {
                  var _isNotCanceled = true;
                  var _isLangInstalling = false;
                  bool? result = await showDialog(
                    context: context,
                    builder: (contextDialog) {
                      return StatefulBuilder(
                        builder: (context, setStateAlert) {
                          return AlertDialog(
                            title: Text(
                              L10n.of(context)
                                  .language_text_recognition
                                  .replaceFirst('\$language',
                                      fromSelLangMap[fromLangVal]!),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  L10n.of(context)
                                      .trained_data_files_not_installed,
                                ),
                                SizedBox(height: _isLangInstalling ? 20 : 24),
                                if (_isLangInstalling)
                                  const LinearProgressIndicator(),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  cancelDownloadOCRLanguage(fromLangVal);
                                  Navigator.of(context).pop();
                                },
                                child:
                                    Text(L10n.of(context).cancel),
                              ),
                              TextButton(
                                onPressed: _isLangInstalling
                                    ? null
                                    : () async {
                                        setStateAlert(
                                            () => _isLangInstalling = true);
                                        var result = await downloadOCRLanguage(
                                            fromLangVal);
                                        if (result && _isNotCanceled) {
                                          Navigator.of(context).pop(true);
                                          cameraFunc();
                                        }
                                      },
                                child:
                                    Text(L10n.of(context).install),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                  if (result != true) {
                    cancelDownloadOCRLanguage(fromLangVal);
                    _isNotCanceled = false;
                  }
                }
              : cameraFunc,
      icon: Icon(Icons.camera_alt),
    );
  }
}
