import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class GoogleCancelTranslationButton extends StatelessWidget {
  final setStateParent;

  const GoogleCancelTranslationButton({Key? key, required this.setStateParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: GestureDetector(
        onTap: googleTranslationInputController.text == ''
            ? null
            : googleTranslationInputController.text.length <= 5000
                ? () async {
                    setStateParent(() {
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
