import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';
import './settings_button.dart';

bool _isFirstClick = false;

var selectLanguagesMapFlipped = {};

class SelectDefaultLang extends StatelessWidget {
  const SelectDefaultLang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      onTap: () => showDialog(
        context: context,
        builder: (_) => SelectDefaultLangDialog(),
      ),
      icon: Icons.translate,
      iconColor: Colors.blue,
      title: AppLocalizations.of(context)!.default_share_language,
      content: AppLocalizations.of(context)!
          .default_share_language_summary
          .replaceFirst(
              '\$toLanguageShareDefault', '${toSelLangMap[shareLangVal]}'),
    );
  }
}

class SelectDefaultLangDialog extends StatefulWidget {
  const SelectDefaultLangDialog({Key? key}) : super(key: key);

  @override
  State<SelectDefaultLangDialog> createState() =>
      _SelectDefaultLangDialogState();
}

var txtEditingCtrlGlobal;

class _SelectDefaultLangDialogState extends State<SelectDefaultLangDialog> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Function changeText = () {};
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(20),
      content: Autocomplete(
        optionsBuilder: (TextEditingValue txtEditingVal) {
          Iterable<String> toSelLangsIterable = toSelLangMap.values;
          if (_isFirstClick) {
            _isFirstClick = false;
            return toSelLangsIterable;
          } else
            return toSelLangsIterable.where((word) =>
                word.toLowerCase().contains(txtEditingVal.text.toLowerCase()));
        },
        optionsViewBuilder: (_, __, Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: size.width / 3 + 10,
                height: size.height / 2 <= (options.length) * (36 + 25)
                    ? size.height / 2
                    : null,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: const [
                    const BoxShadow(offset: Offset(0, 0), blurRadius: 5)
                  ],
                ),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: () {
                        List<Widget> widgetList = [];
                        for (var option in options)
                          widgetList.add(
                            Container(
                              color: theme == Brightness.dark
                                  ? greyColor
                                  : Colors.white,
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  for (var i in toSelLangMap.keys)
                                    if (option == toSelLangMap[i]) {
                                      session.write('share_lang', i);
                                      setState(() => shareLangVal = i);
                                      setStateOverlordData(() {});
                                      changeText();
                                      Navigator.of(context).pop();
                                      break;
                                    }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 18,
                                  ),
                                  child: Text(
                                    option,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          );
                        return widgetList;
                      }(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        initialValue: TextEditingValue(text: toSelLangMap[shareLangVal]!),
        fieldViewBuilder: (context, txtCtrl, fieldFocus, _) {
          changeText = () => txtCtrl.text = toSelLangMap[shareLangVal]!;
          return TextField(
            onTap: () {
              _isFirstClick = true;
              txtCtrl.selection = TextSelection(
                baseOffset: 0,
                extentOffset: txtCtrl.text.length,
              );
            },
            onEditingComplete: () {
              final input = txtCtrl.text.trim().toLowerCase();
              writeData(data) {
                FocusScope.of(context).unfocus();
                session.write('share_lang', data);
                setState(() => shareLangVal = data);
                setStateOverlordData(() {});
                txtCtrl.text = toSelLangMap[data]!;

                Navigator.of(context).pop();
              }

              resetData() {
                FocusScope.of(context).unfocus();
                txtCtrl.text = toSelLangMap[shareLangVal]!;

                Navigator.of(context).pop();
              }

              String? chosenOne;
              for (var i in toSelLangMap.keys)
                if (toSelLangMap[i]!.toLowerCase().contains(input)) {
                  chosenOne = i;
                  break;
                }

              if (chosenOne != null)
                writeData(chosenOne);
              else
                resetData();
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              isDense: true,
            ),
            controller: txtCtrl,
            focusNode: fieldFocus,
            style: const TextStyle(fontSize: 18),
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.cancel),
        )
      ],
    );
  }
}
