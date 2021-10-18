import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_screen_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget line = Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      height: 1.5,
      color: theme == Brightness.dark ? Colors.white : lightThemeGreyColor,
    );
    const textStyle = const TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.about),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Help',
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.favorite,
                iconColor: Colors.redAccent,
                title: AppLocalizations.of(context)!.contribute,
                content: AppLocalizations.of(context)!.contribute_summary,
                onTap: () => launch(
                  'https://github.com/ManeraKai/simplytranslate_mobile',
                ),
              ),
              AboutButton(
                icon: Icons.translate_rounded,
                iconColor: Colors.blue,
                title: 'Translate',
                content: 'Spread it to the world!',
                onTap: () => launch(
                  'https://poeditor.com/join/project?hash=rV8CGr8NPj',
                ),
              ),
              AboutButton(
                icon: Icons.attach_money_rounded,
                iconColor: Colors.greenAccent,
                title: 'Donate',
                content: 'We appreciate it!',
                onTap: () => launch(
                  'https://liberapay.com/simplytranslate_mobile',
                ),
              ),
              AboutButton(
                icon: Icons.report,
                iconColor: Colors.red,
                title: 'Report a bug',
                content: 'Please let us know.',
                onTap: () => launch(
                  'https://github.com/ManeraKai/simplytranslate_mobile/issues',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'About',
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.web,
                iconColor: Colors.amber,
                title: 'Website',
                content: 'As the title said',
                onTap: () => launch(
                  'https://manerakai.github.io/simplytranslate_mobile/',
                ),
              ),
              AboutButton(
                icon: Icons.groups,
                iconColor: Colors.indigoAccent,
                title: AppLocalizations.of(context)!.team,
                content: AppLocalizations.of(context)!.team_summary,
                onTap: () => launch(
                  'https://github.com/ManeraKai/simplytranslate_mobile#contributers',
                ),
              ),
              AboutButton(
                icon: Icons.info_outline,
                iconColor:
                    theme == Brightness.dark ? Colors.white : Colors.black,
                title: AppLocalizations.of(context)!.version,
                content: packageInfo.version,
                onTap: () =>
                    Clipboard.setData(ClipboardData(text: packageInfo.version))
                        .then(
                  (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      width: 160,
                      content: Text(
                        AppLocalizations.of(context)!.copied_to_clipboard,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              AboutButton(
                icon: Icons.copyright,
                iconColor:
                    theme == Brightness.dark ? Colors.white : Colors.black,
                title: AppLocalizations.of(context)!.license,
                content: 'GPL-3.0 License',
                onTap: () => launch(
                  'https://github.com/ManeraKai/simplytranslate_mobile/blob/main/LICENSE',
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Contact',
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.mail,
                iconColor: Colors.blueGrey,
                title: 'Email',
                content: 'manerakai@protonmail.com',
                onTap: () {
                  Clipboard.setData(
                          ClipboardData(text: 'manerakai@protonmail.com'))
                      .then(
                    (_) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 1),
                        width: 160,
                        content: Text(
                          AppLocalizations.of(context)!.copied_to_clipboard,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
