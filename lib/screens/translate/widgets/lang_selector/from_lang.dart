import 'package:flutter/material.dart';
import '/data.dart';

bool _isFirstClick = false;

class GoogleFromLang extends StatelessWidget {
  const GoogleFromLang({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 3 + 10,
      child: Autocomplete(
        optionsBuilder: (TextEditingValue txtEditingVal) {
          Iterable<String> fromSelLangsIterable = fromSelLangMap.values;
          if (_isFirstClick) {
            _isFirstClick = false;
            return fromSelLangsIterable;
          } else
            return fromSelLangsIterable.where((word) =>
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
                                  if (option == fromSelLangMap[toLangVal]) {
                                    switchVals();
                                  } else {
                                    for (var i in fromSelLangMap.keys) {
                                      if (option == fromSelLangMap[i]) {
                                        session.write('from_lang', i);
                                        fromLangVal = i;
                                        changeFromTxt(
                                            fromSelLangMap[fromLangVal]!);
                                        break;
                                      }
                                    }
                                  }
                                  setStateOverlord(() {});
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
        initialValue: TextEditingValue(text: fromSelLangMap[fromLangVal]!),
        fieldViewBuilder: (context, txtCtrl, fieldFocus, _) {
          fieldFocus.addListener(() {
            if (!fieldFocus.hasPrimaryFocus) fromCancel();
          });
          fromCancel = () => txtCtrl.text = fromSelLangMap[fromLangVal]!;
          changeFromTxt = (String val) => txtCtrl.text = val;
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
              String? chosenOne;
              for (var i in fromSelLangMap.keys) {
                if (fromSelLangMap[i]!.toLowerCase().contains(input)) {
                  chosenOne = i;
                  break;
                }
              }
              if (chosenOne == null) {
                FocusScope.of(context).unfocus();
                txtCtrl.text = fromSelLangMap[fromLangVal]!;
              } else if (chosenOne != toLangVal) {
                FocusScope.of(context).unfocus();
                session.write('from_lang', chosenOne);
                setStateOverlord(() => fromLangVal = chosenOne!);
                txtCtrl.text = fromSelLangMap[chosenOne]!;
              } else {
                switchVals();
                FocusScope.of(context).unfocus();
              }
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
    );
  }
}
