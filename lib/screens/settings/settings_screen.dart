import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data.dart';
import 'widgets/select_instance_widget.dart';
import 'widgets/select_theme_widget.dart';

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
          title: Text('Settings'),
          elevation: 3,
          iconTheme: IconThemeData(
              color: theme == Brightness.dark ? whiteColor : Colors.white),
          backgroundColor: theme == Brightness.dark ? greyColor : greenColor,
        ),
        backgroundColor:
            theme == Brightness.dark ? secondgreyColor : whiteColor,
        body: SingleChildScrollView(
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectInstance(setStateOverlord: widget.setStateOverlord),
                    SelectTheme(setStateOverlord: widget.setStateOverlord),
                  ])),
        ),
      ),
    );
  }
}
