import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '/data.dart';
import '/google/screens/maximized/maximized.dart';
import '/google/widgets/translation_input/widgets/copy_button.dart';
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
    String translatedText = googleTranslationOutput;
    return Container(
      height: 350,
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
              child: Directionality(
                textDirection: intl.Bidi.detectRtlDirectionality(translatedText)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: SelectableText(
                  translatedText,
                  style: TextStyle(fontSize: _outputFontSize),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CopyToClipboardButton(translatedText),
              IconButton(
                icon: Icon(Icons.fullscreen),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaximizedScreen())),
              ),
              IconButton(
                icon: Icon(Icons.add),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => setState(() {
                          if (_outputFontSize + 3 <= 90) _outputFontSize += 3;
                        }),
              ),
              IconButton(
                icon: Icon(Icons.remove),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () => setState(() {
                          if (_outputFontSize - 3 >= 8) _outputFontSize -= 3;
                        }),
              ),
              TtsOutput(),
            ],
          ),
        ],
      ),
    );
  }
}
