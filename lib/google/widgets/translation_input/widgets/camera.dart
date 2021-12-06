import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:image_editor/image_editor.dart' as editor;
import 'package:image_picker/image_picker.dart';
import 'package:simplytranslate_mobile/data.dart';

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
          final pickedImage = File(pickedImageX.path);
          final editorOption = editor.ImageEditorOption();

          editorOption.addOptions([
            editor.ColorOption.contrast(1.5),
            editor.ColorOption.saturation(0),
          ]);

          final finalImage = await editor.ImageEditor.editFileImageAndGetFile(
            file: pickedImage,
            imageEditorOption: editorOption,
          );

          var text = await FlutterTesseractOcr.extractText(finalImage!.path,
              language: 'eng');
          setStateOverlord(() {
            googleInCtrl.text = text;
          });
        }

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
      },
      icon: Icon(Icons.camera_alt),
    );
  }
}
