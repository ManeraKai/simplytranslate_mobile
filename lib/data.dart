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
