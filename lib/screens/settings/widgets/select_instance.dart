import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';
import './settings_button.dart';

var isCustomInstanceValid = customInstanceValidation.NotChecked;
var loading = false;
bool checkLoading = false;
bool _isCanceled = false;
String _tmpInstance = '';
var _tmpInput = '';

class SelectInstance extends StatelessWidget {
  const SelectInstance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    instanceFunc(setState, x) async {
      instanceIndex = instances.indexOf(x);
      setState(() => instance = x);
      Navigator.of(context).pop();
      setStateOverlordData(() => loading = true);
      await checkInstance(setStateOverlordData, instances[instanceIndex]);
      setStateOverlordData(() => loading = false);
      session.write('instance_mode', x);
    }

    randomFunc(setState) async {
      setState(() => instance = 'random');
      Navigator.of(context).pop();
      setStateOverlordData(() => loading = true);
      instanceIndex = Random().nextInt(instances.length);
      await checkInstance(setStateOverlordData, instances[instanceIndex]);
      setStateOverlordData(() => loading = false);
      session.write('instance_mode', 'random');
    }

    customCheck(setState) async {
      FocusScope.of(context).unfocus();
      final customUrl = customUrlController.text;

      setState(() {
        _isCanceled = false;
        checkLoading = true;
      });
      var responseBool = await checkInstance(setState, customUrl);
      print(responseBool);
      if (!_isCanceled) {
        setState(() {
          checkLoading = false;
          isCustomInstanceValid = responseBool;
        });
        if (responseBool == customInstanceValidation.True) {
          session.write('customInstance', customUrl);
          setStateOverlordData(() {
            customInstance = customUrl;
          });
          Navigator.of(context).pop();
        }
      }
    }

    customFunc(setState) async {
      _tmpInstance = instance;
      _tmpInput = customUrlController.text;
      instanceIndex = 0;
      Navigator.of(context).pop();
      setStateOverlordData(() {
        instance = 'custom';
        session.write('instance_mode', 'custom');
      });
      await showDialog(
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
                  style: const TextStyle(fontSize: 20),
                ),
                actions: [
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.cancel),
                    onPressed: () {
                      _isCanceled = true;
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
                          child: const CircularProgressIndicator(),
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
      if (isCustomInstanceValid != customInstanceValidation.True) {
        if (_tmpInput != '') customUrlController.text = _tmpInput;
        print('tmp input is: $_tmpInput');
        setStateOverlordData(() => instance = _tmpInstance);
        session.write('instance_mode', _tmpInstance);
      }
    }

    const _textStyle = const TextStyle(fontSize: 16);
    const _padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 20);
    return SettingsButton(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  contentPadding: const EdgeInsets.all(5),
                  actionsPadding: EdgeInsets.zero,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(AppLocalizations.of(context)!.cancel),
                    )
                  ],
                  insetPadding: const EdgeInsets.all(0),
                  content: Column(mainAxisSize: MainAxisSize.min, children: [
                    ...() {
                      var list = <Widget>[];
                      for (String x in instances)
                        list.add(
                          Container(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () => instanceFunc(setState, x),
                              child: Row(
                                children: [
                                  Radio<String>(
                                      value: x,
                                      groupValue: instance,
                                      onChanged: (_) =>
                                          instanceFunc(setState, x)),
                                  Expanded(
                                    child: Padding(
                                      padding: _padding,
                                      child: Text(x, style: _textStyle),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      return list;
                    }(),
                    InkWell(
                      onTap: () => randomFunc(setState),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'random',
                            groupValue: instance,
                            onChanged: (_) => randomFunc(setState),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              AppLocalizations.of(context)!.random,
                              style: _textStyle,
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
                            value: 'custom',
                            groupValue: instance,
                            onChanged: (_) => customFunc(setState),
                          ),
                          Padding(
                            padding: _padding,
                            child: Text(
                              AppLocalizations.of(context)!.custom,
                              style: _textStyle,
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
      icon: Icons.dns,
      iconColor: theme == Brightness.dark ? Colors.white : greenColor,
      title: AppLocalizations.of(context)!.instance,
      content: instance == 'custom'
          ? '${AppLocalizations.of(context)!.custom}: $customInstance'
          : instance == 'random'
              ? AppLocalizations.of(context)!.random
              : instance,
      loading: loading,
    );
  }
}
