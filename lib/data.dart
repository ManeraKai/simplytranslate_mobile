import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);

final boxDecorationCustom = BoxDecoration(
    color: greyColor,
    border: Border.all(
      color: lightgreyColor,
      width: 2,
      style: BorderStyle.solid,
    ));

String fromLanguageValue = 'English';
String toLanguageValue = 'Arabic';

String fromLanguage = '';
String toLanguage = '';

String instance = 'https://translate.metalune.xyz';
int instanceIndex = 0;

String translationInput = '';
String translationOutput = '';

String customInstance = '';
String customUrl = '';

enum customInstanceValidation {
  False,
  True,
  NotChecked,
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

bool fromLanguageisDefault = true;
bool toLanguageisDefault = true;

bool fromIsFirstClick = false;
bool toIsFirstClick = false;

final session = GetStorage();

final ScrollController leftTextviewScrollController = ScrollController();

final ScrollController rightTextviewScrollController = ScrollController();

String engineSelected = 'google';

var instances = [
  "https://translate.metalune.xyz",
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
