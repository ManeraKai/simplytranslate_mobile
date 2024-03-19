import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '/data.dart';
import 'copy_button.dart';
import 'tts_button.dart';

class GoogleTranslationOutput extends StatefulWidget {
  const GoogleTranslationOutput({Key? key}) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<GoogleTranslationOutput> {
  double _outputFontSize = 20;

  @override
  Widget build(BuildContext context) {
    Map translatedText = googleOutput;
    return Container(
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? Color(0xff131618) : null,
        border: Border.all(
          color: theme == Brightness.dark ? Color(0xff495057) : Color(0xffa9a9a9),
          width: 1.5,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Scrollbar(
                child: Directionality(
                  textDirection: translatedText.containsKey('text')
                      ? intl.Bidi.detectRtlDirectionality(translatedText['text'])
                          ? TextDirection.rtl
                          : TextDirection.ltr
                      : TextDirection.rtl,
                  child: SelectableText(
                    translatedText.containsKey('text') ? translatedText['text'] : '',
                    style: TextStyle(fontSize: _outputFontSize),
                    minLines: 7,
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CopyToClipboardButton(translatedText['text'] ?? ''),
              TtsOutput(),
            ],
          ),
        ],
      ),
    );
  }
}
