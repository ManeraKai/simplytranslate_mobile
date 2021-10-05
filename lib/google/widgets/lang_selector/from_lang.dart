import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/data.dart';

final ScrollController leftTextviewScrollController = ScrollController();
bool fromIsFirstClick = false;

class GoogleFromLang extends StatelessWidget {
  final setStateOverlord;
  const GoogleFromLang({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    Function changeText = () {};
    return Container(
      width: MediaQuery.of(context).size.width / 3 + 10,
      child: Autocomplete(
        optionsBuilder: (TextEditingValue textEditingValue) {
          Iterable<String> fromSelectLanguagesIterable = Iterable.generate(
              selectLanguagesFrom.length, (i) => selectLanguagesFrom[i]);
          if (fromIsFirstClick) {
            fromIsFirstClick = false;
            return fromSelectLanguagesIterable;
          } else
            return fromSelectLanguagesIterable
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
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: const [
                    const BoxShadow(offset: Offset(0, 0), blurRadius: 5)
                  ],
                ),
                child: Scrollbar(
                  controller: leftTextviewScrollController,
                  isAlwaysShown: true,
                  child: SingleChildScrollView(
                    controller: leftTextviewScrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                onTap: option == toLanguage
                                    ? null
                                    : () {
                                        if (option != toLanguage) {
                                          FocusScope.of(context).unfocus();
                                          session.write(
                                              'from_language', option);
                                          setStateOverlord(() {
                                            fromLanguage = option;
                                            fromLanguageValue =
                                                fromSelectLanguagesMap[option];
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
                                    style: (option == toLanguage)
                                        ? const TextStyle(
                                            fontSize: 18,
                                            color: lightThemeGreyColor,
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
          if (fromLanguage != fieldTextEditingController.text) {
            fieldTextEditingController.text = fromLanguage;
          }
          changeText = () => fieldTextEditingController.text = fromLanguage;
          return TextField(
            onTap: () {
              // setStateOverlord(() => translationInputOpen = false);
              fromIsFirstClick = true;
              fieldTextEditingController.selection = TextSelection(
                baseOffset: 0,
                extentOffset: fieldTextEditingController.text.length,
              );
            },
            onEditingComplete: () {
              try {
                var chosenOne = selectLanguagesFrom.firstWhere((word) => word
                    .toLowerCase()
                    .startsWith(fieldTextEditingController.text.toLowerCase()));
                if (chosenOne != toLanguage) {
                  FocusScope.of(context).unfocus();
                  session.write(
                      'from_language', fromSelectLanguagesMap[chosenOne]);
                  setStateOverlord(() {
                    fromLanguage = chosenOne;
                    fromLanguageValue = fromSelectLanguagesMap[chosenOne];
                  });
                  fieldTextEditingController.text = chosenOne;
                } else {
                  var dimmedSelectLanguagesFrom = selectLanguagesFrom.toList();
                  dimmedSelectLanguagesFrom.remove(chosenOne);
                  try {
                    var chosenOne = dimmedSelectLanguagesFrom.firstWhere(
                        (word) => word.toLowerCase().startsWith(
                            fieldTextEditingController.text.toLowerCase()));
                    if (chosenOne != toLanguage) {
                      FocusScope.of(context).unfocus();

                      session.write(
                          'from_language', fromSelectLanguagesMap[chosenOne]);
                      setStateOverlord(() {
                        fromLanguage = chosenOne;
                        fromLanguageValue = fromSelectLanguagesMap[chosenOne];
                      });
                      fieldTextEditingController.text = chosenOne;
                    }
                  } catch (_) {
                    FocusScope.of(context).unfocus();
                    fieldTextEditingController.text = fromLanguage;
                  }
                }
              } catch (_) {
                FocusScope.of(context).unfocus();
                fieldTextEditingController.text = fromLanguage;
              }
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              isDense: true,
            ),
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: TextStyle(
              fontSize: 18,
            ),
          );
        },
      ),
    );
  }
}
