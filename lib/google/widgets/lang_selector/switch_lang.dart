import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class GoogleSwitchLang extends StatelessWidget {
  final setStateParent;
  final Future<String> Function(
      {required String input,
      required String fromLanguageValue,
      required String toLanguageValue}) translateParent;

  const GoogleSwitchLang({
    required this.setStateParent,
    required this.translateParent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          ),
          onPressed: () async {
            if (fromLanguage != AppLocalizations.of(context)!.autodetect) {
              if (googleTranslationInputController.text.isEmpty) {
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;

                session.write('to_language', toLanguage);
                session.write('from_language', fromLanguage);

                final valuetmp = fromLanguageValue;
                fromLanguageValue = toLanguageValue;
                toLanguageValue = valuetmp;
                setStateParent(() {});
              } else if (googleTranslationInputController.text.length <= 5000) {
                FocusScope.of(context).unfocus();
                setStateParent(() => loading = true);
                try {
                  final translatedText = await translateParent(
                      input: translationInput,
                      fromLanguageValue: fromLanguageValue,
                      toLanguageValue: toLanguageValue);

                  final tmp = fromLanguage;
                  fromLanguage = toLanguage;
                  toLanguage = tmp;

                  session.write('to_language', toLanguage);
                  session.write('from_language', fromLanguage);

                  final valuetmp = fromLanguageValue;
                  fromLanguageValue = toLanguageValue;
                  toLanguageValue = valuetmp;

                  final translatedText2;
                  if (translatedText.length <= 5000) {
                    translatedText2 = await translateParent(
                        input: translatedText,
                        fromLanguageValue: fromLanguageValue,
                        toLanguageValue: toLanguageValue);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        AppLocalizations.of(context)!.input_limit,
                        style: TextStyle(fontSize: 18),
                      ),
                    ));
                    translatedText2 = '';
                  }
                  setStateParent(() {
                    loading = false;
                    translationInput = translatedText;
                    googleTranslationInputController.text = translatedText;
                    googleTranslationOutput = translatedText2;
                  });
                } catch (_) {
                  final tmp = fromLanguage;
                  fromLanguage = toLanguage;
                  toLanguage = tmp;

                  session.write('to_language', toLanguage);
                  session.write('from_language', fromLanguage);

                  final valuetmp = fromLanguageValue;
                  fromLanguageValue = toLanguageValue;
                  toLanguageValue = valuetmp;
                  setStateParent(() {
                    loading = false;
                  });
                }
              } else {
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;

                session.write('to_language', toLanguage);
                session.write('from_language', fromLanguage);

                final valuetmp = fromLanguageValue;
                fromLanguageValue = toLanguageValue;
                toLanguageValue = valuetmp;
                setStateParent(() {});
              }
            }
          },
          child: Text(
            '<->',
            style: TextStyle(
                fontSize: 18,
                color: theme == Brightness.dark ? Colors.white : Colors.black),
          ),
        ),
      );
}
