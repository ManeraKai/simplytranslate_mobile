import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate_mobile/google/widgets/translate_button/translate_button_float.dart';
import '/google/widgets/translation_input/widgets/tts_input.dart';
import '/data.dart';
import 'widgets/copy_button.dart';
import 'widgets/delete_button.dart';
import 'widgets/paste_button.dart';
import 'widgets/character_limit.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class GoogleTranslationInput extends StatefulWidget {
  const GoogleTranslationInput({
    Key? key,
  }) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<GoogleTranslationInput> {
  final FocusNode _nodeText2 = FocusNode();

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.transparent,
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText2,
          toolbarButtons: [
            //button 2
            (node) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => node.unfocus(),
                    child: TranslateButtonFloat(),
                  ),
                ],
              );
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? Color(0xff131618) : null,
        border: Border.all(
          color:
              theme == Brightness.dark ? Color(0xff495057) : Color(0xffa9a9a9),
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: KeyboardActions(
        disableScroll: true,
        config: _buildConfig(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                textDirection: googleTranslationInputController.text.length == 0
                    ? intl.Bidi.detectRtlDirectionality(
                        AppLocalizations.of(context)!.arabic,
                      )
                        ? TextDirection.rtl
                        : TextDirection.ltr
                    : intl.Bidi.detectRtlDirectionality(translationInput)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                focusNode: _nodeText2,
                minLines: 10,
                maxLines: null,
                controller: googleTranslationInputController,
                keyboardType: TextInputType.multiline,
                onTap: () =>
                    setStateOverlordData(() => translationInputOpen = true),
                onChanged: (String input) {
                  if (googleTranslationInputController.text.length > 99999) {
                    final tmpSelection;
                    if (googleTranslationInputController.selection.baseOffset >=
                        100000) {
                      tmpSelection = TextSelection.collapsed(offset: 99999);
                    } else {
                      tmpSelection = TextSelection.collapsed(
                          offset: googleTranslationInputController
                              .selection.baseOffset);
                    }

                    googleTranslationInputController.text =
                        googleTranslationInputController.text
                            .substring(0, 99999);
                    print(tmpSelection.baseOffset);

                    googleTranslationInputController.selection = tmpSelection;
                  } else if (googleTranslationInputController.text.length >
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
                  } else {
                    if (isSnackBarVisible) isSnackBarVisible = false;
                  }
                  setStateOverlordData(() {
                    translationInputOpen = true;
                    translationInput = input;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.enter_text_here,
                  hintTextDirection: intl.Bidi.detectRtlDirectionality(
                          AppLocalizations.of(context)!.arabic)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DeleteTranslationInputButton(),
                CopyToClipboardButton(translationInput),
                PasteClipboardButton(),
                TtsInput(),
                CharacterLimit(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
