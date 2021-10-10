import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class GoogleSwitchLang extends StatelessWidget {
  final setStateParent;

  const GoogleSwitchLang({
    required this.setStateParent,
    Key? key,
  }) : super(key: key);

  switchLangsWithCookies() {
    final tmp = fromLanguage;
    fromLanguage = toLanguage;
    toLanguage = tmp;

    final valuetmp = fromLanguageValue;
    fromLanguageValue = toLanguageValue;
    toLanguageValue = valuetmp;

    session.write('to_language', toLanguageValue);
    session.write('from_language', fromLanguageValue);
  }

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          ),
          onPressed: () async {
            if (fromLanguage != AppLocalizations.of(context)!.autodetect) {
              setStateParent(() {
                isTtsInputCanceled = true;
                ttsOutputloading = false;
                isTtsOutputCanceled = true;
                ttsInputloading = false;
              });
              if (googleTranslationInputController.text.isEmpty) {
                switchLangsWithCookies();
                setStateParent(() {});
              } else if (googleTranslationInputController.text.length <= 5000) {
                FocusScope.of(context).unfocus();
                setStateParent(() => loading = true);
                try {
                  final translationInputTransTmp = translationInput;
                  final fromLanguageValueTransTmp = fromLanguageValue;
                  final toLanguageValueTransTmp = toLanguageValue;
                  switchLangsWithCookies();
                  final translatedText = await translate(
                    input: translationInputTransTmp,
                    fromLanguageValue: fromLanguageValueTransTmp,
                    toLanguageValue: toLanguageValueTransTmp,
                    context: context,
                  );
                  if (!isTranslationCanceled) {
                    final translatedText2;
                    if (translatedText.length <= 5000) {
                      translatedText2 = await translate(
                        input: translatedText,
                        fromLanguageValue: fromLanguageValue,
                        toLanguageValue: toLanguageValue,
                        context: context,
                      );
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
                  }
                } catch (error) {
                  setStateParent(() => loading = false);
                  print('translate error: $error');
                }
              } else {
                switchLangsWithCookies();
                setStateParent(() {});
              }
            }
          },
          child: Text(
            '<->',
            style: TextStyle(
              fontSize: 18,
              color: theme == Brightness.dark ? Colors.white : Colors.black,
            ),
          ),
        ),
      );
}
