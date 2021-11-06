import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';

const greyColor = const Color(0xff131618);
const secondgreyColor = const Color(0xff212529);
const greenColor = const Color(0xff3fb274);
const lightGreenColor = const Color(0xff62d195);
const lightThemeGreyColor = const Color(0xffa9a9a9);

bool callSharedText = false;

late BuildContext contextOverlordData;
late void Function(void Function() fn) setStateOverlordData;

var themeRadio = AppTheme.system;

var focus = FocusNode();

String fromLangVal = 'auto';
String toLangVal = '';
String shareLangVal = '';

String instance = 'random';

String googleOutput = '';

String customInstance = '';

late Locale appLocale;

enum AppTheme { dark, light, system }

var themeValue = '';

Brightness theme = SchedulerBinding.instance!.window.platformBrightness;

enum instanceValidation { False, True, NotChecked }

bool isClipboardEmpty = true;

late Map<String, String> toSelLangMap;
late Map<String, String> fromSelLangMap;

bool loading = false;
bool isTranslationCanceled = false;

final customUrlCtrl = TextEditingController();
final googleInCtrl = TextEditingController();

final session = GetStorage();

late final PackageInfo packageInfo;

Future<instanceValidation> checkInstance(String urlValue) async {
  var url;
  try {
    url = Uri.parse(urlValue);
  } catch (_) {
    return instanceValidation.False;
  }
  try {
    final response = await http
        .get(Uri.parse('$url/api/translate?from=en&to=es&text=hello'));

    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.toLowerCase() == 'hola')
        return instanceValidation.True;
      else
        return instanceValidation.False;
    } else
      return instanceValidation.False;
  } catch (err) {
    print(err);
    return instanceValidation.False;
  }
}

Future<void> getSharedText() async {
  const methodChannel = MethodChannel('com.simplytranslate_mobile/translate');
  try {
    final answer = await methodChannel.invokeMethod('getText');
    if (answer != '') {
      final _translationInput = answer.toString();

      setStateOverlordData(() {
        googleInCtrl.text = _translationInput;
        loading = true;
      });

      final translatedText = await translate(
        input: _translationInput,
        fromLang: 'auto',
        toLang: shareLangVal,
        context: contextOverlordData,
      );
      setStateOverlordData(() {
        googleOutput = translatedText;
        loading = false;
      });
    }
  } catch (_) {
    setStateOverlordData(() => loading = false);
  }
}

bool isSnackBarVisible = false;

Map<String, String> selectLanguagesMapGetter(BuildContext context) {
  Map<String, String> mapOne = {
    "af": AppLocalizations.of(context)!.afrikaans,
    "sq": AppLocalizations.of(context)!.albanian,
    "am": AppLocalizations.of(context)!.amharic,
    "ar": AppLocalizations.of(context)!.arabic,
    "hy": AppLocalizations.of(context)!.armenian,
    "az": AppLocalizations.of(context)!.azerbaijani,
    "eu": AppLocalizations.of(context)!.basque,
    "be": AppLocalizations.of(context)!.belarusian,
    "bn": AppLocalizations.of(context)!.bengali,
    "bs": AppLocalizations.of(context)!.bosnian,
    "bg": AppLocalizations.of(context)!.bulgarian,
    "ca": AppLocalizations.of(context)!.catalan,
    "ceb": AppLocalizations.of(context)!.cebuano,
    "ny": AppLocalizations.of(context)!.chichewa,
    "zh-CN": AppLocalizations.of(context)!.chinese,
    "co": AppLocalizations.of(context)!.corsican,
    "hr": AppLocalizations.of(context)!.croatian,
    "cs": AppLocalizations.of(context)!.czech,
    "da": AppLocalizations.of(context)!.danish,
    "nl": AppLocalizations.of(context)!.dutch,
    "en": AppLocalizations.of(context)!.english,
    "eo": AppLocalizations.of(context)!.esperanto,
    "et": AppLocalizations.of(context)!.estonian,
    "tl": AppLocalizations.of(context)!.filipino,
    "fi": AppLocalizations.of(context)!.finnish,
    "fr": AppLocalizations.of(context)!.french,
    "fy": AppLocalizations.of(context)!.frisian,
    "gl": AppLocalizations.of(context)!.galician,
    "ka": AppLocalizations.of(context)!.georgian,
    "de": AppLocalizations.of(context)!.german,
    "el": AppLocalizations.of(context)!.greek,
    "gu": AppLocalizations.of(context)!.gujarati,
    "ht": AppLocalizations.of(context)!.haitian_creole,
    "ha": AppLocalizations.of(context)!.hausa,
    "haw": AppLocalizations.of(context)!.hawaiian,
    "iw": AppLocalizations.of(context)!.hebrew,
    "hi": AppLocalizations.of(context)!.hindi,
    "hmn": AppLocalizations.of(context)!.hmong,
    "hu": AppLocalizations.of(context)!.hungarian,
    "is": AppLocalizations.of(context)!.icelandic,
    "ig": AppLocalizations.of(context)!.igbo,
    "id": AppLocalizations.of(context)!.indonesian,
    "ga": AppLocalizations.of(context)!.irish,
    "it": AppLocalizations.of(context)!.italian,
    "ja": AppLocalizations.of(context)!.japanese,
    "jw": AppLocalizations.of(context)!.javanese,
    "kn": AppLocalizations.of(context)!.kannada,
    "kk": AppLocalizations.of(context)!.kazakh,
    "km": AppLocalizations.of(context)!.khmer,
    "rw": AppLocalizations.of(context)!.kinyarwanda,
    "ko": AppLocalizations.of(context)!.korean,
    "ku": AppLocalizations.of(context)!.kurdish_kurmanji,
    "ky": AppLocalizations.of(context)!.kyrgyz,
    "lo": AppLocalizations.of(context)!.lao,
    "la": AppLocalizations.of(context)!.latin,
    "lv": AppLocalizations.of(context)!.latvian,
    "lt": AppLocalizations.of(context)!.lithuanian,
    "lb": AppLocalizations.of(context)!.luxembourgish,
    "mk": AppLocalizations.of(context)!.macedonian,
    "mg": AppLocalizations.of(context)!.malagasy,
    "ms": AppLocalizations.of(context)!.malay,
    "ml": AppLocalizations.of(context)!.malayalam,
    "mt": AppLocalizations.of(context)!.maltese,
    "mi": AppLocalizations.of(context)!.maori,
    "mr": AppLocalizations.of(context)!.marathi,
    "mn": AppLocalizations.of(context)!.mongolian,
    "my": AppLocalizations.of(context)!.myanmar_burmese,
    "ne": AppLocalizations.of(context)!.nepali,
    "no": AppLocalizations.of(context)!.norwegian,
    "or": AppLocalizations.of(context)!.odia_oriya,
    "ps": AppLocalizations.of(context)!.pashto,
    "fa": AppLocalizations.of(context)!.persian,
    "pl": AppLocalizations.of(context)!.polish,
    "pt": AppLocalizations.of(context)!.portuguese,
    "pa": AppLocalizations.of(context)!.punjabi,
    "ro": AppLocalizations.of(context)!.romanian,
    "ru": AppLocalizations.of(context)!.russian,
    "sm": AppLocalizations.of(context)!.samoan,
    "gd": AppLocalizations.of(context)!.scots_gaelic,
    "sr": AppLocalizations.of(context)!.serbian,
    "st": AppLocalizations.of(context)!.sesotho,
    "sn": AppLocalizations.of(context)!.shona,
    "sd": AppLocalizations.of(context)!.sindhi,
    "si": AppLocalizations.of(context)!.sinhala,
    "sk": AppLocalizations.of(context)!.slovak,
    "sl": AppLocalizations.of(context)!.slovenian,
    "so": AppLocalizations.of(context)!.somali,
    "es": AppLocalizations.of(context)!.spanish,
    "su": AppLocalizations.of(context)!.sundanese,
    "sw": AppLocalizations.of(context)!.swahili,
    "sv": AppLocalizations.of(context)!.swedish,
    "tg": AppLocalizations.of(context)!.tajik,
    "ta": AppLocalizations.of(context)!.tamil,
    "tt": AppLocalizations.of(context)!.tatar,
    "te": AppLocalizations.of(context)!.telugu,
    "th": AppLocalizations.of(context)!.thai,
    "tr": AppLocalizations.of(context)!.turkish,
    "tk": AppLocalizations.of(context)!.turkmen,
    "uk": AppLocalizations.of(context)!.ukrainian,
    "ur": AppLocalizations.of(context)!.urdu,
    "ug": AppLocalizations.of(context)!.uyghur,
    "uz": AppLocalizations.of(context)!.uzbek,
    "vi": AppLocalizations.of(context)!.vietnamese,
    "cy": AppLocalizations.of(context)!.welsh,
    "xh": AppLocalizations.of(context)!.xhosa,
    "yi": AppLocalizations.of(context)!.yiddish,
    "yo": AppLocalizations.of(context)!.yoruba,
    "zu": AppLocalizations.of(context)!.zulu,
  };

  Map<String, String> mapTwo = {};

  // ignore: non_constant_identifier_names
  List<String> Valuelist = [];

  for (var i in mapOne.values) Valuelist.add(i);
  Valuelist.sort();

  for (String i in Valuelist)
    for (var x in mapOne.keys) if (mapOne[x] == i) mapTwo[x] = i;

  return mapTwo;
}

showInstanceError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.something_went_wrong),
      content: Text(AppLocalizations.of(context)!.check_instance),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.ok),
        )
      ],
    ),
  );
}

showInstanceTtsError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.something_went_wrong),
      content: Text(AppLocalizations.of(context)!.check_instnace_tts),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.ok),
        )
      ],
    ),
  );
}

showInternetError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.no_internet),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(AppLocalizations.of(context)!.ok),
        )
      ],
    ),
  );
}

Future<String> translate({
  required String input,
  required String fromLang,
  required String toLang,
  required BuildContext context,
}) async {
  final url;
  final args = "from=$fromLang&to=$toLang&text=$input";
  if (instance == 'custom')
    url = Uri.parse('$customInstance/api/translate?$args');
  else if (instance == 'random') {
    final randomInstance = instances[Random().nextInt(instances.length)];
    url = Uri.parse('$randomInstance/api/translate?$args');
  } else
    url = Uri.parse('$instance/api/translate?$args');

  try {
    final response = await http.get(
      url,
    );

    if (response.statusCode == 200)
      return response.body;
    else {
      await showInstanceError(context);
      return '';
    }
  } catch (err) {
    print('something is wrong buddy: $err');
    try {
      final result = await InternetAddress.lookup('exmaple.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        await showInstanceError(context);
        throw ('Instnace not valid');
      }
    } on SocketException catch (_) {
      await showInternetError(context);
      throw ('No internet');
    }
    return '';
  }
}

bool isTtsInCanceled = false;
bool ttsInputloading = false;

bool ttsOutloading = false;
bool isTtsOutputCanceled = false;

bool ttsMaximizedOutputloading = false;
bool isMaximizedTtsOutputCanceled = false;

bool isFirst = true;

late double textFieldHeight;

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
  "https://translate.josias.dev",
  "https://translate.namazso.eu",
  "https://translate.riverside.rocks"
];
