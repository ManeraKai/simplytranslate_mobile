import 'package:flutter/material.dart';
import '/data.dart';
import '/simplytranslate.dart' as simplytranslate;

class GoogleSwitchLang extends StatelessWidget {
  const GoogleSwitchLang({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          ),
          onPressed: fromLangVal == 'auto'
              ? null
              : () async {
                  setStateOverlord(() {
                    isTtsInCanceled = true;
                    ttsOutloading = false;
                    isTtsOutputCanceled = true;
                    ttsInputloading = false;
                  });
                  if (googleInCtrl.text.isEmpty) {
                    switchVals();
                    setStateOverlord(() {});
                  } else if (googleInCtrl.text.length <= 5000) {
                    FocusScope.of(context).unfocus();
                    try {
                      final transInTmp = googleInCtrl.text;
                      final fromLangValTransTmp = fromLangVal;
                      final toLangValTransTmp = toLangVal;
                      switchVals();
                      final translatedText = await simplytranslate.translate(transInTmp, fromLangValTransTmp, toLangValTransTmp);
                      if (!isTranslationCanceled) {
                        final translatedText2;
                        if (translatedText.length <= 5000) {
                          translatedText2 = await simplytranslate.translate(translatedText['text'], fromLangVal, toLangVal);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              width: 160,
                              content: Text(
                                i18n().main.input_limit,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                          translatedText2 = '';
                        }
                        setStateOverlord(() {
                          googleInCtrl.text = translatedText['text'];
                          googleOutput = translatedText2;
                        });
                      }
                    } catch (error) {
                      setStateOverlord(() => loading = false);
                      print('translate error: $error');
                    }
                  } else {
                    switchVals();
                    setStateOverlord(() {});
                  }
                },
          child: Text(
            '<-->',
            style: TextStyle(
              fontSize: 18,
              color: fromLangVal != 'auto'
                  ? theme == Brightness.dark
                      ? Colors.white
                      : Colors.black
                  : lightThemeGreyColor,
            ),
          ),
        ),
      );
}
