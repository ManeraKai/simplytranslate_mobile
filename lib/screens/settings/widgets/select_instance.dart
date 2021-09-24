import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';

var isCustomInstanceValid = customInstanceValidation.NotChecked;
// Complete working on the custom instance input and it's coloring.
var loading = false;
bool checkLoading = false;
bool isCanceled = false;

class SelectInstance extends StatelessWidget {
  const SelectInstance({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  final setStateOverlord;

  @override
  Widget build(BuildContext context) {
    instanceFunc(setState, x) async {
      instanceIndex = instances.indexOf(x);
      setState(() => instance = x);
      Navigator.of(context).pop();
      setStateOverlord(() => loading = true);
      await checkInstance(setStateOverlord, instances[instanceIndex]);
      setStateOverlord(() => loading = false);
      session.write('instance_mode', x);
    }

    randomFunc(setState) async {
      setState(() => instance = 'random');
      Navigator.of(context).pop();
      setStateOverlord(() => loading = true);
      instanceIndex = Random().nextInt(instances.length);
      await checkInstance(setStateOverlord, instances[instanceIndex]);
      setStateOverlord(() => loading = false);
      session.write('instance_mode', 'random');
    }

    customCheck(setState) async {
      FocusScope.of(context).unfocus();
      final customUrl = customUrlController.text;
      setState(() {
        isCanceled = false;
        checkLoading = true;
      });
      var responseBool = await checkInstance(setState, customUrl);
      print(responseBool);
      if (!isCanceled) {
        setState(() {
          checkLoading = false;
          isCustomInstanceValid = responseBool;
        });
        if (isCustomInstanceValid == customInstanceValidation.True) {
          session.write('customInstance', customInstance);
          setStateOverlord(() {
            customInstance = customUrl;
          });
          Navigator.of(context).pop();
        }
      }
    }

    customFunc(setState) {
      instanceIndex = 0;
      Navigator.of(context).pop();
      setStateOverlord(() {
        instance = 'custom';
        session.write('instance_mode', 'custom');
      });
      showDialog(
        context: context,
        builder: (builder) => StatefulBuilder(
          builder: (context, setState) => Center(
            child: SingleChildScrollView(
              child: AlertDialog(
                content: TextField(
                  controller: customUrlController,
                  keyboardType: TextInputType.url,
                  onChanged: (String? value) {
                    if (isCustomInstanceValid !=
                        customInstanceValidation.NotChecked)
                      isCustomInstanceValid =
                          customInstanceValidation.NotChecked;
                  },
                  onEditingComplete: () => customCheck(setState),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: isCustomInstanceValid ==
                                  customInstanceValidation.NotChecked
                              ? lightThemeGreyColor
                              : isCustomInstanceValid ==
                                      customInstanceValidation.True
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: isCustomInstanceValid ==
                                  customInstanceValidation.NotChecked
                              ? lightThemeGreyColor
                              : isCustomInstanceValid ==
                                      customInstanceValidation.True
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1.5,
                          color: isCustomInstanceValid ==
                                  customInstanceValidation.NotChecked
                              ? lightThemeGreyColor
                              : isCustomInstanceValid ==
                                      customInstanceValidation.True
                                  ? Colors.green
                                  : Colors.red,
                        ),
                      ),
                      isDense: true),
                  style: TextStyle(fontSize: 20),
                ),
                actions: [
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.cancel),
                    onPressed: () {
                      isCanceled = true;
                      isCustomInstanceValid =
                          customInstanceValidation.NotChecked;
                      checkLoading = false;
                      Navigator.of(context).pop();
                    },
                  ),
                  checkLoading
                      ? Container(
                          width: 50,
                          height: 45,
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: () => customCheck(setState),
                          child: Text(AppLocalizations.of(context)!.check),
                        ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: loading
                      ? Container(
                          height: 45,
                          width: 45,
                          padding: EdgeInsets.all(5),
                          child: CircularProgressIndicator())
                      : Icon(
                          Icons.dns,
                          color: theme == Brightness.dark
                              ? Colors.white
                              : greenColor,
                          size: 45,
                        ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppLocalizations.of(context)!.instance,
                          style: TextStyle(fontSize: 18)),
                      Text(
                        instance == 'custom'
                            ? AppLocalizations.of(context)!.custom
                            : instance == 'random'
                                ? AppLocalizations.of(context)!.random
                                : instance,
                        style: TextStyle(
                          fontSize: 18,
                          color: theme == Brightness.dark
                              ? Colors.white54
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  contentPadding: EdgeInsets.all(5),
                  actionsPadding: EdgeInsets.zero,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.cancel),
                    )
                  ],
                  insetPadding: EdgeInsets.all(0),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    ...() {
                      var list = <Widget>[];
                      for (String x in instances)
                        list.add(Container(
                          width: double.infinity,
                          child: InkWell(
                              onTap: () => instanceFunc(setState, x),
                              child: Row(
                                children: [
                                  Radio<String>(
                                      // activeColor: greenColor,
                                      value: x,
                                      groupValue: instance,
                                      onChanged: (_) =>
                                          instanceFunc(setState, x)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: Text(
                                        x,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ));
                      return list;
                    }(),
                    InkWell(
                      onTap: () => randomFunc(setState),
                      child: Row(
                        children: [
                          Radio<String>(
                              // activeColor: greenColor,
                              value: 'random',
                              groupValue: instance,
                              onChanged: (_) => randomFunc(setState)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)!.random,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () => customFunc(setState),
                      child: Row(
                        children: [
                          Radio<String>(
                              // activeColor: greenColor,
                              value: 'custom',
                              groupValue: instance,
                              onChanged: (_) => customFunc(setState)),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)!.custom,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              );
            }).then((value) {
          checkLoading = false;
          isCustomInstanceValid = customInstanceValidation.NotChecked;
        });
      },
    );
  }
}
