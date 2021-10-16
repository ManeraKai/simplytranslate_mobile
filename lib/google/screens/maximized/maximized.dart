import 'package:flutter/material.dart';
import './widgets/tts_output.dart';
import '/data.dart';
import '/google/widgets/translation_input/widgets/copy_button.dart';

class MaximizedScreen extends StatefulWidget {
  const MaximizedScreen({
    Key? key,
  }) : super(key: key);

  @override
  _MaximizedScreenState createState() => _MaximizedScreenState();
}

class _MaximizedScreenState extends State<MaximizedScreen> {
  double outputFontSize = 20;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: theme == Brightness.dark ? Color(0xff131618) : null,
              border: Border.all(
                color: theme == Brightness.dark
                    ? Color(0xff495057)
                    : Color(0xffa9a9a9),
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(2),
            ),
            margin:
                const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: SelectableText(
                      googleOutput,
                      style: TextStyle(fontSize: outputFontSize),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CopyToClipboardButton(googleOutput),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => setState(() {
                        if (outputFontSize + 3 <= 90) outputFontSize += 3;
                      }),
                      icon: Icon(Icons.add),
                    ),
                    IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => setState(() {
                        if (outputFontSize - 3 >= 8) outputFontSize -= 3;
                      }),
                      icon: Icon(Icons.remove),
                    ),
                    MaximizedTtsOutput(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
