import 'package:flutter/material.dart';
import '/data.dart';

class Definitions extends StatelessWidget {
  final Map translatedText;

  const Definitions(
    this.translatedText, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (translatedText.containsKey('definitions') && translatedText['definitions'].isNotEmpty) ...[
            SizedBox(height: 20),
            Text(
              i18n().main.definitions,
              style: TextStyle(fontSize: 24),
            ),
            line,
            for (String type in translatedText['definitions'].keys) ...[
              Text(
                type.capitalize(),
                style: TextStyle(fontSize: 20, color: theme == Brightness.dark ? Colors.cyanAccent : Color(0xff007979)),
              ),
              SizedBox(height: 8),
              for (int i = 0; i < translatedText['definitions'][type].length; i++) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${i + 1}. ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "${translatedText['definitions'][type][i]['definition']}",
                            style: TextStyle(fontSize: 16),
                          ),
                          if (translatedText['definitions'][type][i].containsKey('use-in-sentence')) ...[
                            SelectableText(
                              '"${translatedText['definitions'][type][i]['use-in-sentence']}"',
                              style: TextStyle(
                                fontSize: 16,
                                color: theme == Brightness.dark ? Colors.yellow : Color(0xff009902),
                              ),
                            ),
                          ],
                          if (translatedText['definitions'][type][i].containsKey('synonyms'))
                            for (String x in translatedText['definitions'][type][i]['synonyms'].keys) ...[
                              SizedBox(height: 5),
                              SelectableText.rich(
                                TextSpan(children: [
                                  if (x != "")
                                    TextSpan(
                                      text: '$x: ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme == Brightness.dark ? Colors.cyanAccent : Color(0xff007979),
                                      ),
                                    ),
                                  TextSpan(
                                    text: translatedText['definitions'][type][i]['synonyms'][x].join(', '),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme == Brightness.dark ? Color(0xffdeb887) : Color(0xff804700),
                                    ),
                                  )
                                ]),
                              )
                            ],
                          SizedBox(height: 20),
                        ],
                      ),
                    )
                  ],
                ),
              ],
              SizedBox(height: 10),
            ]
          ]
        ],
      ),
    );
  }
}
