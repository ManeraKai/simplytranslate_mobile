import 'dart:async';
import 'package:clipboard_listener/clipboard_listener.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'data.dart';
import 'home.dart';

void main(List<String> args) async {
  await GetStorage.init();

  var sessionInstances = session.read('instances');
  if (sessionInstances != null) {
    List<String> sessionInstancesString = [];
    for (var item in sessionInstances) {
      sessionInstancesString.add(item.toString());
    }
    instances = sessionInstancesString;
  }

  instance = session.read('instance_mode').toString() != 'null'
      ? session.read('instance_mode').toString()
      : instance;

  final _sessionCustomInstance = session.read('customInstance') != null
      ? session.read('customInstance').toString()
      : '';
  customUrlController.text = _sessionCustomInstance;
  customInstance = _sessionCustomInstance;

  var themeSession = session.read('theme').toString();
  if (themeSession != 'null') {
    if (themeSession == 'system') {
      themeRadio = AppTheme.system;
      theme = SchedulerBinding.instance!.window.platformBrightness;
    } else if (themeSession == 'light') {
      themeRadio = AppTheme.light;
      theme = Brightness.light;
    } else if (themeSession == 'dark') {
      themeRadio = AppTheme.dark;
      theme = Brightness.dark;
    }
  }
  var _clipData = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
  if (_clipData.toString() == '' || _clipData == null)
    isClipboardEmpty = true;
  else
    isClipboardEmpty = false;

  packageInfo = await PackageInfo.fromPlatform();

  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    ClipboardListener.addListener(() async {
      var _clipData = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
      if (_clipData.toString() == '' || _clipData == null) {
        if (!isClipboardEmpty) setState(() => isClipboardEmpty = true);
      } else {
        if (isClipboardEmpty) setState(() => isClipboardEmpty = false);
      }
    });
    contextOverlordData = context;
    setStateOverlordData = setState;
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
    ClipboardListener.removeListener(() {});
  }

  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        callSharedText = true;
      });

      var _clipData = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
      if (_clipData.toString() == '' || _clipData == null) {
        if (!isClipboardEmpty) setState(() => isClipboardEmpty = true);
      } else {
        if (isClipboardEmpty) setState(() => isClipboardEmpty = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localeListResolutionCallback: (locales, supportedLocales) {
        List supportedLocalesCountryCode = [];
        for (var item in supportedLocales) {
          supportedLocalesCountryCode.add(item.countryCode);
        }

        List supportedLocalesLanguageCode = [];
        for (var item in supportedLocales) {
          supportedLocalesLanguageCode.add(item.languageCode);
        }

        locales!;
        List localesCountryCode = [];
        for (var item in locales) {
          localesCountryCode.add(item.countryCode);
        }

        List localesLanguageCode = [];
        for (var item in locales) {
          localesLanguageCode.add(item.languageCode);
        }

        // print('Supported Locales CountryCode: $supportedLocalesCountryCode');
        // print('Supported Locales LanguageCode: $supportedLocalesLanguageCode');

        // print('Locales CountryCode: $localesCountryCode');
        // print('Locales LanguageCode: $localesLanguageCode');

        for (var i = 0; i < locales.length; i++) {
          if (supportedLocalesCountryCode.contains(localesCountryCode[i]) &&
              supportedLocalesLanguageCode.contains(localesLanguageCode[i])) {
            print(
                'Yes country: ${localesCountryCode[i]}, ${localesLanguageCode[i]}');
            return Locale(localesLanguageCode[i], localesCountryCode[i]);
          } else if (supportedLocalesLanguageCode
              .contains(localesLanguageCode[i])) {
            print('Yes language: ${localesLanguageCode[i]}');
            return Locale(localesLanguageCode[i]);
          } else {
            print('Nothing');
          }
        }
        return Locale('en');
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: materialAppTheme(),
      darkTheme: materialAppDarkTheme(context),
      themeMode: theme == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      title: 'Simply Translate Mobile',
      home: Scaffold(
        key: scaffoldKey,
        body: MainPageLocalization(),
      ),
    );
  }
}

class MainPageLocalization extends StatefulWidget {
  const MainPageLocalization({Key? key}) : super(key: key);

  @override
  State<MainPageLocalization> createState() => _MainPageLocalizationState();
}

class _MainPageLocalizationState extends State<MainPageLocalization> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> themeTranslation = {
      'dark': AppLocalizations.of(context)!.dark,
      'light': AppLocalizations.of(context)!.light,
      'system': AppLocalizations.of(context)!.follow_system,
    };

    final themeSession = session.read('theme').toString();
    if (themeSession != 'null')
      themeValue = themeTranslation[themeSession]!;
    else
      themeValue = themeTranslation['system']!;

    selectLanguagesMap = selectLanguagesMapGetter(context);

    selectLanguages = [];
    selectLanguagesMap.keys.forEach((element) => selectLanguages.add(element));
    selectLanguages.sort();

    fromSelectLanguagesMap = selectLanguagesMap;

    selectLanguagesFrom = [];
    selectLanguagesMap.keys
        .forEach((element) => selectLanguagesFrom.add(element));
    selectLanguagesFrom.sort();
    fromSelectLanguagesMap[AppLocalizations.of(context)!.autodetect] =
        "Autodetect";
    selectLanguagesFrom.insert(0, AppLocalizations.of(context)!.autodetect);

    fromLanguage = AppLocalizations.of(context)!.english;
    toLanguage = AppLocalizations.of(context)!.arabic;
    toLanguageShareDefault = AppLocalizations.of(context)!.arabic;

    if (session.read('from_language').toString() != 'null') {
      var sessionData = session.read('from_language').toString();
      fromLanguage = fromSelectLanguagesMap.entries
          .firstWhere((element) => element.value == sessionData)
          .key;
      fromLanguageValue = sessionData;
    }
    if (session.read('to_language').toString() != 'null') {
      var sessionData = session.read('to_language').toString();
      toLanguage = selectLanguagesMap.entries
          .firstWhere((element) => element.value == sessionData)
          .key;
      toLanguageValue = sessionData;
    }

    if (session.read('to_language_share_default').toString() != 'null') {
      var sessionData = session.read('to_language_share_default').toString();
      try {
        toLanguageShareDefault = selectLanguagesMap.entries
            .firstWhere((element) => element.value == sessionData)
            .key;
      } catch (e) {
        print('There is some error here');
      }
      toLanguageValueShareDefault = sessionData;
    }
    return MainPage();
  }
}
