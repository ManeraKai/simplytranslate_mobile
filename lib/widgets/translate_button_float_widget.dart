import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class TranslateButtonFloat extends StatelessWidget {
  final setStateParent;
  final Future<String> Function(String, TranslateEngine) translateParent;
  final translateEngine;

  const TranslateButtonFloat(
      {Key? key,
      required this.setStateParent,
      required this.translateParent,
      required this.translateEngine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme == Brightness.dark ? lightgreyColor : Colors.black,
      height: 50,
      padding: EdgeInsets.all(5),
      alignment: Alignment.topRight,
      child: Container(
        decoration: theme == Brightness.dark
            ? boxDecorationCustomDark.copyWith()
            : boxDecorationCustomLight.copyWith(),
        height: 35,
        padding: const EdgeInsets.all(6.5),
        // margin: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();
            setStateParent(() => loading = true);
            final translatedText =
                await translateParent(translationInput, translateEngine);
            setStateParent(() {
              translateEngine == TranslateEngine.GoogleTranslate
                  ? googleTranslationOutput = translatedText
                  : libreTranslationOutput = translatedText;
              loading = false;
            });
          },
          child: Text(
            AppLocalizations.of(context)!.translate,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
