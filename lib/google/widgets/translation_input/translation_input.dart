import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/google/widgets/translation_input/buttons/tts_input.dart';
import '/data.dart';
import 'buttons/copy_button.dart';
import 'buttons/delete_button.dart';
import 'buttons/paste_button.dart';
import 'buttons/character_limit.dart';

class GoogleTranslationInput extends StatefulWidget {
  const GoogleTranslationInput({Key? key}) : super(key: key);

  @override
  _TranslationInputState createState() => _TranslationInputState();
}

class _TranslationInputState extends State<GoogleTranslationInput> {
  @override
  void initState() {
    googleInCtrl.addListener(() async {
      final tmp = googleInCtrl.selection;
      if (!tmp.isCollapsed && isFirst) {
        print('selection');
        googleInCtrl.selection = TextSelection.fromPosition(tmp.base);
        await Future.delayed(const Duration(milliseconds: 50));
        googleInCtrl.selection = tmp;
        isFirst = false;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    googleInCtrl.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inTextFieldHeight = 10;
    for (var k in inList.keys)
      if (inList[k] == true) {
        if (k != "Counter")
          inTextFieldHeight += 48;
        else
          inTextFieldHeight += 50;
      }
    if (inTextFieldHeight < 100) inTextFieldHeight = 100;
    // print("inTextFieldHeight " + inTextFieldHeight.toString());
    return Container(
      height: inTextFieldHeight,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? const Color(0xff131618) : null,
        border: Border.all(
          color: theme == Brightness.dark
              ? const Color(0xff495057)
              : lightThemeGreyColor,
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: TextField(
                onTap: () => isFirst = true,
                textDirection: googleInCtrl.text.length == 0
                    ? intl.Bidi.detectRtlDirectionality(
                        L10n.of(context).arabic,
                      )
                        ? TextDirection.rtl
                        : TextDirection.ltr
                    : intl.Bidi.detectRtlDirectionality(googleInCtrl.text)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                focusNode: focus,
                minLines: 10,
                maxLines: null,
                controller: googleInCtrl,
                keyboardType: TextInputType.multiline,
                onChanged: (String input) {
                  if (googleInCtrl.text.length > 5000 && !isSnackBarVisible) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(seconds: 2),
                        width: 300,
                        content: Text(
                          L10n.of(context).input_limit,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                    isSnackBarVisible = true;
                  } else if (isSnackBarVisible) isSnackBarVisible = false;
                  setStateOverlord(() {});
                },
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: L10n.of(context).enter_text_here,
                  hintTextDirection:
                      intl.Bidi.detectRtlDirectionality(L10n.of(context).arabic)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                ),
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (inList['Remove'] == true) DeleteTranslationInputButton(),
              if (inList['Copy'] == true)
                CopyToClipboardButton(googleInCtrl.text),
              if (inList['Paste'] == true) PasteClipboardButton(),
              if (inList['Text-To-Speech'] == true) TtsInput(),
              if (inList['Counter'] == true) CharacterLimit(),
            ],
          )
        ],
      ),
    );
  }
}