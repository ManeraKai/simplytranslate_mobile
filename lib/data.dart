import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '/simplytranslate.dart' as simplytranslate;
export 'package:simplytranslate_mobile/messages.dart';

const greyColor = const Color(0xff131618);
const greenColor = const Color(0xff3fb274);
const lightThemeGreyColor = const Color(0xffa9a9a9);

late BuildContext contextOverlordData;
late void Function(void Function() fn) setStateOverlord;

var themeRadio = AppTheme.system;

late String fromLangVal;
late String toLangVal;

Map googleOutput = {};

extension CapitalizeString on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

enum AppTheme { dark, light, system }

var themeValue = '';

final Widget line = Container(
  margin: const EdgeInsets.only(top: 10, bottom: 5),
  height: 1.5,
  color: theme == Brightness.dark ? Colors.white : lightThemeGreyColor,
);

Brightness theme = SchedulerBinding.instance.platformDispatcher.platformBrightness;

late Map<String, String> toSelLangMap;
late Map<String, String> fromSelLangMap;

bool loading = false;
bool isTranslationCanceled = false;

final googleInCtrl = TextEditingController();

final session = GetStorage();

late final PackageInfo packageInfo;

Function() fromCancel = () {};
Function() toCancel = () {};

Function(String)? changeFromTxt;
Function(String)? changeToTxt;

String newText = "";

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

      final translatedText = await simplytranslate.translate(_translationInput, 'auto', toLangVal);
      setStateOverlord(() => googleOutput = translatedText);
    }
  } catch (_) {
    setStateOverlord(() => loading = false);
  }
}

BuildContext? translateContext;

bool isTtsInCanceled = false;
bool ttsInputloading = false;

bool ttsOutloading = false;
bool isTtsOutputCanceled = false;

bool isFirst = true;

switchVals() {
  if (fromLangVal == 'auto') return;
  changeFromTxt!(toSelLangMap[toLangVal]!);
  changeToTxt!(fromSelLangMap[fromLangVal]!);

  final tmp = fromLangVal;
  fromLangVal = toLangVal;
  toLangVal = tmp;

  session.write('to_lang', toLangVal);
  session.write('from_lang', fromLangVal);
}

enum FromTo { from, to }

(String?, String?, String?) lastUsed(FromTo fromto) {
  if (fromto == FromTo.from) {
    return (session.read("fromLast1"), session.read("fromLast2"), session.read("fromLast3"));
  } else {
    return (session.read("toLast1"), session.read("toLast2"), session.read("toLast3"));
  }
}
