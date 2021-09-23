import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';

var isCustomInstanceValid = customInstanceValidation.NotChecked;

var loading = false;
bool checkLoading = false;
bool isCanceled = false;

Future<customInstanceValidation> checkInstance(
    Function setState, String urlValue) async {
  setState(() => checkLoading = true);
  var url;
  try {
    url = Uri.parse(urlValue);
  } catch (_) {}
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
          'SimplyTranslate')) {
        session.write('url', customInstance);
        if (!isCanceled) {
          setState(() => isCustomInstanceValid = customInstanceValidation.True);
        }
      } else {
        if (!isCanceled) {
          setState(
              () => isCustomInstanceValid = customInstanceValidation.False);
        }
      }
      checkLibreTranslatewithRespone(response, setState: setState);
    } else {
      if (!isCanceled) {
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
      }
    }
  } catch (err) {
    if (!isCanceled) {
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
    }
  }
  setState(() => checkLoading = false);
  return isCustomInstanceValid;
}

class SelectInstance extends StatelessWidget {
  const SelectInstance({
    this.setStateOverlord,
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
      checkLibreTranslate(setStateOverlord);
    }

    randomFunc(setState) async {
      setState(() => instance = 'random');
      Navigator.of(context).pop();
      setStateOverlord(() => loading = true);
      instanceIndex = Random().nextInt(instances.length);
      await checkInstance(setStateOverlord, instances[instanceIndex]);
      setStateOverlord(() => loading = false);
      session.write('instance_mode', 'random');
      checkLibreTranslate(setStateOverlord);
    }

    customCheck() async {
      isCanceled = false;
      FocusScope.of(context).unfocus();
      await checkInstance(setStateOverlord, customInstance);
      if (!isCanceled) {
        if (isCustomInstanceValid == customInstanceValidation.True)
          isCanceled = false;
      }
    }

    customFunc(setState) {
      instanceIndex = 0;
      Navigator.of(context).pop();
      setStateOverlord(() {
        instance = 'custom';
        session.write('instance_mode', 'custom');
      });
    }

    return Column(
      children: [
        InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: loading
                            ? CircularProgressIndicator()
                            : isCustomInstanceValid ==
                                    customInstanceValidation.NotChecked
                                ? SizedBox.shrink()
                                : isCustomInstanceValid ==
                                        customInstanceValidation.True
                                    ? Icon(Icons.check)
                                    : Icon(Icons.close),
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
                      content:
                          Column(mainAxisSize: MainAxisSize.min, children: [
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
                                          activeColor: greenColor,
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
                                  activeColor: greenColor,
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
                                  activeColor: greenColor,
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
        ),
        instance == 'custom'
            ? Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: theme == Brightness.dark
                          ? boxDecorationCustomDark.copyWith(
                              color: isCustomInstanceValid ==
                                      customInstanceValidation.True
                                  ? Colors.green
                                  : isCustomInstanceValid ==
                                          customInstanceValidation.False
                                      ? Colors.red
                                      : null)
                          : boxDecorationCustomLight.copyWith(
                              color: isCustomInstanceValid ==
                                      customInstanceValidation.True
                                  ? Colors.green
                                  : isCustomInstanceValid ==
                                          customInstanceValidation.False
                                      ? Colors.red
                                      : null),
                      child: TextField(
                        controller: customUrlController,
                        keyboardType: TextInputType.url,
                        onChanged: (String? value) {
                          customInstance = value!;
                          if (isCustomInstanceValid !=
                              customInstanceValidation.NotChecked)
                            isCustomInstanceValid =
                                customInstanceValidation.NotChecked;
                        },
                        onEditingComplete: customCheck,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            isDense: true),
                        style: TextStyle(
                            fontSize: 20,
                            color: theme == Brightness.dark
                                ? whiteColor
                                : Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            isCanceled = true;
                            setStateOverlord(() {
                              isCustomInstanceValid =
                                  customInstanceValidation.NotChecked;
                              checkLoading = false;
                            });
                          },
                          child: Text(AppLocalizations.of(context)!.cancel),
                        ),
                        checkLoading
                            ? Container(
                                width: 50,
                                height: 45,
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: customCheck,
                                child:
                                    Text(AppLocalizations.of(context)!.check),
                              ),
                      ],
                    )
                  ],
                ),
              )
            : SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 20),
          child: Container(
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Update official list',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    onPressed: () async {
                      setStateOverlord(() => loading = true);
                      final response = await http.get(Uri.parse(
                          'https://simple-web.org/instances/simplytranslate'));
                      List<String> newInstances = [];
                      parse(response.body)
                          .body!
                          .innerHtml
                          .trim()
                          .split('\n')
                          .forEach((element) {
                        newInstances.add('https://$element');
                      });
                      session.write('instances', newInstances);
                      instances = newInstances;
                      setStateOverlord(() => loading = false);
                    },
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: OutlinedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Check current instance',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    onPressed: () async {
                      setStateOverlord(() => loading = true);
                      await checkInstance(
                          setStateOverlord, instances[instanceIndex]);
                      if (!isCanceled) {
                        if (isCustomInstanceValid ==
                            customInstanceValidation.True) isCanceled = false;
                      }
                      setStateOverlord(() => loading = false);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
