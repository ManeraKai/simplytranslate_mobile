import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplytranslate/widgets/keyboard_visibility_widget.dart';
import '../../data.dart';

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
                      if (translationInputController.text == '') {
                        await Future.delayed(
                            const Duration(milliseconds: 1), () => "1");
                        FocusScope.of(context).requestFocus(focus);
                        setStateParent(() {
                          translationInput = valueString;
                          translationInputController.text = valueString;
                        });
                      } else {
                        final beforePasteSelection =
                            translationInputController.selection.baseOffset;
                        final newText;
                        if (beforePasteSelection == -1)
                          newText =
                              translationInputController.text + valueString;
                        else
                          newText = translationInputController.text
                                  .substring(0, beforePasteSelection) +
                              valueString +
                              translationInputController.text.substring(
                                  beforePasteSelection,
                                  translationInputController.text.length);

                        await Future.delayed(
                            const Duration(milliseconds: 1), () => "1");
                        FocusScope.of(context).requestFocus(focus);

                        setStateParent(() {
                          translationInput = newText;
                          translationInputController.text = newText;
                          if (isKeyboardVisible) {
                            translationInputController.selection =
                                TextSelection.collapsed(
                                    offset: beforePasteSelection +
                                        valueString.length);
                          } else {
                            translationInputController.selection =
                                TextSelection.collapsed(
                                    offset:
                                        translationInputController.text.length);
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
