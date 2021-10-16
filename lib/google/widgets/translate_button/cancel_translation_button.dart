import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class GoogleCancelTranslationButton extends StatelessWidget {
  const GoogleCancelTranslationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: GestureDetector(
        onTap: googleInputController.text == ''
            ? null
            : googleInputController.text.length <= 5000
                ? () {
                    setStateOverlordData(() {
                      loading = false;
                      isTranslationCanceled = true;
                    });
                  }
                : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
