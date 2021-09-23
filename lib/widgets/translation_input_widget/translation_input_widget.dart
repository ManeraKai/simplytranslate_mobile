import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../text_tool_widgets/copy_to_clipboard_button.dart';
import '../text_tool_widgets/delete_translation_input_button.dart';
import '../../data.dart';
import '../text_tool_widgets/paste_clipboard_button.dart';
import 'character_limit_widget.dart';

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
      height: 205,
      decoration: theme == Brightness.dark
          ? boxDecorationCustomDark
          : boxDecorationCustomLightBlack,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AutoDirection(
                text: translationInput,
                onDirectionChange: (isRTL) {
                  setState(() {
                    this.isRTL = isRTL;
                  });
                },
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowGlow();
                    return false;
                  },
                  child: Scrollbar(
                    child: TextField(
                      focusNode: focus,
                      minLines: 8,
                      maxLines: null,
                      controller: translationInputController,
                      keyboardType: TextInputType.multiline,
                      onTap: () {
                        widget
                            .setStateParent(() => translationInputOpen = true);
                      },
                      onChanged: (String input) async {
                        widget.setStateParent(() {
                          translationInputOpen = true;
                          translationLength =
                              translationInputController.text.length;
                          translationInput = input;
                        });
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: theme == Brightness.dark
                                  ? lightgreyColor
                                  : Color(0xffa9a9a9)),
                          hintText:
                              AppLocalizations.of(context)!.enter_text_here),
                      style: TextStyle(fontSize: 20),
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
                CharacterLimit(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
