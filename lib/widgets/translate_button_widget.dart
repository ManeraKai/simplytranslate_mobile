import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class TranslateButton extends StatelessWidget {
  final setStateParent;
  final translateParent;
  final translateEngine;

  const TranslateButton(
      {Key? key,
      required this.setStateParent,
      required this.translateParent,
      required this.translateEngine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: loading
          ? Container(
              alignment: Alignment.center,
              width: 80,
              height: 38,
              child: CircularProgressIndicator())
          : Ink(
              height: 38,
              decoration: theme == Brightness.dark
                  ? boxDecorationCustomDark
                  : boxDecorationCustomLight,
              child: Padding(
                padding: const EdgeInsets.all(6.5),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      setStateParent(() => loading = true);
                      await translateParent(translationInput, translateEngine);
                      setStateParent(() => loading = false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
