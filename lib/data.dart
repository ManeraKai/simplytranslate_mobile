import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);
const greenColor = Color(0xff3fb274);
const lightThemeGreyColor = Color(0xffa9a9a9);

ThemeData materialAppDarkTheme(BuildContext context) {
  return ThemeData(
    colorScheme: ColorScheme(
      primary: greenColor,
      primaryVariant: greenColor,
      secondary: greenColor,
      secondaryVariant: greenColor,
      surface: const Color(0xff131618),
      background: const Color(0xff131618),
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.redAccent,
      onSurface: Colors.white,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: const Color(0xff212529),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xff131618),
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
      backgroundColor: const Color(0xff131618),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: BorderSide(
        width: 1.5,
        color: const Color(0xff495057),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

ThemeData materialAppTheme() {
  return ThemeData(
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
        borderSide: BorderSide(color: const Color(0xffa9a9a9), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: const Color(0xffa9a9a9), width: 1.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      side: BorderSide(width: 1.5, color: const Color(0xffa9a9a9)),
    )),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      behavior: SnackBarBehavior.floating,
    ),
    toggleableActiveColor: greenColor,
    iconTheme: IconThemeData(color: greenColor),
  );
}

var themeRadio = AppTheme.system;

var focus = FocusNode();

String fromLanguageValue = 'English';
String toLanguageValue = 'Arabic';
String toLanguageValueShareDefault = 'Arabic';

String fromLanguage = '';
String toLanguage = '';
String toLanguageShareDefault = '';

String instance = 'random';
int instanceIndex = 0;

String translationInput = '';
String googleTranslationOutput = '';

String customInstance = '';

bool translationInputOpen = false;

enum AppTheme { dark, light, system }

var themeValue = '';

Brightness theme = SchedulerBinding.instance!.window.platformBrightness;

enum customInstanceValidation { False, True, NotChecked }

const methodChannel = MethodChannel('com.simplytranslate_mobile/translate');

bool isClipboardEmpty = true;

late Map selectLanguagesMap;
Map fromSelectLanguagesMap = {};
List selectLanguages = [];
List selectLanguagesFrom = [];

bool loading = false;
bool isTranslationCanceled = false;

final customUrlController = TextEditingController();
final googleTranslationInputController = TextEditingController();

final session = GetStorage();

late final PackageInfo packageInfo;

Future<customInstanceValidation> checkInstance(
    Function setState, String urlValue) async {
  var url;
  try {
    url = Uri.parse(urlValue);
  } catch (_) {
    return customInstanceValidation.False;
  }
  try {
    final response = await http.post(url);
    if (response.statusCode == 200) {
      if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
          'SimplyTranslate')) {
        return customInstanceValidation.True;
      } else {
        return customInstanceValidation.False;
      }
    } else {
      return customInstanceValidation.False;
    }
  } catch (err) {
    return customInstanceValidation.False;
  }
}

Future<void> getSharedText({
  required setStateParent,
  required context,
  required Future<String> translateParent({
    required String input,
    required String fromLanguageValue,
    required String toLanguageValue,
    required BuildContext context,
  }),
}) async {
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
        toLanguageValue: toLanguageValueShareDefault,
        context: context,
      );
      setStateParent(() {
        googleTranslationOutput = translatedText;
        loading = false;
      });
    }
  } catch (_) {
    setStateParent(() => loading = false);
  }
}

bool isSnackBarVisible = false;

AudioPlayer audioPlayer = AudioPlayer();

Map<dynamic, dynamic> selectLanguagesMapGetter(BuildContext context) {
  return {
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
}

showInstanceError(context) {
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
    ),
  );
}

showInstanceTtsError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.something_went_wrong,
      ),
      content: Text(
        AppLocalizations.of(context)!.check_instnace_tts,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            AppLocalizations.of(context)!.ok,
          ),
        )
      ],
    ),
  );
}

showInternetError(context) {
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
    ),
  );
}

Future<String> translate({
  required String input,
  required String fromLanguageValue,
  required String toLanguageValue,
  required BuildContext context,
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
        showInstanceError(context);
      return 'Request failed with status: ${response.statusCode}.';
    } catch (err) {
      try {
        final result = await InternetAddress.lookup('exmaple.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          showInstanceError(context);
          throw ('Instnace not valid');
        }
      } on SocketException catch (_) {
        showInternetError(context);
        throw ('No internet');
      }
      return '';
    }
  } else
    return '';
}

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
];
