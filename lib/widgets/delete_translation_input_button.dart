import 'package:flutter/material.dart';
import '../data.dart';

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
        onPressed:
            translationInputController.text == '' && translationOutput == ''
                ? null
                : () {
                    setStateParentParent(() {
                      translationInputController.text = '';
                      translationInput = '';
                      translationOutput = '';
                    });
                  },
        icon: Icon(Icons.close),
      ),
    );
  }
}
