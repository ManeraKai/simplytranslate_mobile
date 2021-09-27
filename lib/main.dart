import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:clipboard_listener/clipboard_listener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simplytranslate/screens/about_screen.dart';
import './data.dart';
import 'google/google_translate_widget.dart';
import 'screens/settings/settings_screen.dart';
import 'widgets/keyboard_visibility.dart';

bool callSharedText = false;
var themeTranslation;

Future<void> getSharedText(
  setStateParent,
  Future<String> Function({
    required String input,
    required String fromLanguageValue,
    required String toLanguageValue,
  })
      translateParent,
) async {
  try {
    var answer = await methodChannel.invokeMethod('getText');
    if (answer != '') {
      setStateParent(() {
        translationInput = answer.toString();
        googleTranslationInputController.text = translationInput;
        loading = true;
      });

      final translatedText = await translateParent(
          input: translationInput,
          fromLanguageValue: 'Autodetect',
          toLanguageValue: toLanguageValueShareDefault);
      setStateParent(() {
        googleTranslationOutput = translatedText;
        loading = false;
      });
    }
  } catch (_) {
    setStateParent(() {
      loading = false;
    });
  }
}

void main(List<String> args) async {
  await GetStorage.init();

  var sessionInstances = session.read('instances');
  if (sessionInstances != null) {
    List<String> sessionInstancesString = [];
    for (var item in sessionInstances) {
      sessionInstancesString.add(item.toString());
    }
    instances = sessionInstancesString;
  }

  instance = session.read('instance_mode').toString() != 'null'
      ? session.read('instance_mode').toString()
      : instance;

  customUrl = session.read('customInstance') != null
      ? session.read('customInstance').toString()
      : '';
  customUrlController.text = customUrl;
  customInstance = customUrl;

  var themeSession = session.read('theme').toString();
  if (themeSession != 'null') {
    if (themeSession == 'system') {
      themeRadio = AppTheme.system;
      theme = SchedulerBinding.instance!.window.platformBrightness;
    } else if (themeSession == 'light') {
      themeRadio = AppTheme.light;
      theme = Brightness.light;
    } else if (themeSession == 'dark') {
      themeRadio = AppTheme.dark;
      theme = Brightness.dark;
    }
  }
  var _clipData =
      (await Clipboard.getData(Clipboard.kTextPlain))?.text.toString();
  if (_clipData == '' || _clipData == null)
    isClipboardEmpty = true;
  else
    isClipboardEmpty = false;

  packageInfo = await PackageInfo.fromPlatform();

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    ClipboardListener.addListener(() async {
      var _clipData =
          (await Clipboard.getData(Clipboard.kTextPlain))?.text.toString();
      if (_clipData == '' || _clipData == null) {
        if (!isClipboardEmpty) {
          setState(() {
            isClipboardEmpty = true;
          });
        }
      } else {
        if (isClipboardEmpty) {
          setState(() {
            isClipboardEmpty = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    ClipboardListener.removeListener(() {});
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        callSharedText = true;
      });

      Clipboard.getData(Clipboard.kTextPlain).then((value) {
        print('trying');
        if (value != null) {
          final valueString = value.text.toString();
          if (valueString == '') {
            setState(() => isClipboardEmpty = true);
          } else {
            setState(() => isClipboardEmpty = false);
          }
        } else {
          setState(() => isClipboardEmpty = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme(
          primary: greenColor,
          primaryVariant: greenColor,
          secondary: greenColor,
          secondaryVariant: greenColor,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Color(0xffa9a9a9), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Color(0xffa9a9a9), width: 1.5),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: BorderSide(
            width: 1.5,
            color: Color(0xffa9a9a9),
          ),
        )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          behavior: SnackBarBehavior.floating,
        ),
        toggleableActiveColor: greenColor,
        iconTheme: IconThemeData(color: greenColor),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme(
          primary: greenColor,
          primaryVariant: greenColor,
          secondary: greenColor,
          secondaryVariant: greenColor,
          surface: Color(0xff131618),
          background: Color(0xff131618),
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.redAccent,
          onSurface: Colors.white,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Color(0xff212529),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Color(0xff131618),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Color(0xff495057), width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(color: Color(0xff495057), width: 1.5),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xff131618),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
          side: BorderSide(
            width: 1.5,
            color: Color(0xff495057),
          ),
        )),
        toggleableActiveColor: greenColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                else if (states.contains(MaterialState.disabled))
                  return lightgreyColor;
                return greenColor; // Use the component's default.
              },
            ),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          behavior: SnackBarBehavior.floating,
        ),
      ),
      themeMode: theme == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      title: 'Simply Translate',
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: KeyboardVisibilityBuilder(
            builder: (context, child, isKeyboardVisible) => Builder(
              builder: (context) {
                if (MediaQuery.of(context).orientation == Orientation.landscape)
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: []);
                else
                  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                      overlays: SystemUiOverlay.values);
                if (isKeyboardVisible &&
                    MediaQuery.of(context).orientation ==
                        Orientation.landscape) {
                  return SizedBox.shrink();
                } else {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: AppBar(
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(2),
                        child: Container(height: 2, color: greenColor),
                      ),
                      actions: [
                        PopupMenuButton(
                          icon: Icon(Icons.more_vert, color: Colors.white),
                          // color: theme == Brightness.dark
                          //     ? secondgreyColor
                          //     : Colors.white,
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<String>(
                              value: 'settings',
                              child: Text(
                                AppLocalizations.of(context)!.settings,
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: 'about',
                              child: Text(
                                AppLocalizations.of(context)!.about,
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            if (value == 'settings') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Settings(setState)),
                              );
                            } else if (value == 'about') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AboutScreen()),
                              );
                            }
                          },
                        ),
                      ],
                      elevation: 3,
                      iconTheme: IconThemeData(),
                      title: Text(
                        'Simply Translate',
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
        body: MainPageLocalization(),
      ),
    );
  }
}

class MainPageLocalization extends StatelessWidget {
  const MainPageLocalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    themeTranslation = {
      'dark': AppLocalizations.of(context)!.dark,
      'light': AppLocalizations.of(context)!.light,
      'system': AppLocalizations.of(context)!.follow_system,
    };

    final themeSession = session.read('theme').toString();
    if (themeSession != 'null')
      themeValue = themeTranslation[themeSession];
    else
      themeValue = themeTranslation['system'];

    selectLanguagesMap = {
      AppLocalizations.of(context)!.afrikaans: "Afrikaans",
      AppLocalizations.of(context)!.albanian: "Albanian",
      AppLocalizations.of(context)!.amharic: "Amharic",
      AppLocalizations.of(context)!.arabic: "Arabic",
      AppLocalizations.of(context)!.armenian: "Armenian",
      AppLocalizations.of(context)!.azerbaijani: "Azerbaijani",
      AppLocalizations.of(context)!.basque: "Basque",
      AppLocalizations.of(context)!.belarusian: "Belarusian",
      AppLocalizations.of(context)!.bengali: "Bengali",
      AppLocalizations.of(context)!.bosnian: "Bosnian",
      AppLocalizations.of(context)!.bulgarian: "Bulgarian",
      AppLocalizations.of(context)!.catalan: "Catalan",
      AppLocalizations.of(context)!.cebuano: "Cebuano",
      AppLocalizations.of(context)!.chichewa: "Chichewa",
      AppLocalizations.of(context)!.chinese: "Chinese",
      AppLocalizations.of(context)!.corsican: "Corsican",
      AppLocalizations.of(context)!.croatian: "Croatian",
      AppLocalizations.of(context)!.czech: "Czech",
      AppLocalizations.of(context)!.danish: "Danish",
      AppLocalizations.of(context)!.dutch: "Dutch",
      AppLocalizations.of(context)!.english: "English",
      AppLocalizations.of(context)!.esperanto: "Esperanto",
      AppLocalizations.of(context)!.estonian: "Estonian",
      AppLocalizations.of(context)!.filipino: "Filipino",
      AppLocalizations.of(context)!.finnish: "Finnish",
      AppLocalizations.of(context)!.french: "French",
      AppLocalizations.of(context)!.frisian: "Frisian",
      AppLocalizations.of(context)!.galician: "Galician",
      AppLocalizations.of(context)!.georgian: "Georgian",
      AppLocalizations.of(context)!.german: "German",
      AppLocalizations.of(context)!.greek: "Greek",
      AppLocalizations.of(context)!.gujarati: "Gujarati",
      AppLocalizations.of(context)!.haitian_creole: "Haitian Creole",
      AppLocalizations.of(context)!.hausa: "Hausa",
      AppLocalizations.of(context)!.hawaiian: "Hawaiian",
      AppLocalizations.of(context)!.hebrew: "Hebrew",
      AppLocalizations.of(context)!.hindi: "Hindi",
      AppLocalizations.of(context)!.hmong: "Hmong",
      AppLocalizations.of(context)!.hungarian: "Hungarian",
      AppLocalizations.of(context)!.icelandic: "Icelandic",
      AppLocalizations.of(context)!.igbo: "Igbo",
      AppLocalizations.of(context)!.indonesian: "Indonesian",
      AppLocalizations.of(context)!.irish: "Irish",
      AppLocalizations.of(context)!.italian: "Italian",
      AppLocalizations.of(context)!.japanese: "Japanese",
      AppLocalizations.of(context)!.javanese: "Javanese",
      AppLocalizations.of(context)!.kannada: "Kannada",
      AppLocalizations.of(context)!.kazakh: "Kazakh",
      AppLocalizations.of(context)!.khmer: "Khmer",
      AppLocalizations.of(context)!.kinyarwanda: "Kinyarwanda",
      AppLocalizations.of(context)!.korean: "Korean",
      AppLocalizations.of(context)!.kurdish_kurmanji: "Kurdish (Kurmanji)",
      AppLocalizations.of(context)!.kyrgyz: "Kyrgyz",
      AppLocalizations.of(context)!.lao: "Lao",
      AppLocalizations.of(context)!.latin: "Latin",
      AppLocalizations.of(context)!.latvian: "Latvian",
      AppLocalizations.of(context)!.lithuanian: "Lithuanian",
      AppLocalizations.of(context)!.luxembourgish: "Luxembourgish",
      AppLocalizations.of(context)!.macedonian: "Macedonian",
      AppLocalizations.of(context)!.malagasy: "Malagasy",
      AppLocalizations.of(context)!.malay: "Malay",
      AppLocalizations.of(context)!.malayalam: "Malayalam",
      AppLocalizations.of(context)!.maltese: "Maltese",
      AppLocalizations.of(context)!.maori: "Maori",
      AppLocalizations.of(context)!.marathi: "Marathi",
      AppLocalizations.of(context)!.mongolian: "Mongolian",
      AppLocalizations.of(context)!.myanmar_burmese: "Myanmar (Burmese)",
      AppLocalizations.of(context)!.nepali: "Nepali",
      AppLocalizations.of(context)!.norwegian: "Norwegian",
      AppLocalizations.of(context)!.odia_oriya: "Odia (Oriya)",
      AppLocalizations.of(context)!.pashto: "Pashto",
      AppLocalizations.of(context)!.persian: "Persian",
      AppLocalizations.of(context)!.polish: "Polish",
      AppLocalizations.of(context)!.portuguese: "Portuguese",
      AppLocalizations.of(context)!.punjabi: "Punjabi",
      AppLocalizations.of(context)!.romanian: "Romanian",
      AppLocalizations.of(context)!.russian: "Russian",
      AppLocalizations.of(context)!.samoan: "Samoan",
      AppLocalizations.of(context)!.scots_gaelic: "Scots Gaelic",
      AppLocalizations.of(context)!.serbian: "Serbian",
      AppLocalizations.of(context)!.sesotho: "Sesotho",
      AppLocalizations.of(context)!.shona: "Shona",
      AppLocalizations.of(context)!.sindhi: "Sindhi",
      AppLocalizations.of(context)!.sinhala: "Sinhala",
      AppLocalizations.of(context)!.slovak: "Slovak",
      AppLocalizations.of(context)!.slovenian: "Slovenian",
      AppLocalizations.of(context)!.somali: "Somali",
      AppLocalizations.of(context)!.spanish: "Spanish",
      AppLocalizations.of(context)!.sundanese: "Sundanese",
      AppLocalizations.of(context)!.swahili: "Swahili",
      AppLocalizations.of(context)!.swedish: "Swedish",
      AppLocalizations.of(context)!.tajik: "Tajik",
      AppLocalizations.of(context)!.tamil: "Tamil",
      AppLocalizations.of(context)!.tatar: "Tatar",
      AppLocalizations.of(context)!.telugu: "Telugu",
      AppLocalizations.of(context)!.thai: "Thai",
      AppLocalizations.of(context)!.turkish: "Turkish",
      AppLocalizations.of(context)!.turkmen: "Turkmen",
      AppLocalizations.of(context)!.ukrainian: "Ukrainian",
      AppLocalizations.of(context)!.urdu: "Urdu",
      AppLocalizations.of(context)!.uyghur: "Uyghur",
      AppLocalizations.of(context)!.uzbek: "Uzbek",
      AppLocalizations.of(context)!.vietnamese: "Vietnamese",
      AppLocalizations.of(context)!.welsh: "Welsh",
      AppLocalizations.of(context)!.xhosa: "Xhosa",
      AppLocalizations.of(context)!.yiddish: "Yiddish",
      AppLocalizations.of(context)!.yoruba: "Yoruba",
      AppLocalizations.of(context)!.zulu: "Zulu",
    };

    selectLanguages = [];
    selectLanguagesMap.keys.forEach((element) => selectLanguages.add(element));
    selectLanguages.sort();

    fromSelectLanguagesMap = selectLanguagesMap;

    selectLanguagesFrom = [];
    selectLanguagesMap.keys
        .forEach((element) => selectLanguagesFrom.add(element));
    selectLanguagesFrom.sort();
    fromSelectLanguagesMap[AppLocalizations.of(context)!.autodetect] =
        "Autodetect";
    selectLanguagesFrom.insert(
      0,
      AppLocalizations.of(context)!.autodetect,
    );

    fromLanguage = AppLocalizations.of(context)!.english;
    toLanguage = AppLocalizations.of(context)!.arabic;
    toLanguageShareDefault = AppLocalizations.of(context)!.arabic;

    if (session.read('from_language').toString() != 'null') {
      var sessionData = session.read('from_language').toString();
      fromLanguage = fromSelectLanguagesMap.entries
          .firstWhere((element) => element.value == sessionData)
          .key;
      // fromLanguageValue = fromSelectLanguagesMap[sessionData];
      fromLanguageValue = sessionData;
    }
    if (session.read('to_language').toString() != 'null') {
      var sessionData = session.read('to_language').toString();
      toLanguage = selectLanguagesMap.entries
          .firstWhere((element) => element.value == sessionData)
          .key;
      // toLanguageValue = selectLanguagesMap[sessionData];
      toLanguageValue = sessionData;
    }

    if (session.read('to_language_share_default').toString() != 'null') {
      var sessionData = session.read('to_language_share_default').toString();
      toLanguageShareDefault = selectLanguagesMap.entries
          .firstWhere((element) => element.value == sessionData)
          .key;
      // toLanguageValueShareDefault = selectLanguagesMap[sessionData];
      toLanguageValueShareDefault = sessionData;
    }

    return MainPage();
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getSharedText(setState, translate);
    super.initState();
  }

  @override
  void dispose() {
    customUrlController.dispose();
    super.dispose();
  }

  Future<String> translate({
    required String input,
    required String fromLanguageValue,
    required String toLanguageValue,
  }) async {
    if (input.length <= 5000) {
      final url;
      if (instance == 'custom') {
        url = Uri.parse(customInstance);
      } else if (instance == 'random')
        url = Uri.parse(instances[Random().nextInt(instances.length)]);
      else
        url = Uri.parse(instance);
      // default https://

      showInternetError() {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.no_internet,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                      ),
                    )
                  ],
                ));
      }

      showInstanceError() {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.something_went_wrong,
                  ),
                  content: Text(
                    AppLocalizations.of(context)!.check_instance,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        AppLocalizations.of(context)!.ok,
                      ),
                    )
                  ],
                ));
      }

      try {
        final response = await http.post(url, body: {
          'from_language': fromLanguageValue,
          'to_language': toLanguageValue,
          'input': input,
        });

        if (response.statusCode == 200) {
          final x = parse(response.body)
              .getElementsByClassName('translation')[0]
              .innerHtml;
          return x;
        } else
          showInstanceError();
        return 'Request failed with status: ${response.statusCode}.';
      } catch (err) {
        try {
          final result = await InternetAddress.lookup('exmaple.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            showInstanceError();
            throw ('Instnace not valid');
          }
        } on SocketException catch (_) {
          showInternetError();
          throw ('No internet');
        }
        return '';
      }
    } else
      return '';
  }

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    if (callSharedText) {
      getSharedText(setState, translate);
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child:
          GoogleTranslate(translateParent: translate, setStateParent: setState),
    );
  }
}
