import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data.dart';

class ToLang extends StatefulWidget {
  const ToLang({
    Key? key,
  }) : super(key: key);

  @override
  _ToLangState createState() => _ToLangState();
}

class _ToLangState extends State<ToLang> {
  @override
  Widget build(BuildContext context) {
    Function changeText = () {};
    return Container(
      width: MediaQuery.of(context).size.width / 3 + 10,
      decoration: boxDecorationCustom,
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
                  color: greyColor,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: () {
                        List<Widget> widgetList = [];
                        for (int index = 0; index < options.length; index++) {
                          final option = options.elementAt(index);
                          widgetList.add(
                            GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                session.write('to_language', option);
                                setState(() {
                                  toLanguage = option;
                                  toLanguageValue = selectLanguagesMap[option];
                                });
                                changeText();
                              },
                              child: Container(
                                color: greyColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18),
                                child: Text(
                                  option,
                                  style: const TextStyle(fontSize: 20),
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
          if (toLanguageisDefault) {
            fieldTextEditingController.text = toLanguage;
            toLanguageisDefault = false;
          }
          changeText = () => fieldTextEditingController.text = toLanguage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              onTap: () {
                toIsFirstClick = true;
                fieldTextEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: fieldTextEditingController.text.length,
                );
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                var chosenOne = selectLanguages.firstWhere((word) => word
                    .toLowerCase()
                    .startsWith(fieldTextEditingController.text.toLowerCase()));

                session.write('to_language', chosenOne);
                setState(() {
                  toLanguage = chosenOne;
                  toLanguageValue = selectLanguagesMap[chosenOne];
                });
                fieldTextEditingController.text = chosenOne;
              },
              decoration: InputDecoration(border: InputBorder.none),
              controller: fieldTextEditingController,
              focusNode: fieldFocusNode,
              style: const TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
