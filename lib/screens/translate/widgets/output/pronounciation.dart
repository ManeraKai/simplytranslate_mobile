import 'package:flutter/material.dart';
import '/data.dart';

class Pronunciation extends StatelessWidget {
  final Map translatedText;

  const Pronunciation(
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
          if (translatedText.containsKey('pronunciation') && translatedText['pronunciation'].isNotEmpty) ...[
            Text(
              translatedText['pronunciation'],
              style: TextStyle(
                fontSize: 18,
                color: theme == Brightness.dark ? Colors.white54 : Colors.black54,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
