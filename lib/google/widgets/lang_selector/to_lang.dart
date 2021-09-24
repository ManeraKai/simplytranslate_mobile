import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/data.dart';

final ScrollController rightTextviewScrollController = ScrollController();
bool toIsFirstClick = false;

class GoogleToLang extends StatelessWidget {
  final setStateOverlord;
  const GoogleToLang({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function changeText = () {};
    return Container(
      width: MediaQuery.of(context).size.width / 3 + 10,
      child: Autocomplete(
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
                width: MediaQuery.of(context).size.width / 3 + 10,
                height: MediaQuery.of(context).size.height / 2 <=
                        (options.length) * (36 + 25)
                    ? MediaQuery.of(context).size.height / 2
                    : null,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: [
                    BoxShadow(offset: Offset(0, 0), blurRadius: 5),
                  ],
                ),
                child: Scrollbar(
                  controller: rightTextviewScrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: rightTextviewScrollController,
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
                                onTap: option == fromLanguage
                                    ? null
                                    : () {
                                        if (option != fromLanguage) {
                                          FocusScope.of(context).unfocus();
                                          session.write('to_language', option);
                                          setStateOverlord(() {
                                            toLanguage = option;
                                            toLanguageValue =
                                                selectLanguagesMap[option];
                                          });
                                          changeText();
                                        }
                                      },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 18),
                                  child: Text(
                                    option,
                                    style: (option == fromLanguage)
                                        ? TextStyle(
                                            fontSize: 18,
                                          )
                                        : const TextStyle(fontSize: 18),
                                  ),
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
          if (toLanguage != fieldTextEditingController.text) {
            fieldTextEditingController.text = toLanguage;
          }
          changeText = () => fieldTextEditingController.text = toLanguage;
          return TextField(
              onTap: () {
                setStateOverlord(() => translationInputOpen = false);
                toIsFirstClick = true;
                fieldTextEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: fieldTextEditingController.text.length,
                );
              },
              onEditingComplete: () {
                try {
                  var chosenOne = selectLanguages.firstWhere((word) => word
                      .toLowerCase()
                      .startsWith(
                          fieldTextEditingController.text.toLowerCase()));
                  if (chosenOne != fromLanguage) {
                    FocusScope.of(context).unfocus();
                    session.write('to_language', chosenOne);
                    setStateOverlord(() {
                      toLanguage = chosenOne;
                      toLanguageValue = selectLanguagesMap[chosenOne];
                    });
                    fieldTextEditingController.text = chosenOne;
                  } else {
                    var dimmedSelectLanguage = selectLanguages.toList();
                    dimmedSelectLanguage.remove(chosenOne);

                    try {
                      chosenOne = dimmedSelectLanguage.firstWhere((word) => word
                          .toLowerCase()
                          .startsWith(
                              fieldTextEditingController.text.toLowerCase()));
                      if (chosenOne != fromLanguage) {
                        FocusScope.of(context).unfocus();
                        session.write('to_language', chosenOne);
                        setStateOverlord(() {
                          toLanguage = chosenOne;
                          toLanguageValue = selectLanguagesMap[chosenOne];
                        });
                        fieldTextEditingController.text = chosenOne;
                      }
                    } catch (_) {
                      FocusScope.of(context).unfocus();
                      fieldTextEditingController.text = toLanguage;
                    }
                  }
                } catch (_) {
                  FocusScope.of(context).unfocus();
                  fieldTextEditingController.text = toLanguage;
                }

                // chose the next one if the first is dimmed.
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                isDense: true,
              ),
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: TextStyle(
                  fontSize: 18,
                  color: theme == Brightness.dark ? null : Colors.black));
        },
      ),
    );
  }
}
