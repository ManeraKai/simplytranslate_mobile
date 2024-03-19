import 'package:flutter/material.dart';
import '/data.dart';

bool _isFirstClick = false;

class GoogleLang extends StatefulWidget {
  final FromTo fromto;
  GoogleLang(
    this.fromto, {
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleLang> createState() => _GoogleLangState();
}

class _GoogleLangState extends State<GoogleLang> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 3 + 10,
      child: Autocomplete(
        optionsBuilder: (TextEditingValue txtEditingVal) {
          final selLangMap =
              widget.fromto == FromTo.from ? fromSelLangMap : toSelLangMap;
          Iterable<String> selLangsIterable = selLangMap.values;
          if (_isFirstClick) {
            _isFirstClick = false;
            var list = selLangsIterable.toList();
            var (max1, max2, max3) = lastUsed(widget.fromto);
            if (max1 != null) {
              final idx = list.indexOf(selLangMap[max1]!);
              if (idx >= 0) list.move(idx, 0);
            }
            if (max2 != null) {
              final idx = list.indexOf(selLangMap[max2]!);
              if (idx >= 0) list.move(idx, 1);
            }
            if (max3 != null) {
              final idx = list.indexOf(selLangMap[max3]!);
              if (idx >= 0) list.move(idx, 2);
            }
            return list;
          } else {
            final query = txtEditingVal.text.toLowerCase();
            var list = selLangsIterable
                .where((word) => word.toLowerCase().contains(query))
                .toList();
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
                                  if (option ==
                                      (widget.fromto == FromTo.from
                                          ? fromSelLangMap[toLangVal]
                                          : toSelLangMap[fromLangVal])) {
                                    switchVals();
                                  } else {
                                    for (var i in widget.fromto == FromTo.from
                                        ? fromSelLangMap.keys
                                        : toSelLangMap.keys) {
                                      if (option ==
                                          (widget.fromto == FromTo.from
                                              ? fromSelLangMap[i]
                                              : toSelLangMap[i])) {
                                        session.write(
                                            widget.fromto == FromTo.from
                                                ? 'from_lang'
                                                : 'to_lang',
                                            i);
                                        widget.fromto == FromTo.from
                                            ? () {
                                                fromLangVal = i;
                                                changeFromTxt!(fromSelLangMap[
                                                    fromLangVal]!);
                                              }()
                                            : () {
                                                toLangVal = i;
                                                changeToTxt!(
                                                    toSelLangMap[toLangVal]!);
                                              }();
                                        break;
                                      }
                                    }
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
        initialValue: TextEditingValue(
            text: widget.fromto == FromTo.from
                ? fromSelLangMap[fromLangVal]!
                : toSelLangMap[toLangVal]!),
        fieldViewBuilder: (context, txtCtrl, fieldFocus, _) {
          fieldFocus.addListener(() {
            if (!fieldFocus.hasPrimaryFocus)
              widget.fromto == FromTo.from ? fromCancel() : toCancel();
          });
          widget.fromto == FromTo.from
              ? () {
                  fromCancel =
                      () => txtCtrl.text = fromSelLangMap[fromLangVal]!;
                  changeFromTxt = (String val) => txtCtrl.text = val;
                }()
              : () {
                  toCancel = () => txtCtrl.text = toSelLangMap[toLangVal]!;
                  changeToTxt = (String val) => txtCtrl.text = val;
                }();

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
              for (var i in widget.fromto == FromTo.from
                  ? fromSelLangMap.keys
                  : toSelLangMap.keys) {
                if ((widget.fromto == FromTo.from
                        ? fromSelLangMap[i]
                        : toSelLangMap[i])!
                    .toLowerCase()
                    .contains(input)) {
                  chosenOne = i;
                  break;
                }
              }
              if (chosenOne == null) {
                FocusScope.of(context).unfocus();
                txtCtrl.text = widget.fromto == FromTo.from
                    ? fromSelLangMap[fromLangVal]!
                    : toSelLangMap[toLangVal]!;
              } else if (chosenOne !=
                  (widget.fromto == FromTo.from ? toLangVal : fromLangVal)) {
                FocusScope.of(context).unfocus();
                session.write(
                    widget.fromto == FromTo.from ? 'from_lang' : 'to_lang',
                    chosenOne);
                setStateOverlord(() => widget.fromto == FromTo.from
                    ? fromLangVal = chosenOne!
                    : toLangVal = chosenOne!);
                txtCtrl.text = widget.fromto == FromTo.from
                    ? fromSelLangMap[chosenOne]!
                    : toSelLangMap[chosenOne]!;
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
