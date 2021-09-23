import 'package:flutter/material.dart';
import '/data.dart';

class DeleteTranslationInputButton extends StatelessWidget {
  final setStateParent;
  final setStateParentParent;
  const DeleteTranslationInputButton({
    required this.setStateParent,
    required this.setStateParentParent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        // color: theme == Brightness.dark ? null : greenColor,
        onPressed: googleTranslationInputController.text == ''
            ? null
            : () {
                setStateParentParent(() {
                  googleTranslationInputController.text = '';
                  translationInput = '';
                  googleTranslationOutput = '';
                });
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
