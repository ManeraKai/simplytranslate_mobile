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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (translatedText.containsKey('translations')) ...[
            Text(
              'Translations',
              style: TextStyle(fontSize: 24),
            ),
            line,
            for (String type in translatedText['translations'].keys) ...[
              Text(
                type.capitalize(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan,
                ),
              ),
              SizedBox(height: 8),
              for (var word in translatedText['translations'][type].keys) ...[
                RichText(
                  text: TextSpan(
                    text: "● $word: ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan,
                    ),
                    children: [
                      TextSpan(
                        text: translatedText['translations'][type][word]
                                    ['words']
                                .join(', ') +
                            ' ',
                        style: TextStyle(
                          color: Color(0xffdeb887),
                        ),
                      ),
                      TextSpan(
                        text: translatedText['translations'][type][word]
                            ['frequency'],
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ]
            ]
          ]
        ],
      ),
    );
  }
}
