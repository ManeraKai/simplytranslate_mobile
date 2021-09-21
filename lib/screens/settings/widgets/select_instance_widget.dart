import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';

class SelectInstance extends StatelessWidget {
  const SelectInstance({
    this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  final setStateOverlord;

  @override
  Widget build(BuildContext context) {
    instanceFunc(setState, x) {
      instanceIndex = instances.indexOf(x);
      setState(() => instance = x);
      session.write('instance_mode', x);
      checkLibreTranslate(setStateOverlord);
    }

    randomFunc(setState) {
      instanceIndex = Random().nextInt(instances.length);
      setState(() {
        instance = 'random';
      });
      session.write('instance_mode', 'random');
      checkLibreTranslate(setStateOverlord);
    }

    customFunc(setState) {
      instanceIndex = 0;
      setState(() {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 10),
                  title: Column(children: [
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
                              setState(() {
                                isCustomInstanceValid =
                                    customInstanceValidation.NotChecked;
                              });
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            checkInstance(setStateOverlord);
                          },
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none),
                          style: TextStyle(
                              fontSize: 20,
                              color: theme == Brightness.dark
                                  ? whiteColor
                                  : Colors.black),
                        )),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      checkLoading
                          ? Container(
                              width: 50,
                              height: 45,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          : Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: 35,
                              decoration: theme == Brightness.dark
                                  ? boxDecorationCustomDark
                                  : boxDecorationCustomLight,
                              child: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: checkLoading
                                        ? MaterialStateProperty.all(
                                            Colors.transparent)
                                        : null),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  checkInstance(setStateOverlord);
                                },
                                child: Text(AppLocalizations.of(context)!.check,
                                    style: const TextStyle(fontSize: 16)),
                              ),
                            ),
                    ])
                  ]),
                ));

        instance = 'custom';
        session.write('instance_mode', 'custom');
      });
    }

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => AlertDialog(
                  insetPadding: EdgeInsets.all(0),
                  title: Column(children: [
                    ...() {
                      var list = <Widget>[];
                      for (String x in instances)
                        list.add(Container(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Radio<String>(
                                  value: x,
                                  groupValue: instance,
                                  onChanged: (_) => instanceFunc(setState, x)),
                              Expanded(
                                child: InkWell(
                                    onTap: () => instanceFunc(setState, x),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: Text(
                                        customUrlFormatting(x),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ));
                      return list;
                    }(),
                    Row(
                      children: [
                        Radio<String>(
                            value: 'random',
                            groupValue: instance,
                            onChanged: (_) => randomFunc(setState)),
                        Expanded(
                          child: InkWell(
                            onTap: () => randomFunc(setState),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                AppLocalizations.of(context)!.random,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio<String>(
                            value: 'custom',
                            groupValue: instance,
                            onChanged: (_) => customFunc(setState)),
                        Expanded(
                          child: InkWell(
                            onTap: () => customFunc(setState),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                AppLocalizations.of(context)!.custom,
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Icon(
              Icons.dns,
              color: theme == Brightness.dark ? Colors.white : greenColor,
              size: 45,
            )),
            SizedBox(width: 10),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Instance', style: TextStyle(fontSize: 18)),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(customUrlFormatting(instance),
                        style: TextStyle(
                            fontSize: 18,
                            color: theme == Brightness.dark
                                ? Colors.white54
                                : Colors.black54)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
