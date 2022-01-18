import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';

class TranslateButtonFloat extends StatelessWidget {
  const TranslateButtonFloat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(5),
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: googleInCtrl.text == ''
            ? null
            : googleInCtrl.text.length <= 5000
                ? () async {
                    FocusScope.of(context).unfocus();
                    isTranslationCanceled = false;
                    setStateOverlord(() => loading = true);
                    try {
                      final translatedText = await translate(
                        input: googleInCtrl.text,
                        fromLang: fromLangVal,
                        toLang: toLangVal,
                        context: contextOverlordData,
                      );
                      if (!isTranslationCanceled)
                        setStateOverlord(() {
                          googleOutput = translatedText;
                          loading = false;
                        });
                    } catch (_) {
                      setStateOverlord(() => loading = false);
                    }
                  }
                : null,
        child: Text(
          L10n.of(context).translate,
          style: TextStyle(
            fontSize: 18,
            color: theme == Brightness.dark
                ? null
                : googleInCtrl.text == ''
                    ? lightThemeGreyColor
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
