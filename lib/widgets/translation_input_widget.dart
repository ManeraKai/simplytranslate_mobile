import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate/widgets/copy_to_clipboard_button.dart';
import 'package:simplytranslate/widgets/delete_translation_input_button.dart';
import '../data.dart';
import './paste_clipboard_button.dart';

class TranslationInput extends StatefulWidget {
  final setStateParent;
  final Future<String> Function(String, TranslateEngine) translateParent;
  final translateEngine;
  const TranslationInput({
    required this.setStateParent,
    required this.translateParent,
    required this.translateEngine,
    Key? key,
  }) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<TranslationInput> {
  @override
  void initState() {
    super.initState();
  }

  bool isRTL = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: theme == Brightness.dark
          ? boxDecorationCustomDark
          : boxDecorationCustomLight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoDirection(
                    text: translationInput,
                    onDirectionChange: (isRTL) {
                      setState(() {
                        this.isRTL = isRTL;
                      });
                    },
                    child: TextField(
                      minLines: 7,
                      maxLines: 10,
                      controller: translationInputController,
                      keyboardType: TextInputType.text,
                      onChanged: (String input) async {
                        setState(() {
                          translationInput = input;
                        });
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: lightgreyColor),
                          hintText:
                              AppLocalizations.of(context)!.enter_text_here),
                      style: const TextStyle(fontSize: 20),
                      onEditingComplete: () async {
                        FocusScope.of(context).unfocus();
                        widget.setStateParent(() => loading = true);
                        final translatedText = await widget.translateParent(
                            translationInput, widget.translateEngine);
                        widget.setStateParent(() {
                          widget.translateEngine ==
                                  TranslateEngine.GoogleTranslate
                              ? googleTranslationOutput = translatedText
                              : libreTranslationOutput = translatedText;

                          loading = false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                DeleteTranslationInputButton(
                    setStateParent: setState,
                    setStateParentParent: widget.setStateParent,
                    translateEngine: widget.translateEngine),
                CopyToClipboardButton(translationInput),
                PasteClipboardButton(setStateParent: setState),
              ],
            ),
          )
        ],
      ),
    );
  }
}
