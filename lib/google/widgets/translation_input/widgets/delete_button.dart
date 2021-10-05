import 'package:flutter/material.dart';
import '/data.dart';

class DeleteTranslationInputButton extends StatelessWidget {
  final setStateParentParent;
  const DeleteTranslationInputButton({
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
        onPressed: googleTranslationInputController.text == ''
            ? null
            : () => setStateParentParent(() {
                  googleTranslationInputController.text = '';
                  translationInput = '';
                  googleTranslationOutput = '';
                }),
        icon: Icon(Icons.close),
      ),
    );
  }
}
