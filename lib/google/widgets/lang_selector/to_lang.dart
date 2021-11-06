import 'package:flutter/material.dart';
import '/data.dart';

bool _isFirstClick = false;

class GoogleToLang extends StatelessWidget {
  const GoogleToLang({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Function changeText = () {};
    return Container(
      width: size.width / 3 + 10,
      child: Autocomplete(
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
                                onTap: option == toSelLangMap[fromLangVal]
                                    ? null
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        for (var i in toSelLangMap.keys)
                                          if (option == toSelLangMap[i]) {
                                            session.write('to_lang', i);
                                            setStateOverlordData(
                                                () => toLangVal = i);
                                            changeText();
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
                                    style:
                                        (option == fromSelLangMap[fromLangVal])
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
                        return widgetList;
                      }(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (context, txtCtrl, fieldFocus, _) {
          if (toSelLangMap[toLangVal] != txtCtrl.text)
            txtCtrl.text = toSelLangMap[toLangVal]!;
          changeText = () => txtCtrl.text = toSelLangMap[toLangVal]!;
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
                session.write('to_lang', data);
                setStateOverlordData(() => toLangVal = data);
                txtCtrl.text = toSelLangMap[data]!;
              }

              resetData() {
                FocusScope.of(context).unfocus();
                txtCtrl.text = toSelLangMap[toLangVal]!;
              }

              String? chosenOne;
              for (var i in toSelLangMap.keys)
                if (toSelLangMap[i]!.toLowerCase().contains(input)) {
                  chosenOne = i;
                  break;
                }

              if (chosenOne != fromSelLangMap[fromLangVal] && chosenOne != null)
                writeData(chosenOne);
              else {
                var dimmedSelLangsTo = toSelLangMap;
                dimmedSelLangsTo.remove(chosenOne);

                String? chosenOneTwo;
                for (var i in dimmedSelLangsTo.keys)
                  if (dimmedSelLangsTo[i]!.toLowerCase().contains(input)) {
                    chosenOneTwo = i;
                    break;
                  }

                if (chosenOneTwo != dimmedSelLangsTo[toLangVal] &&
                    chosenOneTwo != null)
                  writeData(chosenOneTwo);
                else
                  resetData();
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
