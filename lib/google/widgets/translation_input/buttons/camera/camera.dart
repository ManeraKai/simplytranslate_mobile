import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
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
      print("Checking");

      var cameraStatus = await Permission.camera.request();
      if (cameraStatus.isGranted) {
        print("Granted");
        cameras = await availableCameras();
        print(cameras);
        isTranslationCanceled = false;
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CameraScreen()),
        );
      } else if (cameraStatus.isPermanentlyDenied) {
        print("NotGranted");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(L10n.of(context).camera_is_not_accessible),
            action: SnackBarAction(
              label: "Open in Settings",
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    }

    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: fromLangVal == 'auto'
          ? () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(L10n.of(context).autodetect_not_supported),
                    content: Text(L10n.of(context).please_select_a_specific_language),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(L10n.of(context).ok),
                      )
                    ],
                  );
                },
              );
            }
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
                                child: Text(L10n.of(context).cancel),
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
                                child: Text(L10n.of(context).install),
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
      color: fromLangVal == 'auto'
          ? theme == Brightness.dark
              ? darkThemedisabledColor
              : lightThemedisabledColor
          : null,
    );
  }
}
