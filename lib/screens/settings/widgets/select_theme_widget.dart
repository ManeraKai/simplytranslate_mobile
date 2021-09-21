import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../../../data.dart';

class SelectTheme extends StatelessWidget {
  final setStateOverlord;
  const SelectTheme({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _darkFunc(setState) {
      setState(() {
        themeRadio = AppTheme.dark;
      });
      setStateOverlord(() {
        session.write('theme', 'dark');
        themeValue = 'dark';
        theme = Brightness.dark;
      });
    }

    _lightFunc(setState) {
      setState(() {
        themeRadio = AppTheme.light;
      });
      setStateOverlord(() {
        session.write('theme', 'light');
        themeValue = 'light';
        theme = Brightness.light;
      });
    }

    _systemFunc(setState) {
      setState(() {
        themeRadio = AppTheme.system;
      });
      setStateOverlord(() {
        session.write('theme', 'system');
        themeValue = 'system';
        theme = MediaQuery.of(context).platformBrightness;
      });
    }

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Container(
                  alignment: Alignment.center,
                  height: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () => _darkFunc(setState),
                        title: Text(AppLocalizations.of(context)!.dark),
                        leading: Radio<AppTheme>(
                          value: AppTheme.dark,
                          groupValue: themeRadio,
                          onChanged: (_) => _darkFunc(setState),
                        ),
                      ),
                      ListTile(
                        onTap: () => _lightFunc(setState),
                        title: Text(AppLocalizations.of(context)!.light),
                        leading: Radio<AppTheme>(
                          value: AppTheme.light,
                          groupValue: themeRadio,
                          onChanged: (_) => _lightFunc(setState),
                        ),
                      ),
                      ListTile(
                          onTap: () => _systemFunc(setState),
                          title:
                              Text(AppLocalizations.of(context)!.follow_system),
                          leading: Radio<AppTheme>(
                              value: AppTheme.system,
                              groupValue: themeRadio,
                              onChanged: (_) => _systemFunc(setState)))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: Icon(
              Icons.brightness_2,
              color: theme == Brightness.dark ? Colors.white : greenColor,
              size: 45,
            )),
            SizedBox(width: 10),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.theme,
                      style: TextStyle(fontSize: 18)),
                  Text(
                    themeValue,
                    style: TextStyle(
                        fontSize: 18,
                        color: theme == Brightness.dark
                            ? Colors.white54
                            : Colors.black54),
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
