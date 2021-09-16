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
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
                child: SelectableText(
                  translationOutput,
                  style: const TextStyle(fontSize: 20),
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
