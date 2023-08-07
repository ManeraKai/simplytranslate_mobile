import 'package:flutter/material.dart';
import '/data.dart';
import 'widgets/select_theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n().main.settings),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                i18n().main.appearance,
                style: textStyle,
              ),
              line,
              SelectTheme(),
            ],
          ),
        ),
      ),
    );
  }
}
