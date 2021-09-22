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
        color: theme == Brightness.dark ? null : greenColor,
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
                  googleTranslationOutput = '';
                  libreTranslationOutput = '';
                  translationLength = 0;
                });
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
