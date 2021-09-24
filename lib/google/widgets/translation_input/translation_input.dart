import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'widgets/copy_button.dart';
import 'widgets/delete_button.dart';
import 'widgets/paste_button.dart';
import 'widgets/character_limit.dart';
import '/data.dart';

class GoogleTranslationInput extends StatefulWidget {
  final setStateParent;
  final Future<String> Function(
      {required String input,
      required String fromLanguageValue,
      required String toLanguageValue}) translateParent;
  const GoogleTranslationInput({
    required this.setStateParent,
    required this.translateParent,
    Key? key,
  }) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<GoogleTranslationInput> {
  var _key;

  @override
  void initState() {
    _key = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      height: 205,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
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
                  controller: googleTranslationInputController,
                  keyboardType: TextInputType.multiline,
                  onTap: () {
                    widget.setStateParent(() => translationInputOpen = true);
                  },
                  onChanged: (String input) {
                    if (googleTranslationInputController.text.length > 99999) {
                      final tmpSelection;
                      if (googleTranslationInputController
                              .selection.baseOffset >=
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
                    }
                    widget.setStateParent(() {
                      translationInputOpen = true;
                      translationInput = input;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.enter_text_here),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DeleteTranslationInputButton(
                  setStateParent: widget.setStateParent,
                  setStateParentParent: widget.setStateParent),
              CopyToClipboardButton(translationInput),
              PasteClipboardButton(setStateParent: widget.setStateParent),
              CharacterLimit(),
            ],
          )
        ],
      ),
    );
  }
}
