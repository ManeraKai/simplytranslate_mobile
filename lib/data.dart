import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);
const greenColor = Color(0xff3fb274);
const lightThemeGreyColor = Color(0xffa9a9a9);

// var boxDecorationCustomDark = BoxDecoration(
//   color: greyColor,
//   border: Border.all(
//     color: lightgreyColor,
//     width: 1.5,
//     style: BorderStyle.solid,
//   ),
//   borderRadius: BorderRadius.circular(2),
// );

var themeRadio = AppTheme.system;
// var boxDecorationCustomLight = BoxDecoration(
//     color: whiteColor,
//     border: Border.all(
//       color: lightThemeGreyColor,
//       // color: Color(0xff3fb274),
//       width: 1.5,
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(2));

// var boxDecorationCustomLightBlack = BoxDecoration(
//     color: whiteColor,
//     border: Border.all(
//       color: lightThemeGreyColor,
//       width: 1.5,
//       style: BorderStyle.solid,
//     ),
//     borderRadius: BorderRadius.circular(2));

var focus = FocusNode();

String fromLanguageValue = 'English';
String toLanguageValue = 'Arabic';
String toLanguageValueShareDefault = 'Arabic';

String fromLanguage = '';
String toLanguage = '';
String toLanguageShareDefault = '';

String instance = 'https://simplytranslate.org';
int instanceIndex = 0;

String translationInput = '';
String googleTranslationOutput = '';

String customInstance = '';
String customUrl = '';

bool translationInputOpen = false;

enum AppTheme { dark, light, system }

var themeValue = '';

Brightness theme = SchedulerBinding.instance!.window.platformBrightness;

enum customInstanceValidation { False, True, NotChecked }

const methodChannel = MethodChannel('com.simplytranslate/translate');

bool isClipboardEmpty = true;

Map selectLanguagesMap = {};
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

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
];

var supportedLanguages = [
  "Afrikaans",
  "Albanian",
  "Amharic",
  "Arabic",
  "Armenian",
  "Azerbaijani",
  "Basque",
  "Belarusian",
  "Bengali",
  "Bosnian",
  "Bulgarian",
  "Catalan",
  "Cebuano",
  "Chichewa",
  "Chinese",
  "Corsican",
  "Croatian",
  "Czech",
  "Danish",
  "Dutch",
  "English",
  "Esperanto",
  "Estonian",
  "Filipino",
  "Finnish",
  "French",
  "Frisian",
  "Galician",
  "Georgian",
  "German",
  "Greek",
  "Gujarati",
  "Haitian Creole",
  "Hausa",
  "Hawaiian",
  "Hebrew",
  "Hindi",
  "Hmong",
  "Hungarian",
  "Icelandic",
  "Igbo",
  "Indonesian",
  "Irish",
  "Italian",
  "Japanese",
  "Javanese",
  "Kannada",
  "Kazakh",
  "Khmer",
  "Kinyarwanda",
  "Korean",
  "Kurdish (Kurmanji)",
  "Kyrgyz",
  "Lao",
  "Latin",
  "Latvian",
  "Lithuanian",
  "Luxembourgish",
  "Macedonian",
  "Malagasy",
  "Malay",
  "Malayalam",
  "Maltese",
  "Maori",
  "Marathi",
  "Mongolian",
  "Myanmar (Burmese)",
  "Nepali",
  "Norwegian",
  "Odia (Oriya)",
  "Pashto",
  "Persian",
  "Polish",
  "Portuguese",
  "Punjabi",
  "Romanian",
  "Russian",
  "Samoan",
  "Scots Gaelic",
  "Serbian",
  "Sesotho",
  "Shona",
  "Sindhi",
  "Sinhala",
  "Slovak",
  "Slovenian",
  "Somali",
  "Spanish",
  "Sundanese",
  "Swahili",
  "Swedish",
  "Tajik",
  "Tamil",
  "Tatar",
  "Telugu",
  "Thai",
  "Turkish",
  "Turkmen",
  "Ukrainian",
  "Urdu",
  "Uyghur",
  "Uzbek",
  "Vietnamese",
  "Welsh",
  "Xhosa",
  "Yiddish",
  "Yoruba",
  "Zulu"
];
