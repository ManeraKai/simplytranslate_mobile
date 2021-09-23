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
  final Future<String> Function(String) translateParent;
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
      decoration: theme == Brightness.dark
          ? boxDecorationCustomDark
          : boxDecorationCustomLightBlack,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      widget.setStateParent(() {
                        translationInputOpen = true;
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
