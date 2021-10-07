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

Future<void> getSharedText(
  setStateParent,
  context,
  Future<String> Function({
    required String input,
    required String fromLanguageValue,
    required String toLanguageValue,
    required BuildContext context,
  })
      translateParent,
) async {
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
    setStateParent(() {
      loading = false;
    });
  }
}

bool isSnackBarVisible = false;

AudioPlayer audioPlayer = AudioPlayer();

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
          ));
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
          ));
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
