import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplytranslate/widgets/keyboard_visibility.dart';
import '/data.dart';

class PasteClipboardButton extends StatelessWidget {
  final changeText;
  final setStateParent;
  const PasteClipboardButton({
    required this.setStateParent,
    this.changeText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: KeyboardVisibilityBuilder(
        builder: (context, _, isKeyboardVisible) => IconButton(
          color: theme == Brightness.dark ? null : greenColor,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: isClipboardEmpty == true
              ? null
              : () {
                  Clipboard.getData(Clipboard.kTextPlain).then((value) async {
                    FocusScope.of(context).unfocus();

                    if (value != null) {
                      final valueString = value.text.toString();
                      if (googleTranslationInputController.text == '') {
                        await Future.delayed(
                            const Duration(milliseconds: 1), () => "1");
                        FocusScope.of(context).requestFocus(focus);
                        setStateParent(() {
                          translationInput = valueString;
                          googleTranslationInputController.text = valueString;
                          translationInputOpen = true;
                        });
                      } else {
                        final beforePasteSelection =
                            googleTranslationInputController
                                .selection.baseOffset;
                        final newText;
                        if (beforePasteSelection == -1)
                          newText = googleTranslationInputController.text +
                              valueString;
                        else
                          newText = googleTranslationInputController.text
                                  .substring(0, beforePasteSelection) +
                              valueString +
                              googleTranslationInputController.text.substring(
                                  beforePasteSelection,
                                  googleTranslationInputController.text.length);

                        await Future.delayed(
                            const Duration(milliseconds: 1), () => "1");
                        FocusScope.of(context).requestFocus(focus);

                        setStateParent(() {
                          translationInput = newText;
                          googleTranslationInputController.text = newText;
                          if (isKeyboardVisible) {
                            googleTranslationInputController.selection =
                                TextSelection.collapsed(
                                    offset: beforePasteSelection +
                                        valueString.length);
                          } else {
                            googleTranslationInputController.selection =
                                TextSelection.collapsed(
                                    offset: googleTranslationInputController
                                        .text.length);
                          }
                        });
                      }
                    }
                  });
                },
          icon: Icon(Icons.paste),
        ),
      ),
    );
  }
}
