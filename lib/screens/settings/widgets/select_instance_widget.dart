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
      Navigator.of(context).pop();
    }

    randomFunc(setState) {
      instanceIndex = Random().nextInt(instances.length);
      setState(() {
        instance = 'random';
      });
      session.write('instance_mode', 'random');
      checkLibreTranslate(setStateOverlord);
      Navigator.of(context).pop();
    }

    customFunc(setState) {
      instanceIndex = 0;
      Navigator.of(context).pop();
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
                              isCustomInstanceValid =
                                  customInstanceValidation.NotChecked;
                          },
                          onEditingComplete: () async {
                            FocusScope.of(context).unfocus();
                            await checkInstance(setStateOverlord);
                            if (isCustomInstanceValid ==
                                customInstanceValidation.True)
                              Navigator.of(context).pop();
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
                          : IconButton(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                await checkInstance(setStateOverlord);
                                if (isCustomInstanceValid ==
                                    customInstanceValidation.True)
                                  Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.check),
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
                          child: Expanded(
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 20),
                                      child: Text(
                                        customUrlFormatting(x),
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
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
                  Text(AppLocalizations.of(context)!.instance,
                      style: TextStyle(fontSize: 18)),
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    child: Text(
                        instance == 'custom'
                            ? AppLocalizations.of(context)!.custom
                            : instance == 'random'
                                ? AppLocalizations.of(context)!.random
                                : customUrlFormatting(instance),
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
