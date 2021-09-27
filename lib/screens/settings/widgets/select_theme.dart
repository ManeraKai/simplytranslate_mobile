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
        themeValue = AppLocalizations.of(context)!.dark;
        theme = Brightness.dark;
      });
      Navigator.of(context).pop();
    }

    _lightFunc(setState) {
      setState(() {
        themeRadio = AppTheme.light;
      });
      setStateOverlord(() {
        session.write('theme', 'light');
        themeValue = AppLocalizations.of(context)!.light;
        theme = Brightness.light;
      });
      Navigator.of(context).pop();
    }

    _systemFunc(setState) {
      setState(() {
        themeRadio = AppTheme.system;
      });
      setStateOverlord(() {
        session.write('theme', 'system');
        themeValue = AppLocalizations.of(context)!.follow_system;
        theme = MediaQuery.of(context).platformBrightness;
      });
      Navigator.of(context).pop();
    }

    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                contentPadding: EdgeInsets.all(5),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () => _darkFunc(setState),
                        child: Row(
                          children: [
                            Radio<AppTheme>(
                              // activeColor: greenColor,
                              value: AppTheme.dark,
                              groupValue: themeRadio,
                              onChanged: (_) => _darkFunc(setState),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                AppLocalizations.of(context)!.dark,
                              ),
                            ),
                          ],
                        )),
                    InkWell(
                      onTap: () => _lightFunc(setState),
                      child: Row(
                        children: [
                          Radio<AppTheme>(
                            // activeColor: greenColor,
                            value: AppTheme.light,
                            groupValue: themeRadio,
                            onChanged: (_) => _lightFunc(setState),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              AppLocalizations.of(context)!.light,
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                        onTap: () => _systemFunc(setState),
                        child: Row(
                          children: [
                            Radio<AppTheme>(
                                // activeColor: greenColor,
                                value: AppTheme.system,
                                groupValue: themeRadio,
                                onChanged: (_) => _systemFunc(setState)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Text(
                                  AppLocalizations.of(context)!.follow_system),
                            ),
                          ],
                        ))
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.cancel,
                    ),
                  )
                ],
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
              theme == Brightness.dark ? Icons.dark_mode : Icons.light_mode,
              color: theme == Brightness.dark ? Colors.white : greenColor,
              size: 45,
            )),
            SizedBox(width: 10),
            Container(
              width: MediaQuery.of(context).size.width - 95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: TextStyle(fontSize: 18),
                  ),
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
