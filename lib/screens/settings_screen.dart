import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class Settings extends StatefulWidget {
  final setStateOverlord;
  const Settings(
    this.setStateOverlord, {
    Key? key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    customInstance = customUrlController.text;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(2),
            child: Container(
              color: lightgreyColor,
              height: 2,
            ),
          ),
          iconTheme: IconThemeData(
              color: theme == Brightness.dark ? whiteColor : Colors.black),
          backgroundColor: theme == Brightness.dark ? greyColor : whiteColor,
        ),
        backgroundColor:
            theme == Brightness.dark ? secondgreyColor : whiteColor,
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------- Instance Select Button --------------------//
                    Text(
                      AppLocalizations.of(context)!.select_instance,
                      style: const TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: theme == Brightness.dark
                          ? boxDecorationCustomDark
                          : boxDecorationCustomLight,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      height: 43,
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        dropdownColor:
                            theme == Brightness.dark ? greyColor : whiteColor,
                        onChanged: (String? value) => setState(() {
                          if (value == 'random')
                            instanceIndex = Random().nextInt(instances.length);
                          else if (value == 'custom')
                            instanceIndex = 0;
                          else
                            instanceIndex = instances.indexOf(value!);
                          instance = value!;
                          session.write('instance_mode', value);
                          checkLibreTranslate(widget.setStateOverlord);
                        }),
                        value: instance,
                        style: TextStyle(
                            fontSize: 17,
                            color: theme == Brightness.dark
                                ? whiteColor
                                : Colors.black),
                        items: [
                          ...() {
                            var list = <DropdownMenuItem<String>>[];
                            for (String x in instances)
                              list.add(
                                  DropdownMenuItem(value: x, child: Text(x)));
                            return list;
                          }(),
                          DropdownMenuItem(
                              value: 'random',
                              child:
                                  Text(AppLocalizations.of(context)!.random)),
                          DropdownMenuItem(
                              value: 'custom',
                              child: Text(AppLocalizations.of(context)!.custom))
                        ],
                      ),
                    ),
                    //----------------------------------------------------------//
                    if (instance == 'custom') ...[
                      SizedBox(height: 10),
                      //------------- Custom Instance URL Input ----------------//
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
                            checkInstance(widget.setStateOverlord);
                          },
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none),
                          style: TextStyle(
                              fontSize: 20,
                              color: theme == Brightness.dark
                                  ? whiteColor
                                  : Colors.black),
                        ),
                      ),
                      //--------------------------------------------------------//
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          checkLoading
                              ?
                              //----------------- Loading Circle --------------------//
                              Container(
                                  width: 50,
                                  height: 45,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              //----------------------------------------------------//
                              :
                              //----------------- Check Button ---------------------//
                              Container(
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
                                      checkInstance(widget.setStateOverlord);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.check,
                                        style: const TextStyle(fontSize: 16)),
                                  ),
                                ),
                        ],
                      ),
                      //----------------------------------------------------//
                    ] else if (instance == 'random') ...[
                      const SizedBox(height: 10),
                      //------- All Known Instances in a Scrollable List -------//
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: () {
                            var list = <Widget>[];
                            for (String x in instances) {
                              list.add(Text('● $x'));
                              list.add(SizedBox(height: 10));
                            }
                            return list;
                          }(),
                        ),
                      )
                      //--------------------------------------------------------//
                    ]
                    // Instance Select is one of the `Default Instances`.
                    else
                      //---- Nothing... the instance will be selected from the original Select Button -----//
                      const SizedBox.shrink(),
                    SizedBox(height: 40),
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: const TextStyle(fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: 43,
                      decoration: theme == Brightness.dark
                          ? boxDecorationCustomDark
                          : boxDecorationCustomLight,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        dropdownColor:
                            theme == Brightness.dark ? greyColor : whiteColor,
                        style: TextStyle(
                            fontSize: 18,
                            color: theme == Brightness.dark
                                ? whiteColor
                                : Colors.black),
                        onChanged: (String? value) => setState(() {
                          session.write('theme', value);
                          widget.setStateOverlord(() {
                            themeValue = value!;
                            if (value == 'system')
                              theme = MediaQuery.of(context).platformBrightness;
                            else if (value == 'light')
                              theme = Brightness.light;
                            else if (value == 'dark') theme = Brightness.dark;
                          });
                        }),
                        value: themeValue,
                        items: [
                          DropdownMenuItem(
                              value: 'system',
                              child: Text(
                                  AppLocalizations.of(context)!.follow_system)),
                          DropdownMenuItem(
                              value: 'light',
                              child: Text(AppLocalizations.of(context)!.light)),
                          DropdownMenuItem(
                              value: 'dark',
                              child: Text(AppLocalizations.of(context)!.dark))
                        ],
                      ),
                    ),
                  ])),
        ),
      ),
    );
  }
}
