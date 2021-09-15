import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data.dart';

class FromLang extends StatefulWidget {
  const FromLang({
    Key? key,
  }) : super(key: key);

  @override
  _FromLangState createState() => _FromLangState();
}

class _FromLangState extends State<FromLang> {
  Widget build(BuildContext context) {
    Function changeText = () {};
    return Container(
      width: MediaQuery.of(context).size.width / 3 + 10,
      decoration: boxDecorationCustom,
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
                          widgetList.add(GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              session.write('from_language', option);
                              setState(() {
                                fromLanguage = option;
                                fromLanguageValue =
                                    fromSelectLanguagesMap[option];
                              });
                              changeText();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 18),
                              child: Text(
                                option,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ));
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
          if (fromLanguageisDefault) {
            fieldTextEditingController.text = fromLanguage;
            fromLanguageisDefault = false;
          }
          changeText = () => fieldTextEditingController.text = fromLanguage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              onTap: () {
                fromIsFirstClick = true;
                fieldTextEditingController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: fieldTextEditingController.text.length,
                );
              },
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                var chosenOne = selectLanguagesFrom.firstWhere((word) => word
                    .toLowerCase()
                    .startsWith(fieldTextEditingController.text.toLowerCase()));

                session.write('from_language', chosenOne);
                setState(() {
                  fromLanguage = chosenOne;
                  fromLanguageValue = fromSelectLanguagesMap[chosenOne];
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
