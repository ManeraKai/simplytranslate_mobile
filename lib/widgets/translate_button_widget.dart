import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

var renderBox;
var translateButtonWidgetSize;

class TranslateButton extends StatelessWidget {
  final setStateParent;
  final Future<String> Function(String, TranslateEngine) translateParent;
  final translateEngine;

  const TranslateButton(
      {Key? key,
      required this.setStateParent,
      required this.translateParent,
      required this.translateEngine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();
    return Column(
      children: [
        loading
            ? Container(
                alignment: Alignment.center,
                width: renderBox == null
                    ? 100
                    : translateButtonWidgetSize.width, // here
                height: 48,
                child: CircularProgressIndicator())
            : Container(
                key: key,
                decoration: theme == Brightness.dark
                    ? boxDecorationCustomDark
                    : boxDecorationCustomLight,
                height: 35,
                padding: const EdgeInsets.all(6.5),
                margin: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () async {
                    renderBox =
                        key.currentContext?.findRenderObject() as RenderBox;
                    translateButtonWidgetSize = renderBox.size;
                    FocusScope.of(context).unfocus();
                    setStateParent(() => loading = true);
                    final translatedText = await translateParent(
                        translationInput, translateEngine);
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
      ],
    );
  }
}
