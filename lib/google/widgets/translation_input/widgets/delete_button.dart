import 'package:flutter/material.dart';
import '/data.dart';

class DeleteTranslationInputButton extends StatelessWidget {
  final setStateParentParent;
  const DeleteTranslationInputButton(
      {required this.setStateParentParent, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: googleTranslationInputController.text == ''
            ? null
            : () {
                setStateParentParent(() {
                  loading = false;
                  isTranslationCanceled = true;
                  ttsInputloading = false;
                  isTtsInputCanceled = true;
                  ttsOutputloading = false;
                  isTtsOutputCanceled = true;
                  googleTranslationInputController.text = '';
                  translationInput = '';
                  googleTranslationOutput = '';
                });

                if (isSnackBarVisible) isSnackBarVisible = false;
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
