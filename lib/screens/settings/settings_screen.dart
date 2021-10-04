import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/select_default_lang.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/update_list.dart';
import '../../data.dart';
import 'widgets/select_instance.dart';
import 'widgets/select_theme.dart';

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
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.settings,
          ),
          elevation: 3,
          // backgroundColor: theme == Brightness.dark ? greyColor : greenColor,
        ),
        // backgroundColor:
        //     theme == Brightness.dark ? secondgreyColor : whiteColor,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.instances,
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    height: 1.5,
                    color: theme == Brightness.dark
                        ? Colors.white
                        : lightThemeGreyColor),
                SelectInstance(setStateOverlord: widget.setStateOverlord),
                UpdateList(setStateOverlord: widget.setStateOverlord),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.appearance,
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    height: 1.5,
                    color: theme == Brightness.dark
                        ? Colors.white
                        : lightThemeGreyColor),
                SelectTheme(setStateOverlord: widget.setStateOverlord),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.translation,
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                    height: 1.5,
                    color: theme == Brightness.dark
                        ? Colors.white
                        : lightThemeGreyColor),
                SelectDefaultLang(setStateOverlord: widget.setStateOverlord)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
