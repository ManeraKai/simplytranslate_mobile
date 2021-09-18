import 'package:flutter/material.dart';
import '../data.dart';

class DeleteTranslationInputButton extends StatelessWidget {
  final setStateParent;
  final setStateParentParent;
  final translateEngine;
  const DeleteTranslationInputButton({
    required this.setStateParent,
    required this.setStateParentParent,
    required this.translateEngine,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: translationInputController.text == '' &&
                (translateEngine == TranslateEngine.GoogleTranslate
                        ? googleTranslationOutput
                        : libreTranslationOutput) ==
                    ''
            ? null
            : () {
                setStateParentParent(() {
                  translationInputController.text = '';
                  translationInput = '';
                  translateEngine == TranslateEngine.GoogleTranslate
                      ? googleTranslationOutput = ''
                      : libreTranslationOutput = '';
                });
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
