import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
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
        onPressed: googleInputController.text == ''
            ? null
            : googleInputController.text.length <= 5000
                ? () async {
                    FocusScope.of(context).unfocus();
                    isTranslationCanceled = false;
                    setStateOverlordData(() => loading = true);
                    try {
                      final translatedText = await translate(
                        input: googleInputController.text,
                        fromLanguageValue: fromLanguageValue,
                        toLanguageValue: toLanguageValue,
                        context: contextOverlordData,
                      );
                      if (!isTranslationCanceled)
                        setStateOverlordData(() {
                          googleOutput = translatedText;
                          loading = false;
                        });
                    } catch (_) {
                      setStateOverlordData(() => loading = false);
                    }
                  }
                : null,
        child: Text(
          AppLocalizations.of(context)!.translate,
          style: TextStyle(
            fontSize: 18,
            color: theme == Brightness.dark
                ? null
                : googleInputController.text == ''
                    ? lightThemeGreyColor
                    : Colors.white,
          ),
        ),
      ),
    );
  }
}
