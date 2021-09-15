import 'package:flutter/material.dart';
import '../data.dart';

class TranslationOutput extends StatelessWidget {
  const TranslationOutput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: boxDecorationCustom,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SelectableText(
          translationOutput,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
