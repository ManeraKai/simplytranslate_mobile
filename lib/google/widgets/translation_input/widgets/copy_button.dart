import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class CopyToClipboardButton extends StatelessWidget {
  final text;
  const CopyToClipboardButton(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: theme == Brightness.dark ? null : greenColor,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: text == ''
          ? null
          : () {
              Clipboard.setData(ClipboardData(text: text)).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 1),
                    backgroundColor: greyColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    behavior: SnackBarBehavior.floating,
                    width: 160,
                    content: Text(
                      AppLocalizations.of(context)!.copied_to_clipboard,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: whiteColor),
                    ),
                  ),
                ),
              );
            },
      icon: Icon(Icons.copy),
    );
  }
}
