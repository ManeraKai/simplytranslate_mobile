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
              : () {
                  Clipboard.getData(Clipboard.kTextPlain).then((value) async {
                    FocusScope.of(context).unfocus();

                    if (value != null && value.text.toString() != '') {
                      var valueString = value.text.toString();
                      if (googleInputController.text == '') {
                        FocusScope.of(context).requestFocus(focus);
                        setStateOverlordData(
                          () => googleInputController.text = valueString,
                        );
                      } else {
                        final beforePasteSelection =
                            googleInputController.selection.baseOffset;
                        var newText;
                        if (beforePasteSelection == -1)
                          newText = googleInputController.text + valueString;
                        else
                          newText = googleInputController.text.substring(
                                0,
                                beforePasteSelection,
                              ) +
                              valueString +
                              googleInputController.text.substring(
                                beforePasteSelection,
                                googleInputController.text.length,
                              );

                        await Future.delayed(const Duration(milliseconds: 1));
                        FocusScope.of(context).requestFocus(focus);

                        setStateOverlordData(() {
                          googleInputController.text = newText;
                          if (isKeyboardVisible)
                            googleInputController.selection =
                                TextSelection.collapsed(
                              offset: beforePasteSelection + valueString.length,
                            );
                          else
                            googleInputController.selection =
                                TextSelection.collapsed(
                              offset: googleInputController.text.length,
                            );
                        });
                      }
                      isFirst = true;
                    } else
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 1),
                          width: 160,
                          content: Text(
                            AppLocalizations.of(context)!.empty_clipboard,
                          ),
                        ),
                      );

                    if (googleInputController.text.length > 5000) {
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
