import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '/data.dart';

class Translations extends StatelessWidget {
  final Map translatedText;

  const Translations(this.translatedText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Directionality(
        textDirection: translatedText.containsKey('text')
            ? intl.Bidi.detectRtlDirectionality(translatedText['text'])
                ? TextDirection.rtl
                : TextDirection.ltr
            : TextDirection.rtl,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (translatedText.containsKey('translations') && translatedText['translations'].isNotEmpty) ...[
              Text(
                i18n().main.translations,
                style: TextStyle(fontSize: 24),
              ),
              line,
              for (String type in translatedText['translations'].keys) ...[
                Text(
                  type.capitalize(),
                  style: TextStyle(
                    fontSize: 20,
                    color: theme == Brightness.dark ? Colors.cyanAccent : Color(0xff007979),
                  ),
                ),
                SizedBox(height: 8),
                ...() {
                  List sorted = translatedText['translations'][type].keys.toList();
                  sorted.sort(
                    (a, b) {
                      final aInt = int.parse(translatedText['translations'][type][a]['frequency'][0]);
                      final bInt = int.parse(translatedText['translations'][type][b]['frequency'][0]);
                      return bInt.compareTo(aInt);
                    },
                  );
                  var list = [];
                  for (var word in sorted) {
                    list.add(
                      Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SelectableText.rich(
                                  TextSpan(
                                    text: "● $word: ",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme == Brightness.dark ? Colors.cyanAccent : Color(0xff007979),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: translatedText['translations'][type][word]['words'].join(', '),
                                        style: TextStyle(
                                          color: theme == Brightness.dark ? Color(0xffdeb887) : Color(0xff804700),
                                        ),
                                      ),
                                      TextSpan(text: ' '),
                                    ],
                                  ),
                                ),
                              ),
                              for (int i = 0; i < int.parse(translatedText['translations'][type][word]['frequency'][2]); i++)
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                                  height: 7,
                                  width: 20,
                                  color: int.parse(translatedText['translations'][type][word]['frequency'][0]) > i
                                      ? theme == Brightness.dark
                                          ? Colors.cyanAccent
                                          : Color(0xff007979)
                                      : Color(0xff007979).withAlpha(60),
                                ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    );
                  }
                  return list;
                }(),
                SizedBox(height: 20)
              ]
            ]
          ],
        ),
      ),
    );
  }
}
