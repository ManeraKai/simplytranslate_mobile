import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
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
          if (translatedText.containsKey('definitions')) ...[
            SizedBox(height: 20),
            Text(
              'Definitions',
              style: TextStyle(fontSize: 24),
            ),
            line,
            for (String type in translatedText['definitions'].keys) ...[
              Text(
                type.capitalize(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.cyan,
                ),
              ),
              SizedBox(height: 8),
              for (int i = 0;
                  i < translatedText['definitions'][type].length;
                  i++) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${i + 1}. ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${translatedText['definitions'][type][i]['definition']}",
                            style: TextStyle(fontSize: 16),
                          ),
                          if (translatedText['definitions'][type][i]
                              .containsKey('use-in-sentence')) ...[
                            Text(
                              '"${translatedText['definitions'][type][i]['use-in-sentence']}"',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.yellow,
                              ),
                            ),
                          ],
                          if (translatedText['definitions'][type][i]
                              .containsKey('synonyms'))
                            for (String x in translatedText['definitions'][type]
                                    [i]['synonyms']
                                .keys) ...[
                              SizedBox(height: 5),
                              if (x != "")
                                Text(
                                  x,
                                  style: TextStyle(color: Colors.cyan),
                                ),
                              Text(
                                translatedText['definitions'][type][i]['synonyms']
                                        [x]
                                    .join(', '),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffdeb887),
                                ),
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
