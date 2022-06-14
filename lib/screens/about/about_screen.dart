import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_screen_button.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String dropdownValue = 'Buy me a coffee';
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
        title: Text(L10n.of(context).about),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L10n.of(context).help,
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.favorite,
                iconColor: Colors.redAccent,
                title: L10n.of(context).contribute,
                content: L10n.of(context).contribute_summary,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://github.com/ManeraKai/simplytranslate_mobile',
                  ),
                ),
              ),
              AboutButton(
                icon: Icons.translate_rounded,
                iconColor: Colors.blue,
                title: L10n.of(context).translate,
                content: L10n.of(context).translate_summary,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://hosted.weblate.org/projects/simplytranslate-mobile/',
                  ),
                ),
              ),
              AboutButton(
                icon: Icons.attach_money_rounded,
                iconColor: Colors.greenAccent,
                title: L10n.of(context).donate,
                content: L10n.of(context).donate_summary,
                onTap: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actionsAlignment: MainAxisAlignment.center,
                      actions: [
                        InkWell(
                          onTap: () => launchUrl(
                            Uri.parse(
                              "https://www.buymeacoffee.com/manerakai",
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                child: Image.asset(
                                  theme == Brightness.dark
                                      ? "assets/about/bmc_dark.png"
                                      : "assets/about/bmc.png",
                                  scale: 2,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  'Buy me a coffee',
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1.25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => launchUrl(
                            Uri.parse(
                              "https://liberapay.com/simplytranslate_mobile",
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 64,
                                child: Image.asset(
                                  theme == Brightness.dark
                                      ? "assets/about/liberapay_dark.png"
                                      : "assets/about/liberapay.png",
                                  scale: 2,
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  L10n.of(context).liberapay,
                                  style: TextStyle(
                                    fontSize: 18,
                                    letterSpacing: 1.25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              AboutButton(
                icon: Icons.report,
                iconColor: Colors.red,
                title: L10n.of(context).report_bug,
                content: L10n.of(context).report_bug_summary,
                onTap: () => launchUrl(
                  Uri.parse(
                      'https://github.com/ManeraKai/simplytranslate_mobile/issues'),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                L10n.of(context).about,
                style: textStyle,
              ),
              line,
              AboutButton(
                icon: Icons.web,
                iconColor: Colors.amber,
                title: L10n.of(context).website,
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://manerakai.github.io/simplytranslate_mobile/',
                  ),
                ),
              ),
              AboutButton(
                icon: Icons.info_outline,
                iconColor:
                    theme == Brightness.dark ? Colors.white : Colors.black,
                title: L10n.of(context).version,
                content: packageInfo.version,
                onTap: () =>
                    Clipboard.setData(ClipboardData(text: packageInfo.version))
                        .then(
                  (_) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 2),
                      width: 160,
                      content: Text(
                        L10n.of(context).copied_to_clipboard,
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
                title: L10n.of(context).license,
                content: 'GPL-3.0 License',
                onTap: () => launchUrl(
                  Uri.parse(
                    'https://github.com/ManeraKai/simplytranslate_mobile/blob/main/LICENSE',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
