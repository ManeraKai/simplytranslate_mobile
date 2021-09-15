import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';
import './paste_clipboard_button.dart';

class TranslationInput extends StatelessWidget {
  final setStateParent;
  final translateParent;
  const TranslationInput({
    @required this.setStateParent,
    @required this.translateParent,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                maxLines: 8,
                controller: translationInputController,
                keyboardType: TextInputType.text,
                onChanged: (String input) async {
                  translationInput = input;
                },
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintStyle: const TextStyle(color: lightgreyColor),
                    hintText: AppLocalizations.of(context)!.enter_text_here),
                style: const TextStyle(fontSize: 20),
                onEditingComplete: () async {
                  FocusScope.of(context).unfocus();
                  setStateParent(() => loading = true);
                  await translateParent(translationInput);
                  setStateParent(() => loading = false);
                },
              ),
            ),
          ),
          PasteClipboardButton(),
        ],
      ),
    );
  }
}
