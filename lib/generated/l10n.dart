// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class L10n {
  L10n();

  static L10n? _current;

  static L10n get current {
    assert(_current != null,
        'No instance of L10n was loaded. Try to initialize the L10n delegate before accessing L10n.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<L10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = L10n();
      L10n._current = instance;

      return instance;
    });
  }

  static L10n of(BuildContext context) {
    final instance = L10n.maybeOf(context);
    assert(instance != null,
        'No instance of L10n present in the widget tree. Did you add L10n.delegate in localizationsDelegates?');
    return instance!;
  }

  static L10n? maybeOf(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  /// `Autodetect`
  String get autodetect {
    return Intl.message(
      'Autodetect',
      name: 'autodetect',
      desc: '',
      args: [],
    );
  }

  /// `Afrikaans`
  String get afrikaans {
    return Intl.message(
      'Afrikaans',
      name: 'afrikaans',
      desc: '',
      args: [],
    );
  }

  /// `Albanian`
  String get albanian {
    return Intl.message(
      'Albanian',
      name: 'albanian',
      desc: '',
      args: [],
    );
  }

  /// `Amharic`
  String get amharic {
    return Intl.message(
      'Amharic',
      name: 'amharic',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get arabic {
    return Intl.message(
      'Arabic',
      name: 'arabic',
      desc: '',
      args: [],
    );
  }

  /// `Armenian`
  String get armenian {
    return Intl.message(
      'Armenian',
      name: 'armenian',
      desc: '',
      args: [],
    );
  }

  /// `Azerbaijani`
  String get azerbaijani {
    return Intl.message(
      'Azerbaijani',
      name: 'azerbaijani',
      desc: '',
      args: [],
    );
  }

  /// `Basque`
  String get basque {
    return Intl.message(
      'Basque',
      name: 'basque',
      desc: '',
      args: [],
    );
  }

  /// `Belarusian`
  String get belarusian {
    return Intl.message(
      'Belarusian',
      name: 'belarusian',
      desc: '',
      args: [],
    );
  }

  /// `Bengali`
  String get bengali {
    return Intl.message(
      'Bengali',
      name: 'bengali',
      desc: '',
      args: [],
    );
  }

  /// `Bosnian`
  String get bosnian {
    return Intl.message(
      'Bosnian',
      name: 'bosnian',
      desc: '',
      args: [],
    );
  }

  /// `Bulgarian`
  String get bulgarian {
    return Intl.message(
      'Bulgarian',
      name: 'bulgarian',
      desc: '',
      args: [],
    );
  }

  /// `Catalan`
  String get catalan {
    return Intl.message(
      'Catalan',
      name: 'catalan',
      desc: '',
      args: [],
    );
  }

  /// `Cebuano`
  String get cebuano {
    return Intl.message(
      'Cebuano',
      name: 'cebuano',
      desc: '',
      args: [],
    );
  }

  /// `Chichewa`
  String get chichewa {
    return Intl.message(
      'Chichewa',
      name: 'chichewa',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get chinese {
    return Intl.message(
      'Chinese',
      name: 'chinese',
      desc: '',
      args: [],
    );
  }

  /// `Corsican`
  String get corsican {
    return Intl.message(
      'Corsican',
      name: 'corsican',
      desc: '',
      args: [],
    );
  }

  /// `Croatian`
  String get croatian {
    return Intl.message(
      'Croatian',
      name: 'croatian',
      desc: '',
      args: [],
    );
  }

  /// `Czech`
  String get czech {
    return Intl.message(
      'Czech',
      name: 'czech',
      desc: '',
      args: [],
    );
  }

  /// `Danish`
  String get danish {
    return Intl.message(
      'Danish',
      name: 'danish',
      desc: '',
      args: [],
    );
  }

  /// `Dutch`
  String get dutch {
    return Intl.message(
      'Dutch',
      name: 'dutch',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Esperanto`
  String get esperanto {
    return Intl.message(
      'Esperanto',
      name: 'esperanto',
      desc: '',
      args: [],
    );
  }

  /// `Estonian`
  String get estonian {
    return Intl.message(
      'Estonian',
      name: 'estonian',
      desc: '',
      args: [],
    );
  }

  /// `Filipino`
  String get filipino {
    return Intl.message(
      'Filipino',
      name: 'filipino',
      desc: '',
      args: [],
    );
  }

  /// `Finnish`
  String get finnish {
    return Intl.message(
      'Finnish',
      name: 'finnish',
      desc: '',
      args: [],
    );
  }

  /// `French`
  String get french {
    return Intl.message(
      'French',
      name: 'french',
      desc: '',
      args: [],
    );
  }

  /// `Frisian`
  String get frisian {
    return Intl.message(
      'Frisian',
      name: 'frisian',
      desc: '',
      args: [],
    );
  }

  /// `Galician`
  String get galician {
    return Intl.message(
      'Galician',
      name: 'galician',
      desc: '',
      args: [],
    );
  }

  /// `Georgian`
  String get georgian {
    return Intl.message(
      'Georgian',
      name: 'georgian',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get german {
    return Intl.message(
      'German',
      name: 'german',
      desc: '',
      args: [],
    );
  }

  /// `Greek`
  String get greek {
    return Intl.message(
      'Greek',
      name: 'greek',
      desc: '',
      args: [],
    );
  }

  /// `Gujarati`
  String get gujarati {
    return Intl.message(
      'Gujarati',
      name: 'gujarati',
      desc: '',
      args: [],
    );
  }

  /// `Haitian Creole`
  String get haitian_creole {
    return Intl.message(
      'Haitian Creole',
      name: 'haitian_creole',
      desc: '',
      args: [],
    );
  }

  /// `Hausa`
  String get hausa {
    return Intl.message(
      'Hausa',
      name: 'hausa',
      desc: '',
      args: [],
    );
  }

  /// `Hawaiian`
  String get hawaiian {
    return Intl.message(
      'Hawaiian',
      name: 'hawaiian',
      desc: '',
      args: [],
    );
  }

  /// `Hebrew`
  String get hebrew {
    return Intl.message(
      'Hebrew',
      name: 'hebrew',
      desc: '',
      args: [],
    );
  }

  /// `Hindi`
  String get hindi {
    return Intl.message(
      'Hindi',
      name: 'hindi',
      desc: '',
      args: [],
    );
  }

  /// `Hmong`
  String get hmong {
    return Intl.message(
      'Hmong',
      name: 'hmong',
      desc: '',
      args: [],
    );
  }

  /// `Hungarian`
  String get hungarian {
    return Intl.message(
      'Hungarian',
      name: 'hungarian',
      desc: '',
      args: [],
    );
  }

  /// `Icelandic`
  String get icelandic {
    return Intl.message(
      'Icelandic',
      name: 'icelandic',
      desc: '',
      args: [],
    );
  }

  /// `Igbo`
  String get igbo {
    return Intl.message(
      'Igbo',
      name: 'igbo',
      desc: '',
      args: [],
    );
  }

  /// `Indonesian`
  String get indonesian {
    return Intl.message(
      'Indonesian',
      name: 'indonesian',
      desc: '',
      args: [],
    );
  }

  /// `Irish`
  String get irish {
    return Intl.message(
      'Irish',
      name: 'irish',
      desc: '',
      args: [],
    );
  }

  /// `Italian`
  String get italian {
    return Intl.message(
      'Italian',
      name: 'italian',
      desc: '',
      args: [],
    );
  }

  /// `Japanese`
  String get japanese {
    return Intl.message(
      'Japanese',
      name: 'japanese',
      desc: '',
      args: [],
    );
  }

  /// `Javanese`
  String get javanese {
    return Intl.message(
      'Javanese',
      name: 'javanese',
      desc: '',
      args: [],
    );
  }

  /// `Kannada`
  String get kannada {
    return Intl.message(
      'Kannada',
      name: 'kannada',
      desc: '',
      args: [],
    );
  }

  /// `Kazakh`
  String get kazakh {
    return Intl.message(
      'Kazakh',
      name: 'kazakh',
      desc: '',
      args: [],
    );
  }

  /// `Khmer`
  String get khmer {
    return Intl.message(
      'Khmer',
      name: 'khmer',
      desc: '',
      args: [],
    );
  }

  /// `Kinyarwanda`
  String get kinyarwanda {
    return Intl.message(
      'Kinyarwanda',
      name: 'kinyarwanda',
      desc: '',
      args: [],
    );
  }

  /// `Korean`
  String get korean {
    return Intl.message(
      'Korean',
      name: 'korean',
      desc: '',
      args: [],
    );
  }

  /// `Kurdish (Kurmanji)`
  String get kurdish_kurmanji {
    return Intl.message(
      'Kurdish (Kurmanji)',
      name: 'kurdish_kurmanji',
      desc: '',
      args: [],
    );
  }

  /// `Kyrgyz`
  String get kyrgyz {
    return Intl.message(
      'Kyrgyz',
      name: 'kyrgyz',
      desc: '',
      args: [],
    );
  }

  /// `Lao`
  String get lao {
    return Intl.message(
      'Lao',
      name: 'lao',
      desc: '',
      args: [],
    );
  }

  /// `Latin`
  String get latin {
    return Intl.message(
      'Latin',
      name: 'latin',
      desc: '',
      args: [],
    );
  }

  /// `Latvian`
  String get latvian {
    return Intl.message(
      'Latvian',
      name: 'latvian',
      desc: '',
      args: [],
    );
  }

  /// `Lithuanian`
  String get lithuanian {
    return Intl.message(
      'Lithuanian',
      name: 'lithuanian',
      desc: '',
      args: [],
    );
  }

  /// `Luxembourgish`
  String get luxembourgish {
    return Intl.message(
      'Luxembourgish',
      name: 'luxembourgish',
      desc: '',
      args: [],
    );
  }

  /// `Macedonian`
  String get macedonian {
    return Intl.message(
      'Macedonian',
      name: 'macedonian',
      desc: '',
      args: [],
    );
  }

  /// `Malagasy`
  String get malagasy {
    return Intl.message(
      'Malagasy',
      name: 'malagasy',
      desc: '',
      args: [],
    );
  }

  /// `Malay`
  String get malay {
    return Intl.message(
      'Malay',
      name: 'malay',
      desc: '',
      args: [],
    );
  }

  /// `Malayalam`
  String get malayalam {
    return Intl.message(
      'Malayalam',
      name: 'malayalam',
      desc: '',
      args: [],
    );
  }

  /// `Maltese`
  String get maltese {
    return Intl.message(
      'Maltese',
      name: 'maltese',
      desc: '',
      args: [],
    );
  }

  /// `Maori`
  String get maori {
    return Intl.message(
      'Maori',
      name: 'maori',
      desc: '',
      args: [],
    );
  }

  /// `Marathi`
  String get marathi {
    return Intl.message(
      'Marathi',
      name: 'marathi',
      desc: '',
      args: [],
    );
  }

  /// `Mongolian`
  String get mongolian {
    return Intl.message(
      'Mongolian',
      name: 'mongolian',
      desc: '',
      args: [],
    );
  }

  /// `Myanmar (Burmese)`
  String get myanmar_burmese {
    return Intl.message(
      'Myanmar (Burmese)',
      name: 'myanmar_burmese',
      desc: '',
      args: [],
    );
  }

  /// `Nepali`
  String get nepali {
    return Intl.message(
      'Nepali',
      name: 'nepali',
      desc: '',
      args: [],
    );
  }

  /// `Norwegian`
  String get norwegian {
    return Intl.message(
      'Norwegian',
      name: 'norwegian',
      desc: '',
      args: [],
    );
  }

  /// `Odia (Oriya)`
  String get odia_oriya {
    return Intl.message(
      'Odia (Oriya)',
      name: 'odia_oriya',
      desc: '',
      args: [],
    );
  }

  /// `Pashto`
  String get pashto {
    return Intl.message(
      'Pashto',
      name: 'pashto',
      desc: '',
      args: [],
    );
  }

  /// `Persian`
  String get persian {
    return Intl.message(
      'Persian',
      name: 'persian',
      desc: '',
      args: [],
    );
  }

  /// `Polish`
  String get polish {
    return Intl.message(
      'Polish',
      name: 'polish',
      desc: '',
      args: [],
    );
  }

  /// `Portuguese`
  String get portuguese {
    return Intl.message(
      'Portuguese',
      name: 'portuguese',
      desc: '',
      args: [],
    );
  }

  /// `Punjabi`
  String get punjabi {
    return Intl.message(
      'Punjabi',
      name: 'punjabi',
      desc: '',
      args: [],
    );
  }

  /// `Romanian`
  String get romanian {
    return Intl.message(
      'Romanian',
      name: 'romanian',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `Samoan`
  String get samoan {
    return Intl.message(
      'Samoan',
      name: 'samoan',
      desc: '',
      args: [],
    );
  }

  /// `Scots Gaelic`
  String get scots_gaelic {
    return Intl.message(
      'Scots Gaelic',
      name: 'scots_gaelic',
      desc: '',
      args: [],
    );
  }

  /// `Serbian`
  String get serbian {
    return Intl.message(
      'Serbian',
      name: 'serbian',
      desc: '',
      args: [],
    );
  }

  /// `Sesotho`
  String get sesotho {
    return Intl.message(
      'Sesotho',
      name: 'sesotho',
      desc: '',
      args: [],
    );
  }

  /// `Shona`
  String get shona {
    return Intl.message(
      'Shona',
      name: 'shona',
      desc: '',
      args: [],
    );
  }

  /// `Sindhi`
  String get sindhi {
    return Intl.message(
      'Sindhi',
      name: 'sindhi',
      desc: '',
      args: [],
    );
  }

  /// `Sinhala`
  String get sinhala {
    return Intl.message(
      'Sinhala',
      name: 'sinhala',
      desc: '',
      args: [],
    );
  }

  /// `Slovak`
  String get slovak {
    return Intl.message(
      'Slovak',
      name: 'slovak',
      desc: '',
      args: [],
    );
  }

  /// `Slovenian`
  String get slovenian {
    return Intl.message(
      'Slovenian',
      name: 'slovenian',
      desc: '',
      args: [],
    );
  }

  /// `Somali`
  String get somali {
    return Intl.message(
      'Somali',
      name: 'somali',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get spanish {
    return Intl.message(
      'Spanish',
      name: 'spanish',
      desc: '',
      args: [],
    );
  }

  /// `Sundanese`
  String get sundanese {
    return Intl.message(
      'Sundanese',
      name: 'sundanese',
      desc: '',
      args: [],
    );
  }

  /// `Swahili`
  String get swahili {
    return Intl.message(
      'Swahili',
      name: 'swahili',
      desc: '',
      args: [],
    );
  }

  /// `Swedish`
  String get swedish {
    return Intl.message(
      'Swedish',
      name: 'swedish',
      desc: '',
      args: [],
    );
  }

  /// `Tajik`
  String get tajik {
    return Intl.message(
      'Tajik',
      name: 'tajik',
      desc: '',
      args: [],
    );
  }

  /// `Tamil`
  String get tamil {
    return Intl.message(
      'Tamil',
      name: 'tamil',
      desc: '',
      args: [],
    );
  }

  /// `Tatar`
  String get tatar {
    return Intl.message(
      'Tatar',
      name: 'tatar',
      desc: '',
      args: [],
    );
  }

  /// `Telugu`
  String get telugu {
    return Intl.message(
      'Telugu',
      name: 'telugu',
      desc: '',
      args: [],
    );
  }

  /// `Thai`
  String get thai {
    return Intl.message(
      'Thai',
      name: 'thai',
      desc: '',
      args: [],
    );
  }

  /// `Turkish`
  String get turkish {
    return Intl.message(
      'Turkish',
      name: 'turkish',
      desc: '',
      args: [],
    );
  }

  /// `Turkmen`
  String get turkmen {
    return Intl.message(
      'Turkmen',
      name: 'turkmen',
      desc: '',
      args: [],
    );
  }

  /// `Ukrainian`
  String get ukrainian {
    return Intl.message(
      'Ukrainian',
      name: 'ukrainian',
      desc: '',
      args: [],
    );
  }

  /// `Urdu`
  String get urdu {
    return Intl.message(
      'Urdu',
      name: 'urdu',
      desc: '',
      args: [],
    );
  }

  /// `Uyghur`
  String get uyghur {
    return Intl.message(
      'Uyghur',
      name: 'uyghur',
      desc: '',
      args: [],
    );
  }

  /// `Uzbek`
  String get uzbek {
    return Intl.message(
      'Uzbek',
      name: 'uzbek',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: '',
      args: [],
    );
  }

  /// `Welsh`
  String get welsh {
    return Intl.message(
      'Welsh',
      name: 'welsh',
      desc: '',
      args: [],
    );
  }

  /// `Xhosa`
  String get xhosa {
    return Intl.message(
      'Xhosa',
      name: 'xhosa',
      desc: '',
      args: [],
    );
  }

  /// `Yiddish`
  String get yiddish {
    return Intl.message(
      'Yiddish',
      name: 'yiddish',
      desc: '',
      args: [],
    );
  }

  /// `Yoruba`
  String get yoruba {
    return Intl.message(
      'Yoruba',
      name: 'yoruba',
      desc: '',
      args: [],
    );
  }

  /// `Zulu`
  String get zulu {
    return Intl.message(
      'Zulu',
      name: 'zulu',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copied_to_clipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Translate`
  String get translate {
    return Intl.message(
      'Translate',
      name: 'translate',
      desc: '',
      args: [],
    );
  }

  /// `Enter text here`
  String get enter_text_here {
    return Intl.message(
      'Enter text here',
      name: 'enter_text_here',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Check instance.`
  String get check_instance {
    return Intl.message(
      'Check instance.',
      name: 'check_instance',
      desc: '',
      args: [],
    );
  }

  /// `Check instance and its TTS (Text-to-Speech) support.`
  String get check_instnace_tts {
    return Intl.message(
      'Check instance and its TTS (Text-to-Speech) support.',
      name: 'check_instnace_tts',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet {
    return Intl.message(
      'No internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Clipboard is empty`
  String get empty_clipboard {
    return Intl.message(
      'Clipboard is empty',
      name: 'empty_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `The translation input is above 5000`
  String get input_limit {
    return Intl.message(
      'The translation input is above 5000',
      name: 'input_limit',
      desc: '',
      args: [],
    );
  }

  /// `Exceeded 5000 character limit by $lengthDifference`
  String get input_calc {
    return Intl.message(
      'Exceeded 5000 character limit by \$lengthDifference',
      name: 'input_calc',
      desc: '',
      args: [],
    );
  }

  /// `Entered $length character out of 5000 possible`
  String get input_fraction_one {
    return Intl.message(
      'Entered \$length character out of 5000 possible',
      name: 'input_fraction_one',
      desc: '',
      args: [],
    );
  }

  /// `Entered $length characters out of 5000 possible`
  String get input_fraction_few {
    return Intl.message(
      'Entered \$length characters out of 5000 possible',
      name: 'input_fraction_few',
      desc: '',
      args: [],
    );
  }

  /// `Entered $length characters out of 5000 possible`
  String get input_fraction_many {
    return Intl.message(
      'Entered \$length characters out of 5000 possible',
      name: 'input_fraction_many',
      desc: '',
      args: [],
    );
  }

  /// `Entered $length characters out of 5000 possible`
  String get input_fraction_other {
    return Intl.message(
      'Entered \$length characters out of 5000 possible',
      name: 'input_fraction_other',
      desc: '',
      args: [],
    );
  }

  /// `Cannot get audio for more than 200 characters`
  String get audio_limit {
    return Intl.message(
      'Cannot get audio for more than 200 characters',
      name: 'audio_limit',
      desc: '',
      args: [],
    );
  }

  /// `Service is not available`
  String get not_available {
    return Intl.message(
      'Service is not available',
      name: 'not_available',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Instances`
  String get instances {
    return Intl.message(
      'Instances',
      name: 'instances',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Translation`
  String get translation {
    return Intl.message(
      'Translation',
      name: 'translation',
      desc: '',
      args: [],
    );
  }

  /// `Instance`
  String get instance {
    return Intl.message(
      'Instance',
      name: 'instance',
      desc: '',
      args: [],
    );
  }

  /// `Random`
  String get random {
    return Intl.message(
      'Random',
      name: 'random',
      desc: '',
      args: [],
    );
  }

  /// `Custom`
  String get custom {
    return Intl.message(
      'Custom',
      name: 'custom',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Update list`
  String get update_list {
    return Intl.message(
      'Update list',
      name: 'update_list',
      desc: '',
      args: [],
    );
  }

  /// `Updates the official list of instances`
  String get update_list_summary {
    return Intl.message(
      'Updates the official list of instances',
      name: 'update_list_summary',
      desc: '',
      args: [],
    );
  }

  /// `Updated successfully`
  String get updated_successfully {
    return Intl.message(
      'Updated successfully',
      name: 'updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `There was an error`
  String get error {
    return Intl.message(
      'There was an error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Follow system`
  String get follow_system {
    return Intl.message(
      'Follow system',
      name: 'follow_system',
      desc: '',
      args: [],
    );
  }

  /// `Default share language`
  String get default_share_language {
    return Intl.message(
      'Default share language',
      name: 'default_share_language',
      desc: '',
      args: [],
    );
  }

  /// `Determines the translation language for shared text from another app: $toLanguageShareDefault`
  String get default_share_language_summary {
    return Intl.message(
      'Determines the translation language for shared text from another app: \$toLanguageShareDefault',
      name: 'default_share_language_summary',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Team`
  String get team {
    return Intl.message(
      'Team',
      name: 'team',
      desc: '',
      args: [],
    );
  }

  /// `Coders, translators and testers`
  String get team_summary {
    return Intl.message(
      'Coders, translators and testers',
      name: 'team_summary',
      desc: '',
      args: [],
    );
  }

  /// `Contribute`
  String get contribute {
    return Intl.message(
      'Contribute',
      name: 'contribute',
      desc: '',
      args: [],
    );
  }

  /// `Help make it better!`
  String get contribute_summary {
    return Intl.message(
      'Help make it better!',
      name: 'contribute_summary',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `License`
  String get license {
    return Intl.message(
      'License',
      name: 'license',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get donate {
    return Intl.message(
      'Donate',
      name: 'donate',
      desc: '',
      args: [],
    );
  }

  /// `Liberapay`
  String get liberapay {
    return Intl.message(
      'Liberapay',
      name: 'liberapay',
      desc: '',
      args: [],
    );
  }

  /// `Report a bug`
  String get report_bug {
    return Intl.message(
      'Report a bug',
      name: 'report_bug',
      desc: '',
      args: [],
    );
  }

  /// `Website`
  String get website {
    return Intl.message(
      'Website',
      name: 'website',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Spread it to the world!`
  String get translate_summary {
    return Intl.message(
      'Spread it to the world!',
      name: 'translate_summary',
      desc: '',
      args: [],
    );
  }

  /// `We appreciate it!`
  String get donate_summary {
    return Intl.message(
      'We appreciate it!',
      name: 'donate_summary',
      desc: '',
      args: [],
    );
  }

  /// `Please let us know`
  String get report_bug_summary {
    return Intl.message(
      'Please let us know',
      name: 'report_bug_summary',
      desc: '',
      args: [],
    );
  }

  /// `Text Recognition`
  String get text_recognition {
    return Intl.message(
      'Text Recognition',
      name: 'text_recognition',
      desc: '',
      args: [],
    );
  }

  /// `Download trained data files`
  String get download_trained_data_files {
    return Intl.message(
      'Download trained data files',
      name: 'download_trained_data_files',
      desc: '',
      args: [],
    );
  }

  /// `Text Recognition - $language`
  String get language_text_recognition {
    return Intl.message(
      'Text Recognition - \$language',
      name: 'language_text_recognition',
      desc: '',
      args: [],
    );
  }

  /// `Trained data files are not installed.`
  String get trained_data_files_not_installed {
    return Intl.message(
      'Trained data files are not installed.',
      name: 'trained_data_files_not_installed',
      desc: '',
      args: [],
    );
  }

  /// `Install`
  String get install {
    return Intl.message(
      'Install',
      name: 'install',
      desc: '',
      args: [],
    );
  }

  /// `Camera is not accessible`
  String get camera_is_not_accessible {
    return Intl.message(
      'Camera is not accessible',
      name: 'camera_is_not_accessible',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<L10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'el'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fa'),
      Locale.fromSubtags(languageCode: 'fi'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'nb', countryCode: 'NO'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'uk'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'HK'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<L10n> load(Locale locale) => L10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
