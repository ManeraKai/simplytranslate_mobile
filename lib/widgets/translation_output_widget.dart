import 'package:flutter/material.dart';
import '../data.dart';
import './copy_to_clipboard_button.dart';

class TranslationOutput extends StatelessWidget {
  const TranslationOutput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
          CopyToClipboardButton(translationOutput)
        ],
      ),
    );
  }
}
