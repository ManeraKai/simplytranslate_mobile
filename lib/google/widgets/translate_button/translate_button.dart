import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

// var renderBox;
// var translateButtonWidgetSize;

class GoogleTranslateButton extends StatelessWidget {
  const GoogleTranslateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: googleTranslationInputController.text == ''
          ? null
          : googleTranslationInputController.text.length <= 5000
              ? () async {
                  FocusScope.of(context).unfocus();
                  isTranslationCanceled = false;
                  setStateOverlordData(() => loading = true);
                  try {
                    final translatedText = await translate(
                      input: translationInput,
                      fromLanguageValue: fromLanguageValue,
                      toLanguageValue: toLanguageValue,
                      context: contextOverlordData,
                    );
                    if (!isTranslationCanceled) {
                      setStateOverlordData(() {
                        googleTranslationOutput = translatedText;
                        loading = false;
                      });
                    }
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
              : googleTranslationInputController.text == ''
                  ? lightThemeGreyColor
                  : Colors.white,
        ),
      ),
    );
  }
}
