import 'dart:convert';

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

Widget line = Container(
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

      final translatedText = await simplytranslate.translate(
        _translationInput,
        'auto',
        toLangVal,
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
  final Map<String, dynamic> langUsage = jsonDecode((fromto == FromTo.from ? session.read("fromLangUsage") : session.read("toLangUsage")) ?? "{}");
  if (langUsage.isEmpty) return (null, null, null);

  (String, int)? max1;
  (String, int)? max2;
  (String, int)? max3;
  langUsage.removeWhere((key, value) => value == 0);
  langUsage.forEach((key, value) {
    if (max1 == null || max1!.$2 < value) {
      max3 = max2;
      max2 = max1;
      max1 = (key, value);
    } else if (max2 == null || max2!.$2 < value) {
      max3 = max2;
      max2 = (key, value);
    } else if (max3 == null || max3!.$2 < value) {
      max3 = (key, value);
    }
  });
  return (max1?.$1, max2?.$1, max3?.$1);
}

extension MoveElement<T> on List<T> {
  void move(int from, int to) {
    RangeError.checkValidIndex(from, this, "from", length);
    RangeError.checkValidIndex(to, this, "to", length);
    var element = this[from];
    if (from < to) {
      this.setRange(from, to, this, from + 1);
    } else {
      this.setRange(to + 1, from + 1, this, to);
    }
    this[to] = element;
  }
}
