import 'package:flutter/material.dart';
import '/data.dart';
import 'widgets/select_theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n().main.settings),
        elevation: 3,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                i18n().main.appearance,
                style: textStyle,
              ),
              line,
              SelectTheme(),
            ],
          ),
        ),
      ),
    );
  }
}

Map<String, String> selectLanguagesMapGetter(BuildContext context) {
  Map<String, String> mapOne = {
    "af": i18n().langs.afrikaans,
    "sq": i18n().langs.albanian,
    "am": i18n().langs.amharic,
    "ar": i18n().langs.arabic,
    "hy": i18n().langs.armenian,
    "az": i18n().langs.azerbaijani,
    "eu": i18n().langs.basque,
    "be": i18n().langs.belarusian,
    "bn": i18n().langs.bengali,
    "bs": i18n().langs.bosnian,
    "bg": i18n().langs.bulgarian,
    "ca": i18n().langs.catalan,
    "ceb": i18n().langs.cebuano,
    "ny": i18n().langs.chichewa,
    "zh-CN": i18n().langs.chinese,
    "zh-TW": i18n().langs.traditional_chinese,
    "co": i18n().langs.corsican,
    "hr": i18n().langs.croatian,
    "cs": i18n().langs.czech,
    "da": i18n().langs.danish,
    "nl": i18n().langs.dutch,
    "en": i18n().langs.english,
    "eo": i18n().langs.esperanto,
    "et": i18n().langs.estonian,
    "tl": i18n().langs.filipino,
    "fi": i18n().langs.finnish,
    "fr": i18n().langs.french,
    "fy": i18n().langs.frisian,
    "gl": i18n().langs.galician,
    "ka": i18n().langs.georgian,
    "de": i18n().langs.german,
    "el": i18n().langs.greek,
    "gu": i18n().langs.gujarati,
    "ht": i18n().langs.haitian_creole,
    "ha": i18n().langs.hausa,
    "haw": i18n().langs.hawaiian,
    "iw": i18n().langs.hebrew,
    "hi": i18n().langs.hindi,
    "hmn": i18n().langs.hmong,
    "hu": i18n().langs.hungarian,
    "is": i18n().langs.icelandic,
    "ig": i18n().langs.igbo,
    "id": i18n().langs.indonesian,
    "ga": i18n().langs.irish,
    "it": i18n().langs.italian,
    "ja": i18n().langs.japanese,
    "jw": i18n().langs.javanese,
    "kn": i18n().langs.kannada,
    "kk": i18n().langs.kazakh,
    "km": i18n().langs.khmer,
    "rw": i18n().langs.kinyarwanda,
    "ko": i18n().langs.korean,
    "ku": i18n().langs.kurdish_kurmanji,
    "ky": i18n().langs.kyrgyz,
    "lo": i18n().langs.lao,
    "la": i18n().langs.latin,
    "lv": i18n().langs.latvian,
    "lt": i18n().langs.lithuanian,
    "lb": i18n().langs.luxembourgish,
    "mk": i18n().langs.macedonian,
    "mg": i18n().langs.malagasy,
    "ms": i18n().langs.malay,
    "ml": i18n().langs.malayalam,
    "mt": i18n().langs.maltese,
    "mi": i18n().langs.maori,
    "mr": i18n().langs.marathi,
    "mn": i18n().langs.mongolian,
    "my": i18n().langs.myanmar_burmese,
    "ne": i18n().langs.nepali,
    "no": i18n().langs.norwegian,
    "or": i18n().langs.odia_oriya,
    "ps": i18n().langs.pashto,
    "fa": i18n().langs.persian,
    "pl": i18n().langs.polish,
    "pt": i18n().langs.portuguese,
    "pa": i18n().langs.punjabi,
    "ro": i18n().langs.romanian,
    "ru": i18n().langs.russian,
    "sm": i18n().langs.samoan,
    "gd": i18n().langs.scots_gaelic,
    "sr": i18n().langs.serbian,
    "st": i18n().langs.sesotho,
    "sn": i18n().langs.shona,
    "sd": i18n().langs.sindhi,
    "si": i18n().langs.sinhala,
    "sk": i18n().langs.slovak,
    "sl": i18n().langs.slovenian,
    "so": i18n().langs.somali,
    "es": i18n().langs.spanish,
    "su": i18n().langs.sundanese,
    "sw": i18n().langs.swahili,
    "sv": i18n().langs.swedish,
    "tg": i18n().langs.tajik,
    "ta": i18n().langs.tamil,
    "tt": i18n().langs.tatar,
    "te": i18n().langs.telugu,
    "th": i18n().langs.thai,
    "tr": i18n().langs.turkish,
    "tk": i18n().langs.turkmen,
    "uk": i18n().langs.ukrainian,
    "ur": i18n().langs.urdu,
    "ug": i18n().langs.uyghur,
    "uz": i18n().langs.uzbek,
    "vi": i18n().langs.vietnamese,
    "cy": i18n().langs.welsh,
    "xh": i18n().langs.xhosa,
    "yi": i18n().langs.yiddish,
    "yo": i18n().langs.yoruba,
    "zu": i18n().langs.zulu,
  };

  Map<String, String> mapTwo = {};

  // ignore: non_constant_identifier_names
  List<String> Valuelist = [];

  for (var i in mapOne.values) Valuelist.add(i);
  Valuelist.sort();

  for (String i in Valuelist) for (var x in mapOne.keys) if (mapOne[x] == i) mapTwo[x] = i;

  return mapTwo;
}
