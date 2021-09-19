import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate/screens/maximized_screen.dart';
import '../data.dart';
import './copy_to_clipboard_button.dart';

class TranslationOutput extends StatefulWidget {
  final translateEngine;
  const TranslationOutput({
    required this.translateEngine,
    Key? key,
  }) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<TranslationOutput> {
  bool isRTL = false;
  double outputFontSize = 20;

  @override
  Widget build(BuildContext context) {
    String translatedText =
        widget.translateEngine == TranslateEngine.GoogleTranslate
            ? googleTranslationOutput
            : libreTranslationOutput;
    return Container(
      height: 200,
      decoration: theme == Brightness.dark
          ? boxDecorationCustomDark
          : boxDecorationCustomLight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: AutoDirection(
                    text: widget.translateEngine ==
                            TranslateEngine.GoogleTranslate
                        ? googleTranslationOutput
                        : libreTranslationOutput,
                    onDirectionChange: (isRTL) {
                      setState(() {
                        this.isRTL = isRTL;
                      });
                    },
                    child: SelectableText(
                      translatedText,
                      style: TextStyle(fontSize: outputFontSize),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CopyToClipboardButton(
                  widget.translateEngine == TranslateEngine.GoogleTranslate
                      ? googleTranslationOutput
                      : libreTranslationOutput),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: translatedText == ''
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaximizedScreen(
                                        translateEngine: widget.translateEngine,
                                      )));
                        },
                  icon: Icon(Icons.fullscreen)),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () {
                        setState(() {
                          outputFontSize += 3;
                        });
                      },
                icon: Icon(Icons.add),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () {
                        setState(() {
                          outputFontSize -= 3;
                        });
                      },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
