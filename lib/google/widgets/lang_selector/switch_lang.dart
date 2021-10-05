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
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          ),
          onPressed: () async {
            if (fromLanguage != AppLocalizations.of(context)!.autodetect) {
              if (googleTranslationInputController.text.isEmpty) {
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;

                final valuetmp = fromLanguageValue;
                fromLanguageValue = toLanguageValue;
                toLanguageValue = valuetmp;

                session.write('to_language', toLanguageValue);
                session.write('from_language', fromLanguageValue);

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

                  final valuetmp = fromLanguageValue;
                  fromLanguageValue = toLanguageValue;
                  toLanguageValue = valuetmp;

                  session.write('to_language', toLanguageValue);
                  session.write('from_language', fromLanguageValue);

                  final translatedText2;
                  if (translatedText.length <= 5000) {
                    translatedText2 = await translateParent(
                        input: translatedText,
                        fromLanguageValue: fromLanguageValue,
                        toLanguageValue: toLanguageValue);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        width: 160,
                        content: Text(
                          AppLocalizations.of(context)!.input_limit,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
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

                  final valuetmp = fromLanguageValue;
                  fromLanguageValue = toLanguageValue;
                  toLanguageValue = valuetmp;

                  session.write('to_language', toLanguageValue);
                  session.write('from_language', fromLanguageValue);

                  setStateParent(() {
                    loading = false;
                  });
                }
              } else {
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;

                final valuetmp = fromLanguageValue;
                fromLanguageValue = toLanguageValue;
                toLanguageValue = valuetmp;

                session.write('to_language', toLanguageValue);
                session.write('from_language', fromLanguageValue);

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
