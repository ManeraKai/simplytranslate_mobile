import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.about,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AboutButton(
                icon: Icons.groups,
                iconColor: Colors.blue,
                title: AppLocalizations.of(context)!.team,
                content: AppLocalizations.of(context)!.team_summary,
                onTap: () => launch(
                    'https://github.com/ManeraKai/simplytranslate_mobile/graphs/contributors'),
              ),
              AboutButton(
                icon: Icons.favorite,
                iconColor: Colors.red,
                title: AppLocalizations.of(context)!.contribute,
                content: AppLocalizations.of(context)!.contribute_summary,
                onTap: () => launch(
                    'https://github.com/ManeraKai/simplytranslate_mobile'),
              ),
              AboutButton(
                  icon: Icons.info,
                  iconColor: Colors.orange,
                  title: AppLocalizations.of(context)!.version,
                  content: packageInfo.version,
                  onTap: () => Clipboard.setData(
                              ClipboardData(text: packageInfo.version))
                          .then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            width: 160,
                            content: Text(
                              AppLocalizations.of(context)!.copied_to_clipboard,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )),
              AboutButton(
                icon: Icons.copyright,
                iconColor:
                    theme == Brightness.dark ? Colors.white : Colors.black,
                title: AppLocalizations.of(context)!.license,
                content: 'GPL-3.0 License',
                onTap: () => launch(
                  'https://github.com/ManeraKai/simplytranslate_mobile/blob/main/LICENSE',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AboutButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String content;
  final void Function() onTap;

  const AboutButton({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(
          children: [
            Container(
              child: loading
                  ? Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(5),
                      child: CircularProgressIndicator(),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 45,
                    ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 18)),
                    Text(
                      content,
                      style: TextStyle(
                        fontSize: 18,
                        color: theme == Brightness.dark
                            ? Colors.white54
                            : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
