import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import '/data.dart';
import '../../screens/maximized/maximized.dart';
import '../translation_input/widgets/copy_button.dart';

class GoogleTranslationOutput extends StatefulWidget {
  const GoogleTranslationOutput({
    Key? key,
  }) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<GoogleTranslationOutput> {
  var _key;

  @override
  void initState() {
    _key = GlobalKey();
    super.initState();
  }

  bool isRTL = false;
  double outputFontSize = 20;

  @override
  Widget build(BuildContext context) {
    String translatedText = googleTranslationOutput;
    return Container(
      key: _key,
      height: 200,
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
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: AutoDirection(
                    text: translatedText,
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
              CopyToClipboardButton(translatedText),
              IconButton(
                  // color: theme == Brightness.dark ? null : greenColor,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: translatedText == ''
                      ? null
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaximizedScreen()));
                        },
                  icon: Icon(Icons.fullscreen)),
              IconButton(
                // color: theme == Brightness.dark ? null : greenColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () {
                        setState(() {
                          if (outputFontSize + 3 <= 90) outputFontSize += 3;
                        });
                      },
                icon: Icon(Icons.add),
              ),
              IconButton(
                // color: theme == Brightness.dark ? null : greenColor,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: translatedText == ''
                    ? null
                    : () {
                        setState(() {
                          if (outputFontSize - 3 >= 8) outputFontSize -= 3;
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
