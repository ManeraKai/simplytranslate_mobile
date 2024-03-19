import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_screen_button.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
        title: Text(i18n().main.about),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                i18n().main.help,
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.favorite,
                iconColor: Colors.redAccent,
                title: i18n().main.contribute,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://github.com/ManeraKai/simplytranslate_mobile',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              AboutButton(
                icon: Icons.attach_money_rounded,
                iconColor: Colors.greenAccent,
                title: i18n().main.donate,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://manerakai.github.io/simplytranslate_mobile/donate.html',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              AboutButton(
                icon: Icons.report,
                iconColor: Colors.red,
                title: i18n().main.report_bug,
                onTap: () => launchUrl(
                  Uri.parse('https://github.com/ManeraKai/simplytranslate_mobile/issues'),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                i18n().main.about,
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.web,
                iconColor: Colors.amber,
                title: i18n().main.website,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://manerakai.github.io/simplytranslate_mobile/',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
              ),
              AboutButton(
                icon: Icons.info_outline,
                iconColor: theme == Brightness.dark ? Colors.white : Colors.black,
                title: i18n().main.version,
                content: packageInfo.version,
                onTap: () => Clipboard.setData(ClipboardData(text: packageInfo.version)).then(
                  (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      width: 160,
                      content: Text(
                        i18n().main.copied_to_clipboard,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              AboutButton(
                icon: Icons.copyright,
                iconColor: theme == Brightness.dark ? Colors.white : Colors.black,
                title: i18n().main.license,
                content: 'GPL-3.0 License',
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://github.com/ManeraKai/simplytranslate_mobile/blob/main/LICENSE',
                  ),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
