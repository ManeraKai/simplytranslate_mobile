import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate/data.dart';
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
              // SizedBox(height: 10),
              // Text(
              //   'Team:',
              //   style: TextStyle(fontSize: 25),
              // ),
              // Container(
              //     margin: EdgeInsets.symmetric(vertical: 10),
              //     height: 1,
              //     color: theme == Brightness.dark
              //         ? Colors.grey
              //         : lightThemeGreyColor),
              // SizedBox(height: 5),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(50),
              //       child: Image.network(
              //         'https://avatars.githubusercontent.com/u/40805353?v=4',
              //         width: 30,
              //       ),
              //     ),
              //     SizedBox(width: 5),
              //     Container(
              //       height: 30,
              //       child: Text.rich(
              //         TextSpan(
              //           text: 'ManeraKai',
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               launch('https://github.com/ManeraKai');
              //             },
              //           style: TextStyle(
              //             height: 1.5,
              //             fontSize: 18,
              //             color: Colors.blue,
              //             // decoration: TextDecoration.underline,
              //           ),
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // Row(
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(50),
              //       child: Image.network(
              //         'https://avatars.githubusercontent.com/u/47037905?v=4',
              //         width: 30,
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Container(
              //       height: 30,
              //       child: Text.rich(
              //         TextSpan(
              //           text: 'Valdnet',
              //           style: TextStyle(
              //             height: 1.5,
              //             fontSize: 18,
              //             color: Colors.blue,
              //             // decoration: TextDecoration.underline,
              //           ),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () {
              //               launch('https://github.com/Valdnet');
              //             },
              //         ),
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 10),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(50),
              //       child: Image.network(
              //         'https://avatars.githubusercontent.com/u/85929121?v=4',
              //         width: 30,
              //       ),
              //     ),
              //     SizedBox(width: 10),
              //     Container(
              //       height: 30,
              //       child: Text.rich(
              //           TextSpan(
              //             text: 'Agnieszka C (Aga-C)',
              //             style: TextStyle(
              //               height: 1.5,
              //               fontSize: 18,
              //               color: Colors.blue,
              //               // decoration: TextDecoration.underline,
              //             ),
              //             recognizer: TapGestureRecognizer()
              //               ..onTap = () {
              //                 launch('https://github.com/Aga-C');
              //               },
              //           ),
              //           textAlign: TextAlign.center),
              //     ),
              //   ],
              // ),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        child: loading
                            ? Container(
                                height: 45,
                                width: 45,
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator())
                            : Icon(
                                Icons.groups,
                                color: Colors.blue,
                                size: 45,
                              ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.team,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                AppLocalizations.of(context)!.team_summary,
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
                onTap: () => launch(
                    'https://github.com/ManeraKai/simplytranslate-flutter-client/graphs/contributors'),
              ),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        child: loading
                            ? Container(
                                height: 45,
                                width: 45,
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator())
                            : Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 45,
                              ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.contribute,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                AppLocalizations.of(context)!.contribute_summary,
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
                onTap: () => launch(
                    'https://github.com/ManeraKai/simplytranslate-flutter-client'),
              ),
              InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Row(
                      children: [
                        Container(
                          child: loading
                              ? Container(
                                  height: 45,
                                  width: 45,
                                  padding: EdgeInsets.all(5),
                                  child: CircularProgressIndicator())
                              : Icon(
                                  Icons.info,
                                  color: Colors.orange,
                                  size: 45,
                                ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 95,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.version,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  packageInfo.version,
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
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: packageInfo.version))
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
                    );
                  }),
              InkWell(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: Row(
                    children: [
                      Container(
                        child: loading
                            ? Container(
                                height: 45,
                                width: 45,
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator())
                            : Icon(
                                Icons.copyright,
                                color: theme == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                size: 45,
                              ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 95,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.license,
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                'GPL-3.0 License',
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
                onTap: () => launch(
                    'https://github.com/ManeraKai/simplytranslate-flutter-client/blob/main/LICENSE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
