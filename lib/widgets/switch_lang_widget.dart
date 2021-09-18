// Copyright (C) 2021 ManeraKai
//
// This file is part of simplytranslate-flutter-client.
//
// simplytranslate-flutter-client is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// simplytranslate-flutter-client is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with simplytranslate-flutter-client.  If not, see <http://www.gnu.org/licenses/>.

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class SwitchLang extends StatelessWidget {
  final setStateParent;
  final translateParent;
  const SwitchLang({
    required this.setStateParent,
    required this.translateParent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        decoration: theme == Brightness.dark
            ? boxDecorationCustomDark
            : boxDecorationCustomLight,
        height: 41,
        child: TextButton(
          onPressed: () async {
            if (fromLanguage != AppLocalizations.of(context)!.autodetect) {
              FocusScope.of(context).unfocus();
              loading = true;
              final tmp = fromLanguage;
              fromLanguage = toLanguage;
              toLanguage = tmp;

              session.write('to_language', toLanguage);
              session.write('from_language', fromLanguage);

              final valuetmp = fromLanguageValue;
              fromLanguageValue = toLanguageValue;
              toLanguageValue = valuetmp;

              fromLanguageisDefault = true;
              toLanguageisDefault = true;

              final translationInputTmp = translationInput;

              setStateParent(() {
                translationInput = translationOutput;
                translationInputController.text = translationOutput;
              });
              final x = await translateParent(translationInputTmp);
              setStateParent(() {
                loading = false;
                translationOutput = x;
              });
            }
          },
          child: const Text(
            '<->',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
}
