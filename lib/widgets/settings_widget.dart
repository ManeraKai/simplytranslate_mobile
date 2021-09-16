import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class Settings extends StatefulWidget {
  final checkInstanceParent;
  const Settings({
    @required this.checkInstanceParent,
    Key? key,
  }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    customInstance = customUrlController.text;
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //-------------- Instance Select Button --------------------//
          Container(
            decoration: boxDecorationCustom,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              dropdownColor: greyColor,
              onChanged: (String? value) => setState(() {
                if (value == 'random')
                  instanceIndex = Random().nextInt(instances.length);
                else if (value == 'custom')
                  instanceIndex = 0;
                else
                  instanceIndex = instances.indexOf(value!);
                instance = value!;
                session.write('instance_mode', value);
              }),
              value: instance,
              items: [
                ...() {
                  var list = <DropdownMenuItem<String>>[];
                  for (String x in instances)
                    list.add(DropdownMenuItem(value: x, child: Text(x)));
                  return list;
                }(),
                DropdownMenuItem(
                    value: 'random',
                    child: Text(AppLocalizations.of(context)!.random)),
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
              decoration: boxDecorationCustom.copyWith(
                  color: isCustomInstanceValid == customInstanceValidation.True
                      ? Colors.green
                      : isCustomInstanceValid == customInstanceValidation.False
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
                  widget.checkInstanceParent();
                },
                decoration:
                    const InputDecoration(focusedBorder: InputBorder.none),
                style: const TextStyle(fontSize: 20, color: whiteColor),
              ),
            ),
            //--------------------------------------------------------//
            const SizedBox(height: 10),
            checkLoading
                ?
                //----------------- Loading Circle --------------------//
                Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                //----------------------------------------------------//
                :
                //----------------- Check Button ---------------------//
                TextButton(
                    style: ButtonStyle(
                        backgroundColor: checkLoading
                            ? MaterialStateProperty.all(Colors.transparent)
                            : null),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      widget.checkInstanceParent();
                    },
                    child: Text(AppLocalizations.of(context)!.check)),
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
          const SizedBox(height: 10),
          Container(
            decoration: boxDecorationCustom,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton(
              isExpanded: true,
              underline: const SizedBox.shrink(),
              dropdownColor: greyColor,
              onChanged: (String? value) => setState(() {
                engineSelected = value!;
                session.write('engine', value);
              }),
              value: engineSelected,
              items: [
                DropdownMenuItem(
                    value: 'google', child: Text('GoogleTranslate')),
                DropdownMenuItem(value: 'libre', child: Text('LibreTranslate'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
