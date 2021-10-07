import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

bool _isSnackBarVisible = false;

class CharacterLimit extends StatelessWidget {
  const CharacterLimit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: InkWell(
        onTap: () {
          if (!_isSnackBarVisible) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                width: 300,
                content: Text(
                  googleTranslationInputController.text.length > 5000
                      ? AppLocalizations.of(context)!.input_calc.replaceFirst(
                          '\$lengthDifference',
                          '${googleTranslationInputController.text.length - 5000}')
                      : AppLocalizations.of(context)!
                          .input_fraction
                          .replaceFirst('\$length',
                              '${googleTranslationInputController.text.length}'),
                  textAlign: TextAlign.center,
                ),
              ),
            );
            _isSnackBarVisible = true;
            Future.delayed(Duration(seconds: 1))
                .then((value) => _isSnackBarVisible = false);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              googleTranslationInputController.text.length.toString(),
              style: TextStyle(
                color: googleTranslationInputController.text.length > 5000
                    ? Colors.red
                    : theme == Brightness.dark
                        ? Colors.white
                        : lightThemeGreyColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              height: 1,
              width: 30,
              color: googleTranslationInputController.text.length > 5000
                  ? Colors.red
                  : theme == Brightness.dark
                      ? Colors.white
                      : lightThemeGreyColor,
            ),
            Text(
              '5000',
              style: TextStyle(
                  color: googleTranslationInputController.text.length > 5000
                      ? Colors.red
                      : theme == Brightness.dark
                          ? Colors.white
                          : lightThemeGreyColor),
            ),
          ],
        ),
      ),
    );
  }
}
