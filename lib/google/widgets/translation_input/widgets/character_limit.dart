import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

bool _isSnackBarVisible = false;

class CharacterLimit extends StatelessWidget {
  const CharacterLimit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textLength = googleInputController.text.length;
    final color = textLength > 5000
        ? Colors.red
        : theme == Brightness.dark
            ? Colors.white
            : greenColor;
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
                  () {
                    if (textLength > 5000) {
                      return AppLocalizations.of(context)!
                          .input_calc
                          .replaceFirst(
                              '\$lengthDifference', '${textLength - 5000}');
                    } else {
                      if (textLength == 1)
                        return AppLocalizations.of(context)!
                            .input_fraction_one
                            .replaceFirst('\$length', '$textLength');
                      else if (textLength > 1 && textLength < 5)
                        return AppLocalizations.of(context)!
                            .input_fraction_few
                            .replaceFirst('\$length', '$textLength');
                      else if (textLength >= 5)
                        return AppLocalizations.of(context)!
                            .input_fraction_many
                            .replaceFirst('\$length', '$textLength');
                      else
                        return AppLocalizations.of(context)!
                            .input_fraction_other
                            .replaceFirst('\$length', '$textLength');
                    }
                  }(),
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
              textLength > 99999 ? '∞' : textLength.toString(),
              style: TextStyle(color: color),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 3),
              height: 1,
              width: 30,
              color: color,
            ),
            Text(
              '5000',
              style: TextStyle(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
