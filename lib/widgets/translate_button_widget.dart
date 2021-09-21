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
                height: 38,
                child: CircularProgressIndicator())
            : Container(
                key: key,
                decoration: theme == Brightness.dark
                    ? boxDecorationCustomDark
                    : translationInputController.text != ''
                        ? boxDecorationCustomLight.copyWith(
                            color: Color(0xff3fb274),
                            border: Border.all(
                                width: 1.5, color: Colors.transparent),
                          )
                        : boxDecorationCustomLight.copyWith(
                            color: Color(
                              0xffa9a9a9,
                            ),
                            border: Border.all(
                                width: 1.5, color: Colors.transparent),
                          ),
                height: 35,
                padding: const EdgeInsets.all(6.5),
                child: GestureDetector(
                  onTap: translationInputController.text == ''
                      ? null
                      : () async {
                          renderBox = key.currentContext?.findRenderObject()
                              as RenderBox;
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
                    style: TextStyle(
                        fontSize: 18,
                        color: theme == Brightness.dark ? null : Colors.white),
                  ),
                ),
              ),
      ],
    );
  }
}
