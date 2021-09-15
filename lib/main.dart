import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import './data.dart';
import './widgets/settings_widget.dart';
import './widgets/translate_button_widget.dart';
import './widgets/translation_input_widget.dart';
import './widgets/translation_output_widget.dart';
import './widgets/from_lang_widget.dart';
import './widgets/to_lang_widget.dart';
import './widgets/switch_lang_widget.dart';

void main(List<String> args) async {
  //------ Setting session variables up --------//
  await GetStorage.init();
  instance = session.read('instance_mode').toString() != 'null'
      ? session.read('instance_mode').toString()
      : instance;

  customUrl = session.read('url') != null ? session.read('url').toString() : '';
  customUrlController.text = customUrl;
  //--------------------------------------------//

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: whiteColor,
        ),
        textTheme: const TextTheme(
            bodyText2: const TextStyle(color: whiteColor),
            subtitle1: const TextStyle(color: whiteColor, fontSize: 16),
            headline6: const TextStyle(color: whiteColor)),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(greyColor),
            overlayColor: MaterialStateProperty.all(greyColor),
            foregroundColor: MaterialStateProperty.all(whiteColor),
          ),
        ),
      ),
      title: 'Simply Translate',
      home: Scaffold(
        backgroundColor: secondgreyColor,
        body: MainPageLocalization(),
      ),
    );
  }
}

class MainPageLocalization extends StatelessWidget {
  const MainPageLocalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    selectLanguagesFrom.insert(0, AppLocalizations.of(context)!.autodetect);

    fromLanguage = AppLocalizations.of(context)!.english;
    toLanguage = AppLocalizations.of(context)!.arabic;

    if (session.read('from_language').toString() != 'null')
      fromLanguage = session.read('from_language').toString();
    if (session.read('to_language').toString() != 'null')
      toLanguage = session.read('to_language').toString();

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
  void dispose() {
    customUrlController.dispose();
    super.dispose();
  }

  Future<String> translate(String input) async {
    final url;
    if (instance == 'custom') {
      if (customInstance.endsWith('/')) {
        // trimming last slash
        customInstance = customInstance.substring(0, customInstance.length - 1);
      }
      if (customInstance.startsWith('https://')) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');
        // custom https://
      } else if (customInstance.startsWith('http://')) {
        // http://
        url = Uri.http(customInstance.substring(7), '/');
      } else {
        url = Uri.https(customInstance, '/');
        // custom else https://
      }
    } else {
      url = Uri.https(instances[instanceIndex].toString().substring(8), '/');
      // default https://
    }

    showInternetError() {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: secondgreyColor,
                title: Text(AppLocalizations.of(context)!.no_internet),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.ok),
                  )
                ],
              ));
    }

    showInstanceError() {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: secondgreyColor,
                title: Text(AppLocalizations.of(context)!.something_went_wrong),
                content: Text(AppLocalizations.of(context)!.check_instance),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.ok),
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
        translationOutput = x;
        return x;
      } else
        showInstanceError();
      return 'Request failed with status: ${response.statusCode}.';
    } catch (err) {
      try {
        final result = await InternetAddress.lookup('exmaple.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          showInstanceError();
        }
      } on SocketException catch (_) {
        showInternetError();
      }
      return 'something went wrong buddy.';
    }
  }

  Future<void> checkInstance() async {
    setState(() => checkLoading = true);

    final url;
    var tmpUrl = '';
    if (instance == 'custom') {
      tmpUrl = customInstance;
      if (customInstance.endsWith('/'))
        // trimming last slash
        customInstance = customInstance.substring(0, customInstance.length - 1);

      if (customInstance.startsWith('https://')) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');
        // custom https://
      } else if (customInstance.startsWith('http://'))
        // http://
        url = Uri.http(customInstance.substring(7), '/');
      else
        url = Uri.https(customInstance, '/');
      // custom else https://

    } else
      url = Uri.https(instances[instanceIndex].toString().substring(8), '/');
    // default https://

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
            'SimplyTranslate')) {
          session.write('url', tmpUrl);
          setState(() => isCustomInstanceValid = customInstanceValidation.True);
        } else
          setState(
              () => isCustomInstanceValid = customInstanceValidation.False);
      } else
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
    } catch (err) {
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
    }
    setState(() => checkLoading = false);
    return;
  }

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FromLang(),
                  SwitchLang(
                      setStateParent: setState, translateParent: translate),
                  ToLang(),
                ],
              ),
              const SizedBox(height: 10),
              TranslationInput(
                  setStateParent: setState, translateParent: translate),
              const SizedBox(height: 10),
              TranslationOutput(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TranslateButton(
                      setStateParent: setState, translateParent: translate),
                ],
              ),
              const SizedBox(height: 20),
              Settings(checkInstanceParent: checkInstance),
            ],
          ),
        ),
      ),
    );
  }
}
