import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';
import './settings_button.dart';

final ScrollController _rightTextviewScrollController = ScrollController();
bool toIsFirstClick = false;
var selectLanguagesMapFlipped = {};

class SelectDefaultLang extends StatelessWidget {
  const SelectDefaultLang({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      onTap: () => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) => SelectDefaultLangDialog(),
        ),
      ),
      icon: Icons.translate,
      iconColor: theme == Brightness.dark ? Colors.white : greenColor,
      title: AppLocalizations.of(context)!.share_to_lang,
      content:
          'You can share a youtube video. You also can share a text for translation.\n\nThis setting specifies what language should it translate the text to. Autodetect will be set for the source language.\n\n$toLanguageShareDefault',
    );
  }
}

class SelectDefaultLangDialog extends StatefulWidget {
  const SelectDefaultLangDialog({Key? key}) : super(key: key);

  @override
  State<SelectDefaultLangDialog> createState() =>
      _SelectDefaultLangDialogState();
}

var fieldTextEditingControllerGlobal;

class _SelectDefaultLangDialogState extends State<SelectDefaultLangDialog> {
  @override
  Widget build(BuildContext context) {
    Function changeText = () {};
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(20),
      content: Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          Iterable<String> toSelectLanguagesIterable = Iterable.generate(
              selectLanguages.length, (i) => selectLanguages[i]);
          if (toIsFirstClick) {
            toIsFirstClick = false;
            return toSelectLanguagesIterable;
          } else
            return toSelectLanguagesIterable
                .where((word) => word
                    .toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase()))
                .toList();
        },
        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<String> onSelected,
          Iterable<String> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.height / 2 <=
                        (options.length) * (36 + 25)
                    ? MediaQuery.of(context).size.height / 2
                    : null,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: const [
                    const BoxShadow(offset: Offset(0, 0), blurRadius: 5)
                  ],
                ),
                child: Scrollbar(
                  controller: _rightTextviewScrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: _rightTextviewScrollController,
                    child: Column(
                      children: () {
                        List<Widget> widgetList = [];
                        for (int index = 0; index < options.length; index++) {
                          final option = options.elementAt(index);
                          widgetList.add(
                            Container(
                              color: theme == Brightness.dark
                                  ? greyColor
                                  : whiteColor,
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  session.write('to_language_share_default',
                                      selectLanguagesMap[option]);
                                  setStateOverlordData(() {
                                    toLanguageShareDefault = option;
                                    toLanguageValueShareDefault =
                                        selectLanguagesMap[option];
                                  });
                                  changeText();
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 18,
                                  ),
                                  child: Text(option),
                                ),
                              ),
                            ),
                          );
                        }
                        return widgetList;
                      }(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (
          BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted,
        ) {
          print(toLanguageShareDefault);
          print(fieldTextEditingController.text);
          // _focus = fieldFocusNode;
          fieldTextEditingControllerGlobal = fieldTextEditingController;
          if (toLanguageShareDefault != fieldTextEditingController.text) {
            fieldTextEditingController.text = toLanguageShareDefault;
          }
          changeText =
              () => fieldTextEditingController.text = toLanguageShareDefault;
          return Container(
            width: MediaQuery.of(context).size.width - 100,
            child: TextField(
                onTap: () {
                  toIsFirstClick = true;
                  fieldTextEditingControllerGlobal.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: fieldTextEditingControllerGlobal.text.length,
                  );
                },
                onEditingComplete: () {
                  try {
                    var chosenOne = selectLanguages.firstWhere((word) => word
                        .toLowerCase()
                        .startsWith(
                            fieldTextEditingController.text.toLowerCase()));

                    FocusScope.of(context).unfocus();
                    session.write('to_language_share_default',
                        selectLanguagesMap[chosenOne]);
                    setStateOverlordData(() {
                      toLanguageShareDefault = chosenOne;
                      toLanguageValueShareDefault =
                          selectLanguagesMap[chosenOne];
                    });
                    fieldTextEditingController.text = chosenOne;
                  } catch (_) {
                    FocusScope.of(context).unfocus();
                    fieldTextEditingController.text = toLanguageShareDefault;
                  }
                  Navigator.of(context).pop();
                },
                decoration: const InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  isDense: true,
                ),
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: TextStyle(
                    fontSize: 18,
                    color: theme == Brightness.dark ? null : Colors.black)),
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
