import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class GoogleSwitchLang extends StatelessWidget {
  final setStateParent;
  final Future<String> Function(String) translateParent;

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
              if (googleTranslationInputController.text.length <= 5000) {
                FocusScope.of(context).unfocus();
                setStateParent(() => loading = true);

                final translatedText = await translateParent(translationInput);
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;

                session.write('to_language', toLanguage);
                session.write('from_language', fromLanguage);

                final valuetmp = fromLanguageValue;
                fromLanguageValue = toLanguageValue;
                toLanguageValue = valuetmp;

                final x = await translateParent(translatedText);

                setStateParent(() {
                  loading = false;
                  translationInput = translatedText;
                  googleTranslationInputController.text = translatedText;
                  googleTranslationOutput = x;
                });
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
