import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/customize_buttons.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/select_default_lang.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/text_recognition.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/update_list.dart';
import '/data.dart';
import 'widgets/select_instance.dart';
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
        title: Text(L10n.of(context).settings),
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
                L10n.of(context).instances,
                style: textStyle,
              ),
              line,
              SelectInstance(),
              UpdateList(),
              const SizedBox(height: 20),
              Text(
                L10n.of(context).appearance,
                style: textStyle,
              ),
              line,
              SelectTheme(),
              CustomizeButtons(),
              const SizedBox(height: 20),
              Text(
                L10n.of(context).translation,
                style: textStyle,
              ),
              line,
              TextRecognition(),
              SelectDefaultLang(),
            ],
          ),
        ),
      ),
    );
  }
}
