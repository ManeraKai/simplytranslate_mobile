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
        onPressed: googleInCtrl.text == ''
            ? null
            : () {
                setStateOverlord(() {
                  loading = false;
                  isTranslationCanceled = true;
                  ttsInputloading = false;
                  isTtsInCanceled = true;
                  ttsOutloading = false;
                  isTtsOutputCanceled = true;
                  googleInCtrl.text = '';
                  googleOutput = {};
                });
                FocusScope.of(context).unfocus();
              },
        icon: Icon(Icons.close),
      ),
    );
  }
}
