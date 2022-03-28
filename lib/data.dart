import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:opencv_4/opencv_4.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:path_provider/path_provider.dart';

// const lightGreenColor = const Color(0xff62d195);
const greyColor = const Color(0xff131618);
const secondgreyColor = const Color(0xff212529);
const greenColor = const Color(0xff3fb274);
const lightThemeGreyColor = const Color(0xffa9a9a9);
const darkThemedisabledColor = const Color(0xff6e7071);
const lightThemedisabledColor = const Color(0xff9b9b9b);

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

cancelDownloadOCRLanguage(lang) {
  String fullName = fromSelLangMap[lang]!;
  print("Canceled ocr: $fullName");
  setStateOverlord(() {
    _downloadOCRLanguageCancel = true;
    downloadingList[lang] = TrainedDataState.notDownloaded;
  });
}

var _downloadOCRLanguageCancel = false;

Future<bool> downloadOCRLanguage(lang) async {
  String fullName = fromSelLangMap[lang]!;
  print("Downloading ocr: $fullName");
  setStateOverlord(() => downloadingList[lang] = TrainedDataState.Downloading);

  String langThree = two2three[lang]!;
  Directory dir = Directory(await FlutterTesseractOcr.getTessdataPath());
  if (!dir.existsSync()) dir.create();

  bool isInstalled = false;
  dir.listSync().forEach((element) {
    String name = element.path.split('/').last;
    isInstalled |= name == '$langThree.traineddata';
  });
  if (!isInstalled) {
    var url = Uri.parse(
        'https://github.com/tesseract-ocr/tessdata/raw/main/$langThree.traineddata');
    var response = await http.get(url);
    if (!_downloadOCRLanguageCancel) {
      Uint8List bytes = response.bodyBytes;
      String dir = await FlutterTesseractOcr.getTessdataPath();
      File file = File('$dir/$langThree.traineddata');
      await file.writeAsBytes(bytes);
      setStateOverlord(
          () => downloadingList[lang] = TrainedDataState.Downloaded);
      print("Successfully Downloaded ocr: $fullName");
      return true;
    }
  }
  _downloadOCRLanguageCancel = false;
  setStateOverlord(
      () => downloadingList[lang] = TrainedDataState.notDownloaded);
  print("Failed to Downloaded ocr: $fullName");
  return false;
}

late File img;

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

enum TrainedDataState { notDownloaded, Downloading, Downloaded }

Map<String, String> selectLanguagesMapGetter(BuildContext context) {
  Map<String, String> mapOne = {
    "af": L10n.of(context).afrikaans,
    "sq": L10n.of(context).albanian,
    "am": L10n.of(context).amharic,
    "ar": L10n.of(context).arabic,
    "hy": L10n.of(context).armenian,
    "az": L10n.of(context).azerbaijani,
    "eu": L10n.of(context).basque,
    "be": L10n.of(context).belarusian,
    "bn": L10n.of(context).bengali,
    "bs": L10n.of(context).bosnian,
    "bg": L10n.of(context).bulgarian,
    "ca": L10n.of(context).catalan,
    "ceb": L10n.of(context).cebuano,
    "ny": L10n.of(context).chichewa,
    "zh-CN": L10n.of(context).chinese,
    "co": L10n.of(context).corsican,
    "hr": L10n.of(context).croatian,
    "cs": L10n.of(context).czech,
    "da": L10n.of(context).danish,
    "nl": L10n.of(context).dutch,
    "en": L10n.of(context).english,
    "eo": L10n.of(context).esperanto,
    "et": L10n.of(context).estonian,
    "tl": L10n.of(context).filipino,
    "fi": L10n.of(context).finnish,
    "fr": L10n.of(context).french,
    "fy": L10n.of(context).frisian,
    "gl": L10n.of(context).galician,
    "ka": L10n.of(context).georgian,
    "de": L10n.of(context).german,
    "el": L10n.of(context).greek,
    "gu": L10n.of(context).gujarati,
    "ht": L10n.of(context).haitian_creole,
    "ha": L10n.of(context).hausa,
    "haw": L10n.of(context).hawaiian,
    "iw": L10n.of(context).hebrew,
    "hi": L10n.of(context).hindi,
    "hmn": L10n.of(context).hmong,
    "hu": L10n.of(context).hungarian,
    "is": L10n.of(context).icelandic,
    "ig": L10n.of(context).igbo,
    "id": L10n.of(context).indonesian,
    "ga": L10n.of(context).irish,
    "it": L10n.of(context).italian,
    "ja": L10n.of(context).japanese,
    "jw": L10n.of(context).javanese,
    "kn": L10n.of(context).kannada,
    "kk": L10n.of(context).kazakh,
    "km": L10n.of(context).khmer,
    "rw": L10n.of(context).kinyarwanda,
    "ko": L10n.of(context).korean,
    "ku": L10n.of(context).kurdish_kurmanji,
    "ky": L10n.of(context).kyrgyz,
    "lo": L10n.of(context).lao,
    "la": L10n.of(context).latin,
    "lv": L10n.of(context).latvian,
    "lt": L10n.of(context).lithuanian,
    "lb": L10n.of(context).luxembourgish,
    "mk": L10n.of(context).macedonian,
    "mg": L10n.of(context).malagasy,
    "ms": L10n.of(context).malay,
    "ml": L10n.of(context).malayalam,
    "mt": L10n.of(context).maltese,
    "mi": L10n.of(context).maori,
    "mr": L10n.of(context).marathi,
    "mn": L10n.of(context).mongolian,
    "my": L10n.of(context).myanmar_burmese,
    "ne": L10n.of(context).nepali,
    "no": L10n.of(context).norwegian,
    "or": L10n.of(context).odia_oriya,
    "ps": L10n.of(context).pashto,
    "fa": L10n.of(context).persian,
    "pl": L10n.of(context).polish,
    "pt": L10n.of(context).portuguese,
    "pa": L10n.of(context).punjabi,
    "ro": L10n.of(context).romanian,
    "ru": L10n.of(context).russian,
    "sm": L10n.of(context).samoan,
    "gd": L10n.of(context).scots_gaelic,
    "sr": L10n.of(context).serbian,
    "st": L10n.of(context).sesotho,
    "sn": L10n.of(context).shona,
    "sd": L10n.of(context).sindhi,
    "si": L10n.of(context).sinhala,
    "sk": L10n.of(context).slovak,
    "sl": L10n.of(context).slovenian,
    "so": L10n.of(context).somali,
    "es": L10n.of(context).spanish,
    "su": L10n.of(context).sundanese,
    "sw": L10n.of(context).swahili,
    "sv": L10n.of(context).swedish,
    "tg": L10n.of(context).tajik,
    "ta": L10n.of(context).tamil,
    "tt": L10n.of(context).tatar,
    "te": L10n.of(context).telugu,
    "th": L10n.of(context).thai,
    "tr": L10n.of(context).turkish,
    "tk": L10n.of(context).turkmen,
    "uk": L10n.of(context).ukrainian,
    "ur": L10n.of(context).urdu,
    "ug": L10n.of(context).uyghur,
    "uz": L10n.of(context).uzbek,
    "vi": L10n.of(context).vietnamese,
    "cy": L10n.of(context).welsh,
    "xh": L10n.of(context).xhosa,
    "yi": L10n.of(context).yiddish,
    "yo": L10n.of(context).yoruba,
    "zu": L10n.of(context).zulu,
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
      title: Text(L10n.of(context).something_went_wrong),
      content: Text(L10n.of(context).check_instance),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(L10n.of(context).ok),
        )
      ],
    ),
  );
}

showInstanceTtsError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(L10n.of(context).something_went_wrong),
      content: Text(L10n.of(context).check_instnace_tts),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(L10n.of(context).ok),
        )
      ],
    ),
  );
}

showInternetError(context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(L10n.of(context).no_internet),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(L10n.of(context).ok),
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
  // final args = "from=$fromLang&to=$toLang&text=$input";
  if (instance == 'custom')
    url = Uri.parse('$customInstance/api/translate');
  else if (instance == 'random') {
    final randomInstance = instances[Random().nextInt(instances.length)];
    url = Uri.parse('$randomInstance/api/translate');
  } else
    url = Uri.parse('$instance/api/translate');

  try {
    final response = await http.post(
      url,
      body: {
        'from': fromLang,
        'to': toLang,
        'text': input,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
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

Map<String, TrainedDataState> downloadingList = {
  "af": TrainedDataState.notDownloaded,
  "am": TrainedDataState.notDownloaded,
  "ar": TrainedDataState.notDownloaded,
  "as": TrainedDataState.notDownloaded,
  "az": TrainedDataState.notDownloaded,
  "be": TrainedDataState.notDownloaded,
  "bn": TrainedDataState.notDownloaded,
  "bs": TrainedDataState.notDownloaded,
  "bg": TrainedDataState.notDownloaded,
  "ca": TrainedDataState.notDownloaded,
  "cs": TrainedDataState.notDownloaded,
  "zh": TrainedDataState.notDownloaded,
  "co": TrainedDataState.notDownloaded,
  "cy": TrainedDataState.notDownloaded,
  "da": TrainedDataState.notDownloaded,
  "de": TrainedDataState.notDownloaded,
  "el": TrainedDataState.notDownloaded,
  "en": TrainedDataState.notDownloaded,
  "eo": TrainedDataState.notDownloaded,
  "et": TrainedDataState.notDownloaded,
  "eu": TrainedDataState.notDownloaded,
  "fa": TrainedDataState.notDownloaded,
  "fi": TrainedDataState.notDownloaded,
  "fr": TrainedDataState.notDownloaded,
  "fy": TrainedDataState.notDownloaded,
  "gd": TrainedDataState.notDownloaded,
  "ga": TrainedDataState.notDownloaded,
  "gl": TrainedDataState.notDownloaded,
  "gu": TrainedDataState.notDownloaded,
  "ht": TrainedDataState.notDownloaded,
  "hi": TrainedDataState.notDownloaded,
  "hr": TrainedDataState.notDownloaded,
  "hu": TrainedDataState.notDownloaded,
  "hy": TrainedDataState.notDownloaded,
  "id": TrainedDataState.notDownloaded,
  "is": TrainedDataState.notDownloaded,
  "it": TrainedDataState.notDownloaded,
  "ja": TrainedDataState.notDownloaded,
  "kn": TrainedDataState.notDownloaded,
  "ka": TrainedDataState.notDownloaded,
  "kk": TrainedDataState.notDownloaded,
  "km": TrainedDataState.notDownloaded,
  "ky": TrainedDataState.notDownloaded,
  "ko": TrainedDataState.notDownloaded,
  "lo": TrainedDataState.notDownloaded,
  "la": TrainedDataState.notDownloaded,
  "lv": TrainedDataState.notDownloaded,
  "lt": TrainedDataState.notDownloaded,
  "lb": TrainedDataState.notDownloaded,
  "ml": TrainedDataState.notDownloaded,
  "mr": TrainedDataState.notDownloaded,
  "mk": TrainedDataState.notDownloaded,
  "mt": TrainedDataState.notDownloaded,
  "mn": TrainedDataState.notDownloaded,
  "mi": TrainedDataState.notDownloaded,
  "ms": TrainedDataState.notDownloaded,
  "my": TrainedDataState.notDownloaded,
  "ne": TrainedDataState.notDownloaded,
  "nl": TrainedDataState.notDownloaded,
  "no": TrainedDataState.notDownloaded,
  "or": TrainedDataState.notDownloaded,
  "pa": TrainedDataState.notDownloaded,
  "pl": TrainedDataState.notDownloaded,
  "pt": TrainedDataState.notDownloaded,
  "ps": TrainedDataState.notDownloaded,
  "ro": TrainedDataState.notDownloaded,
  "ru": TrainedDataState.notDownloaded,
  "si": TrainedDataState.notDownloaded,
  "sk": TrainedDataState.notDownloaded,
  "sl": TrainedDataState.notDownloaded,
  "sd": TrainedDataState.notDownloaded,
  "es": TrainedDataState.notDownloaded,
  "sq": TrainedDataState.notDownloaded,
  "sr": TrainedDataState.notDownloaded,
  "su": TrainedDataState.notDownloaded,
  "sw": TrainedDataState.notDownloaded,
  "sv": TrainedDataState.notDownloaded,
  "ta": TrainedDataState.notDownloaded,
  "tt": TrainedDataState.notDownloaded,
  "te": TrainedDataState.notDownloaded,
  "tg": TrainedDataState.notDownloaded,
  "tl": TrainedDataState.notDownloaded,
  "th": TrainedDataState.notDownloaded,
  "to": TrainedDataState.notDownloaded,
  "tr": TrainedDataState.notDownloaded,
  "ug": TrainedDataState.notDownloaded,
  "uk": TrainedDataState.notDownloaded,
  "ur": TrainedDataState.notDownloaded,
  "uz": TrainedDataState.notDownloaded,
  "vi": TrainedDataState.notDownloaded,
  "yi": TrainedDataState.notDownloaded,
  "yo": TrainedDataState.notDownloaded,
};

late double inTextFieldHeight;
late double outTextFieldHeight;

var instances = [
  "https://simplytranslate.org",
  "https://st.alefvanoon.xyz",
  "https://translate.josias.dev",
  "https://translate.namazso.eu",
  "https://translate.riverside.rocks",
  "https://manerakai.asuscomm.com:447",
  "https://translate.bus-hit.me",
  "https://simplytranslate.pussthecat.org",
  "https://translate.northboot.xyz",
  "https://translate.tiekoetter.com",
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

Map<String, bool> inList = {
  "Remove": true,
  "Copy": false,
  "Camera": true,
  "Paste": true,
  "Text-To-Speech": true,
  "Counter": true,
};
Map<String, bool> outList = {
  "Copy": true,
  "Maximize": true,
  "Text-To-Speech": true,
};
