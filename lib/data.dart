import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:opencv_4/opencv_4.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:path_provider/path_provider.dart';

// const lightGreenColor = const Color(0xff62d195);
const greyColor = const Color(0xff131618);
const secondgreyColor = const Color(0xff212529);
const greenColor = const Color(0xff3fb274);
const lightThemeGreyColor = const Color(0xffa9a9a9);

late BuildContext contextOverlordData;
late void Function(void Function() fn) setStateOverlord;

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

Future<File> byte2File(Uint8List byte) async {
  final tempDir = await getTemporaryDirectory();
  final random = Random().nextInt(10000000);
  final file = await new File('${tempDir.path}/$random.jpg').create();
  file.writeAsBytesSync(byte);
  return file;
}

Widget line = Container(
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      height: 1.5,
      color: theme == Brightness.dark ? Colors.white : lightThemeGreyColor,
    );
Future<File> prepareOCR(File croppedImg) async {
  final Uint8List? preparedByte = await Cv2.prepareOCR(
    pathString: croppedImg.path,
  );

  final prepared = await byte2File(preparedByte!);

  return prepared;

  // final Uint8List? grayByte = await Cv2.cvtColor(
  //   pathFrom: CVPathFrom.GALLERY_CAMERA,
  //   pathString: croppedImg.path,
  //   outputType: Cv2.COLOR_RGB2GRAY,
  // );
  // final gray = await byte2File(grayByte!);

  // final Uint8List? dilateByte = await Cv2.dilate(
  //   pathFrom: CVPathFrom.GALLERY_CAMERA,
  //   pathString: gray.path,
  //   kernelSize: [1, 1],
  // );

  // final dilate = await byte2File(dilateByte!);

  // final Uint8List? contrastByte = await Cv2.contrast(
  //   pathFrom: CVPathFrom.GALLERY_CAMERA,
  //   pathString: dilate.path,
  //   alpha: 2,
  // );

  // final thresh1 = await byte2File(contrastByte!);

  // final thresh1Byte = await Cv2.adaptiveThreshold(
  //   pathFrom: CVPathFrom.GALLERY_CAMERA,
  //   pathString: dilate.path,
  //   maxValue: 255,
  //   adaptiveMethod: Cv2.ADAPTIVE_THRESH_MEAN_C,
  //   thresholdType: Cv2.THRESH_BINARY,
  //   blockSize: 15,
  //   constantValue: 40);

  // final Uint8List? thresh1Byte = await Cv2.threshold(
  //   pathFrom: CVPathFrom.GALLERY_CAMERA,
  //   pathString: dilate.path,
  //   thresholdValue: 0,
  //   maxThresholdValue: 255,
  //   thresholdType: Cv2.THRESH_TOZERO,
  // );

  // final thresh1 = await byte2File(thresh1Byte!);
}

Future<bool> downloadOCRLanguage(lang) async {
  Directory dir = Directory(await FlutterTesseractOcr.getTessdataPath());
  if (!dir.existsSync()) {
    dir.create();
  }
  bool isInstalled = false;
  dir.listSync().forEach((element) {
    String name = element.path.split('/').last;
    isInstalled |= name == '$lang.traineddata';
  });
  if (!isInstalled) {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(
        'https://github.com/tesseract-ocr/tessdata/raw/main/$lang.traineddata'));
    HttpClientResponse response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    String dir = await FlutterTesseractOcr.getTessdataPath();
    print('$dir/$lang.traineddata');
    File file = File('$dir/$lang.traineddata');
    await file.writeAsBytes(bytes);
    return true;
  }
  return false;
}

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

late final cameras;

late final PackageInfo packageInfo;

Function() fromCancel = () {};
Function() toCancel = () {};

late Function(String) changeFromTxt;
late Function(String) changeToTxt;

String newText = "";

Future<instanceValidation> checkInstance(String urlValue) async {
  var url;
  try {
    url = Uri.parse(urlValue);
  } catch (err) {
    print(err);
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

      setStateOverlord(() {
        googleInCtrl.text = _translationInput;
        loading = true;
      });

      final translatedText = await translate(
        input: _translationInput,
        fromLang: 'auto',
        toLang: shareLangVal,
        context: contextOverlordData,
      );
      setStateOverlord(() {
        googleOutput = translatedText;
        loading = false;
      });
    }
  } catch (_) {
    setStateOverlord(() => loading = false);
  }
}

bool isSnackBarVisible = false;

List<String> downloadedList = [];

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

late final String flutterTesseractOcrTessdataPath;

Map<String, String> two2three = {
  "af": "afr",
  "am": "amh",
  "ar": "ara",
  "as": "asm",
  "az": "aze",
  "be": "bel",
  "bn": "ben",
  "bs": "bos",
  "bg": "bul",
  "ca": "cat",
  "cs": "ces",
  "zh": "chi_tra",
  "": "syr",
  "co": "cos",
  "cy": "cym",
  "da": "dan",
  "de": "deu",
  "el": "ell",
  "en": "eng",
  "eo": "epo",
  "et": "est",
  "eu": "eus",
  "fa": "fas",
  "fi": "fin",
  "fr": "fra",
  "fy": "fry",
  "gd": "gla",
  "ga": "gle",
  "gl": "glg",
  "gu": "guj",
  "ht": "hat",
  "hi": "hin",
  "hr": "hrv",
  "hu": "hun",
  "hy": "hye",
  "id": "ind",
  "is": "isl",
  "it": "ita",
  "ja": "jpn",
  "kn": "kan",
  "ka": "kat",
  "kk": "kaz",
  "km": "khm",
  "ky": "kir",
  "ko": "kor",
  "lo": "lao",
  "la": "lat",
  "lv": "lav",
  "lt": "lit",
  "lb": "ltz",
  "ml": "mal",
  "mr": "mar",
  "mk": "mkd",
  "mt": "mlt",
  "mn": "mon",
  "mi": "mri",
  "ms": "msa",
  "my": "mya",
  "ne": "nep",
  "nl": "nld",
  "no": "nor",
  "or": "ori",
  "pa": "pan",
  "pl": "pol",
  "pt": "por",
  "ps": "pus",
  "ro": "ron",
  "ru": "rus",
  "si": "sin",
  "sk": "slk",
  "sl": "slv",
  "sd": "snd",
  "es": "spa",
  "sq": "sqi",
  "sr": "srp",
  "su": "sun",
  "sw": "swa",
  "sv": "swe",
  "ta": "tam",
  "tt": "tat",
  "te": "tel",
  "tg": "tgk",
  "tl": "tgl",
  "th": "tha",
  "to": "ton",
  "tr": "tur",
  "ug": "uig",
  "uk": "ukr",
  "ur": "urd",
  "uz": "uzb",
  "vi": "vie",
  "yi": "yid",
  "yo": "yor",
};
