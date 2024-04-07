import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/simplytranslate.dart';
import '/data.dart';

class GoogleLang extends StatefulWidget {
  final FromTo fromto;
  GoogleLang(
    this.fromto, {
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleLang> createState() => _GoogleLangState();
}

bool _isFirstClick = true;

class _GoogleLangState extends State<GoogleLang> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 3 + 10,
      child: Autocomplete(
        optionsBuilder: (TextEditingValue txtEditingVal) {
          final selLangMap = widget.fromto == FromTo.from ? fromSelLangMap : toSelLangMap;
          Iterable<String> selLangsIterable = selLangMap.values;
          if (_isFirstClick) {
            _isFirstClick = false;
            var list = selLangsIterable.toList();
            final (last1, last2, last3) = lastUsed(widget.fromto);
            if (last1 != null && last2 != null && last3 != null) {
              list.remove(selLangMap[last1]!);
              list.remove(selLangMap[last2]!);
              list.remove(selLangMap[last3]!);
              if (widget.fromto == FromTo.from) {
                list.remove(selLangMap['auto']!);
                list = [selLangMap['auto']!, selLangMap[last1]!, selLangMap[last2]!, selLangMap[last3]!, ...list];
              } else {
                list = [selLangMap[last1]!, selLangMap[last2]!, selLangMap[last3]!, ...list];
              }
            } else if (last1 != null && last2 != null) {
              list.remove(selLangMap[last1]!);
              list.remove(selLangMap[last2]!);
              if (widget.fromto == FromTo.from) {
                list.remove(selLangMap['auto']!);
                list = [selLangMap['auto']!, selLangMap[last1]!, selLangMap[last2]!, ...list];
              } else {
                list = [selLangMap[last1]!, selLangMap[last2]!, ...list];
              }
            } else if (last1 != null) {
              list.remove(selLangMap[last1]!);
              if (widget.fromto == FromTo.from) {
                list.remove(selLangMap['auto']!);
                list = [selLangMap['auto']!, selLangMap[last1]!, ...list];
              } else {
                list = [selLangMap[last1]!, ...list];
              }
            } else {
              if (widget.fromto == FromTo.from) {
                list.remove(selLangMap['auto']!);
                list = [selLangMap['auto']!, ...list];
              }
            }
            return list;
          } else {
            final query = txtEditingVal.text.toLowerCase();
            if (query.trim().isEmpty) {
              var list = selLangsIterable.toList();
              list.sort();
              if (widget.fromto == FromTo.from) {
                list.remove(selLangMap['auto']!);
                list = [selLangMap['auto']!, ...list];
              }
              return list;
            }
            var list = selLangsIterable.where((word) => word.toLowerCase().contains(query)).toList();
            list.sort((a, b) => a.indexOf(query).compareTo(b.indexOf(query)));
            return list;
          }
        },
        optionsViewBuilder: (_, __, Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: size.width / 3 + 10,
                height: size.height / 2 <= (options.length) * (36 + 25) ? size.height / 2 : null,
                margin: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  boxShadow: const [const BoxShadow(offset: Offset(0, 0), blurRadius: 5)],
                ),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: options
                          .map(
                            (option) => Container(
                              color: theme == Brightness.dark ? greyColor : Colors.white,
                              child: GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (option == (widget.fromto == FromTo.from ? fromSelLangMap[toLangVal] : toSelLangMap[fromLangVal])) {
                                    switchVals();
                                  } else {
                                    for (var i in widget.fromto == FromTo.from ? fromSelLangMap.keys : toSelLangMap.keys) {
                                      if (option == (widget.fromto == FromTo.from ? fromSelLangMap[i] : toSelLangMap[i])) {
                                        session.write(widget.fromto == FromTo.from ? 'from_lang' : 'to_lang', i);
                                        if (widget.fromto == FromTo.from) {
                                          fromLangVal = i;
                                          changeFromTxt!(fromSelLangMap[fromLangVal]!);
                                        } else {
                                          toLangVal = i;
                                          changeToTxt!(toSelLangMap[toLangVal]!);
                                        }
                                        final translatedText = await translate(googleInCtrl.text, fromLangVal, toLangVal);
                                        if (!isTranslationCanceled) setStateOverlord(() => googleOutput = translatedText);
                                        break;
                                      }
                                    }
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: () {
                                        final (last1, last2, last3) = lastUsed(widget.fromto);
                                        if (widget.fromto == FromTo.from) {
                                          if (option == fromSelLangMap[last1] || option == fromSelLangMap[last2] || option == fromSelLangMap[last3]) {
                                            return greenColor;
                                          }
                                        } else {
                                          if (option == toSelLangMap[last1] || option == toSelLangMap[last2] || option == toSelLangMap[last3]) {
                                            return greenColor;
                                          }
                                        }
                                      }(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        initialValue: TextEditingValue(text: widget.fromto == FromTo.from ? fromSelLangMap[fromLangVal]! : toSelLangMap[toLangVal]!),
        fieldViewBuilder: (context, txtCtrl, fieldFocus, _) {
          fieldFocus.addListener(() {
            if (!fieldFocus.hasPrimaryFocus) widget.fromto == FromTo.from ? fromCancel() : toCancel();
          });
          if (widget.fromto == FromTo.from) {
            fromCancel = () => txtCtrl.text = fromSelLangMap[fromLangVal]!;
            changeFromTxt = (String val) => txtCtrl.text = val;
          } else {
            toCancel = () => txtCtrl.text = toSelLangMap[toLangVal]!;
            changeToTxt = (String val) => txtCtrl.text = val;
          }
          return TextField(
            onTap: () {
              _isFirstClick = true;
              txtCtrl.selection = TextSelection(
                baseOffset: 0,
                extentOffset: txtCtrl.text.length,
              );
            },
            onEditingComplete: () async {
              final input = txtCtrl.text.trim().toLowerCase();
              String? chosenOne;
              for (var i in widget.fromto == FromTo.from ? fromSelLangMap.keys : toSelLangMap.keys) {
                if ((widget.fromto == FromTo.from ? fromSelLangMap[i] : toSelLangMap[i])!.toLowerCase().contains(input)) {
                  chosenOne = i;
                  break;
                }
              }
              if (chosenOne == null) {
                FocusScope.of(context).unfocus();
                txtCtrl.text = widget.fromto == FromTo.from ? fromSelLangMap[fromLangVal]! : toSelLangMap[toLangVal]!;
              } else if (chosenOne != (widget.fromto == FromTo.from ? toLangVal : fromLangVal)) {
                FocusScope.of(context).unfocus();
                session.write(widget.fromto == FromTo.from ? 'from_lang' : 'to_lang', chosenOne);
                setStateOverlord(() => widget.fromto == FromTo.from ? fromLangVal = chosenOne! : toLangVal = chosenOne!);
                txtCtrl.text = widget.fromto == FromTo.from ? fromSelLangMap[chosenOne]! : toSelLangMap[chosenOne]!;
              } else {
                switchVals();
                FocusScope.of(context).unfocus();
              }
              final translatedText = await translate(googleInCtrl.text, fromLangVal, toLangVal);
              if (!isTranslationCanceled) setStateOverlord(() => googleOutput = translatedText);
            },
            decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10), isDense: true),
            controller: txtCtrl,
            focusNode: fieldFocus,
            style: const TextStyle(fontSize: 18),
          );
        },
      ),
    );
  }
}
