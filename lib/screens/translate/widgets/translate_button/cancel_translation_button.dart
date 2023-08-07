import 'package:flutter/material.dart';
import '/data.dart';

class GoogleCancelTranslationButton extends StatelessWidget {
  const GoogleCancelTranslationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: GestureDetector(
        onTap: googleInCtrl.text == ''
            ? null
            : googleInCtrl.text.length <= 5000
                ? () {
                    setStateOverlord(() {
                      loading = false;
                      isTranslationCanceled = true;
                    });
                  }
                : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            i18n().main.cancel,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
