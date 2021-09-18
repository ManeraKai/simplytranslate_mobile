import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '../data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: lightgreyColor,
            height: 2,
          ),
        ),
        backgroundColor: theme == Brightness.dark ? greyColor : whiteColor,
        iconTheme: IconThemeData(
            color: theme == Brightness.dark ? whiteColor : Colors.black),
        title: Text(AppLocalizations.of(context)!.about,
            style: theme == Brightness.dark
                ? TextStyle(color: whiteColor)
                : TextStyle(color: Colors.black)),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.about_description,
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
