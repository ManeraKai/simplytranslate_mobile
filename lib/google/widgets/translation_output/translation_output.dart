import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' as intl;
import '/data.dart';
import '/google/screens/maximized/maximized.dart';
import '/google/widgets/translation_input/buttons/copy_button.dart';
import 'widgets/tts_output.dart';

class GoogleTranslationOutput extends StatefulWidget {
  const GoogleTranslationOutput({Key? key}) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<GoogleTranslationOutput> {
  double _outputFontSize = 20;

  @override
  Widget build(BuildContext context) {
    outTextFieldHeight = 10;
    for (var k in outList.keys)
      if (outList[k] == true) {
        if (k != "Counter")
          outTextFieldHeight += 48;
        else
          outTextFieldHeight += 50;
      }
    if (outTextFieldHeight < 100) outTextFieldHeight = 100;
    Map translatedText = googleOutput;
    return Container(
      height: outTextFieldHeight,
      decoration: BoxDecoration(
        color: theme == Brightness.dark ? Color(0xff131618) : null,
        border: Border.all(
          color:
              theme == Brightness.dark ? Color(0xff495057) : Color(0xffa9a9a9),
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
                  textDirection: translatedText.containsKey('translated-text')
                      ? intl.Bidi.detectRtlDirectionality(
                              translatedText['translated-text'])
                          ? TextDirection.rtl
                          : TextDirection.ltr
                      : TextDirection.rtl,
                  child: SelectableText(
                    translatedText.containsKey('translated-text')
                        ? translatedText['translated-text']
                        : '',
                    style: TextStyle(fontSize: _outputFontSize),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              if (outList['Copy'] == true)
                CopyToClipboardButton(translatedText['translated-text'] ?? ''),
              if (outList['Maximize'] == true)
                IconButton(
                  icon: Icon(Icons.fullscreen),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: translatedText['translated-text'] == null
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MaximizedScreen())),
                ),
              if (outList['Text-To-Speech'] == true) TtsOutput(),
            ],
          ),
        ],
      ),
    );
  }
}