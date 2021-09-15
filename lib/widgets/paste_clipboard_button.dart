import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class PasteClipboardButton extends StatelessWidget {
  final changeText;
  const PasteClipboardButton({
    this.changeText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          Clipboard.getData(Clipboard.kTextPlain).then((value) {
            translationInputController.text += value!.text.toString();
            translationInputController.selection = TextSelection.collapsed(
                offset: translationInputController.text.length);
          });
        },
        icon: Icon(Icons.paste),
      ),
    );
  }
}
