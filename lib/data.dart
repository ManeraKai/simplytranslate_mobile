import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);
const greenColor = Color(0xff3fb274);
const lightThemeGreyColor = Color(0xffa9a9a9);

var boxDecorationCustomDark = BoxDecoration(
  color: greyColor,
  border: Border.all(
    color: lightgreyColor,
    width: 1.5,
    style: BorderStyle.solid,
  ),
  borderRadius: BorderRadius.circular(2),
);

var themeRadio = AppTheme.system;
var boxDecorationCustomLight = BoxDecoration(
    color: whiteColor,
    border: Border.all(
      color: lightThemeGreyColor,
      // color: Color(0xff3fb274),
      width: 1.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(2));

var boxDecorationCustomLightBlack = BoxDecoration(
    color: whiteColor,
    border: Border.all(
      color: lightThemeGreyColor,
      width: 1.5,
      style: BorderStyle.solid,
    ),
    borderRadius: BorderRadius.circular(2));

var focus = FocusNode();
var inputScrollController = ScrollController();

String fromLanguageValue = 'English';
String toLanguageValue = 'Arabic';

String fromLanguage = '';
String toLanguage = '';

String instance = 'https://simplytranslate.org';
int instanceIndex = 0;

String translationInput = '';
String googleTranslationOutput = '';
String libreTranslationOutput = '';

String customInstance = '';
String customUrl = '';

bool translationInputOpen = false;

int translationLength = 0;

enum TranslateEngine { GoogleTranslate, LibreTranslate }

enum AppTheme { dark, light, system }

var themeValue = '';

var themeTranslation;
Brightness theme = SchedulerBinding.instance!.window.platformBrightness;

enum customInstanceValidation { False, True, NotChecked }

bool isThereLibreTranslate = false;

const methodChannel = MethodChannel('com.simplytranslate/translate');

bool callSharedText = false;

Future<void> getSharedText(
    setStateParent, translateParent, translateEngine) async {
  try {
    var answer = await methodChannel.invokeMethod('getText');
    if (answer != '') {
      setStateParent(() {
        translationInput = answer.toString();
        translationInputController.text = translationInput;
        translationLength = translationInputController.text.length;
        loading = true;
      });
      print('translate');

      final translatedText =
          await translateParent(translationInput, translateEngine);
      setStateParent(() {
        translateEngine == TranslateEngine.GoogleTranslate
            ? googleTranslationOutput = translatedText
            : libreTranslationOutput = translatedText;
        loading = false;
      });
    }
  } on PlatformException catch (e) {
    print(e);
  }
}

bool isClipboardEmpty = true;

customInstanceFormatting() {
  final url;
  if (customInstance.endsWith('/'))
    // trimming last slash
    customInstance = customInstance.substring(0, customInstance.length - 1);
  if (customInstance.startsWith('https://')) {
    customInstance = customInstance.trim();
    url =
        Uri.https(customInstance.substring(8), '/', {'engine': engineSelected});
    // custom https://
  } else if (customInstance.startsWith('http://'))
    // http://
    url =
        Uri.http(customInstance.substring(7), '/', {'engine': engineSelected});
  else
    url = Uri.https(customInstance, '/', {'engine': engineSelected});
  // custom else https://
  return url;
}

String customUrlFormatting(url) {
  if (url.endsWith('/'))
    // trimming last slash
    url = url.substring(0, url.length - 1);
  if (url.startsWith('https://')) {
    url = url.trim();
    url = url.substring(8);
    // custom https://
  } else if (url.startsWith('http://'))
    // http://
    url = url.substring(7);
  // custom else https://
  return url;
}

checkLibreTranslatewithRespone(response, {setState}) {
  if (parse(response.body)
      .getElementsByTagName('a')[1]
      .innerHtml
      .contains('LibreTranslate')) {
    if (setState != null)
      setState(() => isThereLibreTranslate = true);
    else
      isThereLibreTranslate = true;
  } else {
    if (setState != null)
      setState(() => isThereLibreTranslate = false);
    else
      isThereLibreTranslate = false;
  }
}

checkLibreTranslate(setStateCustom) async {
  final url;
  if (instance == 'custom') {
    customInstance = customUrlController.text;
    url = customInstanceFormatting();
  } else if (instance == 'random') {
    url = Uri.https(
        instances[instanceIndex].substring(8), '/', {'engine': engineSelected});
  } else
    url = Uri.https(
        instance.toString().substring(8), '/', {'engine': engineSelected});
  // default https://
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      checkLibreTranslatewithRespone(response, setState: setStateCustom);
    }
  } catch (err) {}
}

Future<bool> checkInstance(setState) async {
  setState(() => checkLoading = true);

  final url;
  var tmpUrl = '';
  if (instance == 'custom') {
    url = customInstanceFormatting();
    tmpUrl = customInstance;
  } else
    url = Uri.https(instances[instanceIndex].toString().substring(8), '/',
        {'engine': engineSelected});
  // default https://

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
          'SimplyTranslate')) {
        session.write('url', tmpUrl);
        setState(() => isCustomInstanceValid = customInstanceValidation.True);
      } else
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
      checkLibreTranslatewithRespone(response, setState: setState);
    } else
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
  } catch (err) {
    setState(() => isCustomInstanceValid = customInstanceValidation.False);
  }
  setState(() => checkLoading = false);
  return isCustomInstanceValid == customInstanceValidation.True ? true : false;
}

var isCustomInstanceValid = customInstanceValidation.NotChecked;
Map selectLanguagesMap = {};
Map fromSelectLanguagesMap = {};
List selectLanguages = [];
List selectLanguagesFrom = [];
bool checkLoading = false;
bool loading = false;

final customUrlController = TextEditingController();
final translationInputController = TextEditingController();

bool fromIsFirstClick = false;
bool toIsFirstClick = false;

final session = GetStorage();

final ScrollController leftTextviewScrollController = ScrollController();
final ScrollController rightTextviewScrollController = ScrollController();

String engineSelected = 'google';

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
  "https://almaleehserver.asuscomm.com:447"
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
