import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data.dart';

class PasteClipboardButton extends StatelessWidget {
  final changeText;
  final setStateParent;
  const PasteClipboardButton({
    required this.setStateParent,
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
            if (value != null) {
              var newText =
                  translationInputController.text + value.text.toString();
              var selection = TextSelection.collapsed(offset: newText.length);
              setStateParent(() {
                translationInput = newText;
                translationInputController.text = newText;
                translationInputController.selection = selection;
              });
            }
          });
        },
        icon: Icon(Icons.paste),
      ),
    );
  }
}
