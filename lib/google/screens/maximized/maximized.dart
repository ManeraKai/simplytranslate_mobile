import 'package:flutter/material.dart';
import '/data.dart';
import '../../widgets/translation_input/widgets/copy_button.dart';

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
            margin: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: SelectableText(
                      googleTranslationOutput,
                      style: TextStyle(fontSize: outputFontSize),
                    ),
                  ),
                ),
                Column(
                  children: [
                    CopyToClipboardButton(googleTranslationOutput),
                    IconButton(
                      // color: theme == Brightness.dark ? null : greenColor,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
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
                      onPressed: () {
                        setState(() {
                          if (outputFontSize - 3 >= 8) outputFontSize -= 3;
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
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
