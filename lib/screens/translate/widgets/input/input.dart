import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'tts_button.dart';
import '/data.dart';
import 'delete_button.dart';
import 'character_limit.dart';
import '/simplytranslate.dart' as simplytranslate;

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
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? const Color(0xff131618) : null,
        border: Border.all(
          color: theme == Brightness.dark ? const Color(0xff495057) : lightThemeGreyColor,
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              onTap: () => isFirst = true,
              textDirection: googleInCtrl.text.length == 0
                  ? intl.Bidi.detectRtlDirectionality(
                      i18n().langs.arabic,
                    )
                      ? TextDirection.rtl
                      : TextDirection.ltr
                  : intl.Bidi.detectRtlDirectionality(googleInCtrl.text)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              minLines: 7,
              maxLines: null,
              controller: googleInCtrl,
              keyboardType: TextInputType.multiline,
              onChanged: (String input) {
                Future.delayed(Duration(seconds: 1), () async {
                  isTranslationCanceled = true;
                  loading = false;
                  if (input == googleInCtrl.text) {
                    if (googleInCtrl.text.length > 0 && googleInCtrl.text.length <= 5000) {
                      isTranslationCanceled = false;
                      final translatedText = await simplytranslate.translate(googleInCtrl.text, fromLangVal, toLangVal);
                      if (!isTranslationCanceled) setStateOverlord(() => googleOutput = translatedText);
                    }
                  }
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: i18n().main.enter_text_here,
                hintTextDirection: intl.Bidi.detectRtlDirectionality(i18n().langs.arabic) ? TextDirection.rtl : TextDirection.ltr,
              ),
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Column(
            children: [
              DeleteTranslationInputButton(),
              TtsInput(),
              CharacterLimit(),
            ],
          )
        ],
      ),
    );
  }
}
