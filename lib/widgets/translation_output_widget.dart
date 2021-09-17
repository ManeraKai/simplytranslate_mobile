import 'package:flutter/material.dart';
import 'package:simplytranslate/screens/maximized_screen.dart';
import '../data.dart';
import './copy_to_clipboard_button.dart';

class TranslationOutput extends StatefulWidget {
  const TranslationOutput({
    Key? key,
  }) : super(key: key);

  @override
  _TranslationOutputState createState() => _TranslationOutputState();
}

class _TranslationOutputState extends State<TranslationOutput> {
  double outputFontSize = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      decoration: boxDecorationCustom,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: SelectableText(
                    translationOutput,
                    style: TextStyle(fontSize: outputFontSize),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              CopyToClipboardButton(translationOutput),
              IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MaximizedScreen()));
                  },
                  icon: Icon(Icons.fullscreen)),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    outputFontSize += 3;
                  });
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: () {
                  setState(() {
                    outputFontSize -= 3;
                  });
                },
                icon: Icon(Icons.minimize),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
