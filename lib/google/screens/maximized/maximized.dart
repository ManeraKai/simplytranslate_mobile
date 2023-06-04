import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import './widgets/tts_output.dart';
import '/data.dart';
import '/google/widgets/translation_input/buttons/copy_button.dart';

class MaximizedScreen extends StatefulWidget {
  const MaximizedScreen({Key? key}) : super(key: key);

  @override
  _MaximizedScreenState createState() => _MaximizedScreenState();
}

class _MaximizedScreenState extends State<MaximizedScreen> {
  double outputFontSize = 20;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 40,
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
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Scrollbar(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  child: Directionality(
                      textDirection: googleOutput.containsKey('text')
                      ? intl.Bidi.detectRtlDirectionality(
                              googleOutput['text'] ?? '')
                          ? TextDirection.rtl
                          : TextDirection.ltr
                      : TextDirection.rtl,
                    child: SelectableText(
                      googleOutput['text'] ?? '',
                      style: TextStyle(fontSize: outputFontSize),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                CopyToClipboardButton(googleOutput['text'] ?? ''),
                IconButton(
                  onPressed: () async {
                    await SystemChrome.setEnabledSystemUIMode(
                        SystemUiMode.manual,
                        overlays: SystemUiOverlay.values);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.fullscreen_exit),
                ),
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
    );
  }
}