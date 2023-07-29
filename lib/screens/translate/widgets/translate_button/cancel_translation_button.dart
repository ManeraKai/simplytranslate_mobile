import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
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
            L10n.of(context).cancel,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
