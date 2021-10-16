import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/widgets/keyboard_visibility.dart';
import '/data.dart';

class PasteClipboardButton extends StatefulWidget {
  final changeText;
  const PasteClipboardButton({
    this.changeText,
    Key? key,
  }) : super(key: key);

  @override
  State<PasteClipboardButton> createState() => _PasteClipboardButtonState();
}

class _PasteClipboardButtonState extends State<PasteClipboardButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: KeyboardVisibilityBuilder(
        builder: (context, _, isKeyboardVisible) => IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: isClipboardEmpty
              ? null
              : googleTranslationInputController.text.length >= 99999
                  ? null
                  : () {
                      Clipboard.getData(Clipboard.kTextPlain)
                          .then((value) async {
                        FocusScope.of(context).unfocus();

                        if (value != null) {
                          var valueString = value.text.toString();

                          if (valueString != '') {
                            if (valueString.length > 99999) {
                              valueString = valueString.substring(1, 100000);
                            }
                            if (googleTranslationInputController.text == '') {
                              await Future.delayed(
                                  const Duration(milliseconds: 1), () => "1");
                              FocusScope.of(context).requestFocus(focus);
                              setStateOverlordData(() {
                                googleTranslationInputController.text =
                                    valueString;
                              });
                            } else if (googleTranslationInputController
                                    .text.length <
                                99999) {
                              final beforePasteSelection =
                                  googleTranslationInputController
                                      .selection.baseOffset;
                              var newText;
                              if (beforePasteSelection == -1) {
                                newText =
                                    googleTranslationInputController.text +
                                        valueString;
                                if (newText.length >= 99999) {
                                  newText = newText.substring(1, 100000);
                                }
                              } else {
                                newText = googleTranslationInputController.text
                                        .substring(0, beforePasteSelection) +
                                    valueString +
                                    googleTranslationInputController.text
                                        .substring(
                                            beforePasteSelection,
                                            googleTranslationInputController
                                                .text.length);
                                if (newText.length >= 99999) {
                                  newText = newText.substring(1, 100000);
                                }
                              }

                              await Future.delayed(
                                  const Duration(milliseconds: 1), () => "1");
                              FocusScope.of(context).requestFocus(focus);

                              setStateOverlordData(() {
                                googleTranslationInputController.text = newText;
                                if (isKeyboardVisible) {
                                  if (beforePasteSelection +
                                          valueString.length >=
                                      99999) {
                                  } else {
                                    googleTranslationInputController.selection =
                                        TextSelection.collapsed(
                                            offset: beforePasteSelection +
                                                valueString.length);
                                  }
                                } else {
                                  googleTranslationInputController.selection =
                                      TextSelection.collapsed(
                                          offset:
                                              googleTranslationInputController
                                                  .text.length);
                                }
                              });
                            }
                            isFirst = true;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                width: 160,
                                content: Text(
                                  AppLocalizations.of(context)!.empty_clipboard,
                                ),
                              ),
                            );
                          }
                        } else
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              width: 160,
                              content: Text(
                                AppLocalizations.of(context)!.empty_clipboard,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );

                        if (googleTranslationInputController.text.length >
                            5000) {
                          if (!isSnackBarVisible) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 1),
                                width: 300,
                                content: Text(
                                  AppLocalizations.of(context)!.input_limit,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                            isSnackBarVisible = true;
                          }
                        } else
                          isSnackBarVisible = false;
                      });
                    },
          icon: Icon(Icons.paste),
        ),
      ),
    );
  }
}
