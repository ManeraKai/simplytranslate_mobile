import 'package:flutter/material.dart';
import '/data.dart';

class DeleteTranslationInputButton extends StatelessWidget {
  const DeleteTranslationInputButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: googleInputController.text == ''
            ? null
            : () {
                setStateOverlordData(() {
                  loading = false;
                  isTranslationCanceled = true;
                  ttsInputloading = false;
                  isTtsInputCanceled = true;
                  ttsOutputloading = false;
                  isTtsOutputCanceled = true;
                  googleInputController.text = '';
                  googleTranslationOutput = '';
                });
                FocusScope.of(context).unfocus();

                if (isSnackBarVisible) isSnackBarVisible = false;
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
