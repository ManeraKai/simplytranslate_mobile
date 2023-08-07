// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'en';
String _plural(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i18n.plural(count, _languageCode,
        zero: zero, one: one, two: two, few: few, many: many, other: other);
String _ordinal(int count,
        {String? zero,
        String? one,
        String? two,
        String? few,
        String? many,
        String? other}) =>
    i18n.ordinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );
String _cardinal(
  int count, {
  String? zero,
  String? one,
  String? two,
  String? few,
  String? many,
  String? other,
}) =>
    i18n.cardinal(
      count,
      _languageCode,
      zero: zero,
      one: one,
      two: two,
      few: few,
      many: many,
      other: other,
    );

class MessagesEn extends Messages {
  const MessagesEn();
  String get locale => "en";
  String get languageCode => "en";
  LangsMessagesEn get langs => LangsMessagesEn(this);
  MainMessagesEn get main => MainMessagesEn(this);
}

class LangsMessagesEn extends LangsMessages {
  final MessagesEn _parent;
  const LangsMessagesEn(this._parent) : super(_parent);
  String get afrikaans => """Afrikaans""";
  String get albanian => """Albanian""";
  String get amharic => """Amharic""";
  String get arabic => """Arabic""";
  String get armenian => """Armenian""";
  String get autodetect => """Autodetect""";
  String get azerbaijani => """Azerbaijani""";
  String get basque => """Basque""";
  String get belarusian => """Belarusian""";
  String get bengali => """Bengali""";
  String get bosnian => """Bosnian""";
  String get bulgarian => """Bulgarian""";
  String get catalan => """Catalan""";
  String get cebuano => """Cebuano""";
  String get chichewa => """Chichewa""";
  String get chinese => """Chinese""";
  String get corsican => """Corsican""";
  String get croatian => """Croatian""";
  String get czech => """Czech""";
  String get danish => """Danish""";
  String get dutch => """Dutch""";
  String get english => """English""";
  String get esperanto => """Esperanto""";
  String get estonian => """Estonian""";
  String get filipino => """Filipino""";
  String get finnish => """Finnish""";
  String get french => """French""";
  String get frisian => """Frisian""";
  String get galician => """Galician""";
  String get georgian => """Georgian""";
  String get german => """German""";
  String get greek => """Greek""";
  String get gujarati => """Gujarati""";
  String get haitian_creole => """Haitian Creole""";
  String get hausa => """Hausa""";
  String get hawaiian => """Hawaiian""";
  String get hebrew => """Hebrew""";
  String get hindi => """Hindi""";
  String get hmong => """Hmong""";
  String get hungarian => """Hungarian""";
  String get icelandic => """Icelandic""";
  String get igbo => """Igbo""";
  String get indonesian => """Indonesian""";
  String get irish => """Irish""";
  String get italian => """Italian""";
  String get japanese => """Japanese""";
  String get javanese => """Javanese""";
  String get kannada => """Kannada""";
  String get kazakh => """Kazakh""";
  String get khmer => """Khmer""";
  String get kinyarwanda => """Kinyarwanda""";
  String get korean => """Korean""";
  String get kurdish_kurmanji => """Kurdish (Kurmanji)""";
  String get kyrgyz => """Kyrgyz""";
  String get lao => """Lao""";
  String get latin => """Latin""";
  String get latvian => """Latvian""";
  String get lithuanian => """Lithuanian""";
  String get luxembourgish => """Luxembourgish""";
  String get macedonian => """Macedonian""";
  String get malagasy => """Malagasy""";
  String get malay => """Malay""";
  String get malayalam => """Malayalam""";
  String get maltese => """Maltese""";
  String get maori => """Maori""";
  String get marathi => """Marathi""";
  String get mongolian => """Mongolian""";
  String get myanmar_burmese => """Myanmar (Burmese)""";
  String get nepali => """Nepali""";
  String get norwegian => """Norwegian""";
  String get odia_oriya => """Odia (Oriya)""";
  String get pashto => """Pashto""";
  String get persian => """Persian""";
  String get polish => """Polish""";
  String get portuguese => """Portuguese""";
  String get punjabi => """Punjabi""";
  String get romanian => """Romanian""";
  String get russian => """Russian""";
  String get samoan => """Samoan""";
  String get scots_gaelic => """Scots Gaelic""";
  String get serbian => """Serbian""";
  String get sesotho => """Sesotho""";
  String get shona => """Shona""";
  String get sindhi => """Sindhi""";
  String get sinhala => """Sinhala""";
  String get slovak => """Slovak""";
  String get slovenian => """Slovenian""";
  String get somali => """Somali""";
  String get spanish => """Spanish""";
  String get sundanese => """Sundanese""";
  String get swahili => """Swahili""";
  String get swedish => """Swedish""";
  String get tajik => """Tajik""";
  String get tamil => """Tamil""";
  String get tatar => """Tatar""";
  String get telugu => """Telugu""";
  String get thai => """Thai""";
  String get traditional_chinese => """Traditional Chinese""";
  String get turkish => """Turkish""";
  String get turkmen => """Turkmen""";
  String get ukrainian => """Ukrainian""";
  String get urdu => """Urdu""";
  String get uyghur => """Uyghur""";
  String get uzbek => """Uzbek""";
  String get vietnamese => """Vietnamese""";
  String get welsh => """Welsh""";
  String get xhosa => """Xhosa""";
  String get yiddish => """Yiddish""";
  String get yoruba => """Yoruba""";
  String get zulu => """Zulu""";
}

class MainMessagesEn extends MainMessages {
  final MessagesEn _parent;
  const MainMessagesEn(this._parent) : super(_parent);
  String get about => """About""";
  String get appearance => """Appearance""";
  String get audio_limit => """Cannot get audio for more than 200 characters""";
  String get autodetect_not_supported => """Autodetect not supported""";
  String get cancel => """Cancel""";
  String get contribute => """Contribute""";
  String get copied_to_clipboard => """Copied to clipboard""";
  String get dark => """Dark""";
  String get definitions => """Definitions""";
  String get donate => """Donate""";
  String get enter_text_here => """Enter text here""";
  String get error => """There was an error""";
  String get follow_system => """Follow system""";
  String get help => """Help""";
  String get input_limit => """The translation input is above 5000""";
  String get install => """Install""";
  String get license => """License""";
  String get light => """Light""";
  String get no_internet => """No internet connection""";
  String get ok => """OK""";
  String get report_bug => """Report a bug""";
  String get settings => """Settings""";
  String get something_went_wrong => """Something went wrong""";
  String get text_recognition => """Text Recognition""";
  String get text_to_speech => """Text-To-Speech""";
  String get theme => """Theme""";
  String get translate => """Translate""";
  String get translation => """Translation""";
  String get translations => """Translations""";
  String get version => """Version""";
  String get website => """Website""";
}

Map<String, String> get messagesEnMap => {
      """langs.afrikaans""": """Afrikaans""",
      """langs.albanian""": """Albanian""",
      """langs.amharic""": """Amharic""",
      """langs.arabic""": """Arabic""",
      """langs.armenian""": """Armenian""",
      """langs.autodetect""": """Autodetect""",
      """langs.azerbaijani""": """Azerbaijani""",
      """langs.basque""": """Basque""",
      """langs.belarusian""": """Belarusian""",
      """langs.bengali""": """Bengali""",
      """langs.bosnian""": """Bosnian""",
      """langs.bulgarian""": """Bulgarian""",
      """langs.catalan""": """Catalan""",
      """langs.cebuano""": """Cebuano""",
      """langs.chichewa""": """Chichewa""",
      """langs.chinese""": """Chinese""",
      """langs.corsican""": """Corsican""",
      """langs.croatian""": """Croatian""",
      """langs.czech""": """Czech""",
      """langs.danish""": """Danish""",
      """langs.dutch""": """Dutch""",
      """langs.english""": """English""",
      """langs.esperanto""": """Esperanto""",
      """langs.estonian""": """Estonian""",
      """langs.filipino""": """Filipino""",
      """langs.finnish""": """Finnish""",
      """langs.french""": """French""",
      """langs.frisian""": """Frisian""",
      """langs.galician""": """Galician""",
      """langs.georgian""": """Georgian""",
      """langs.german""": """German""",
      """langs.greek""": """Greek""",
      """langs.gujarati""": """Gujarati""",
      """langs.haitian_creole""": """Haitian Creole""",
      """langs.hausa""": """Hausa""",
      """langs.hawaiian""": """Hawaiian""",
      """langs.hebrew""": """Hebrew""",
      """langs.hindi""": """Hindi""",
      """langs.hmong""": """Hmong""",
      """langs.hungarian""": """Hungarian""",
      """langs.icelandic""": """Icelandic""",
      """langs.igbo""": """Igbo""",
      """langs.indonesian""": """Indonesian""",
      """langs.irish""": """Irish""",
      """langs.italian""": """Italian""",
      """langs.japanese""": """Japanese""",
      """langs.javanese""": """Javanese""",
      """langs.kannada""": """Kannada""",
      """langs.kazakh""": """Kazakh""",
      """langs.khmer""": """Khmer""",
      """langs.kinyarwanda""": """Kinyarwanda""",
      """langs.korean""": """Korean""",
      """langs.kurdish_kurmanji""": """Kurdish (Kurmanji)""",
      """langs.kyrgyz""": """Kyrgyz""",
      """langs.lao""": """Lao""",
      """langs.latin""": """Latin""",
      """langs.latvian""": """Latvian""",
      """langs.lithuanian""": """Lithuanian""",
      """langs.luxembourgish""": """Luxembourgish""",
      """langs.macedonian""": """Macedonian""",
      """langs.malagasy""": """Malagasy""",
      """langs.malay""": """Malay""",
      """langs.malayalam""": """Malayalam""",
      """langs.maltese""": """Maltese""",
      """langs.maori""": """Maori""",
      """langs.marathi""": """Marathi""",
      """langs.mongolian""": """Mongolian""",
      """langs.myanmar_burmese""": """Myanmar (Burmese)""",
      """langs.nepali""": """Nepali""",
      """langs.norwegian""": """Norwegian""",
      """langs.odia_oriya""": """Odia (Oriya)""",
      """langs.pashto""": """Pashto""",
      """langs.persian""": """Persian""",
      """langs.polish""": """Polish""",
      """langs.portuguese""": """Portuguese""",
      """langs.punjabi""": """Punjabi""",
      """langs.romanian""": """Romanian""",
      """langs.russian""": """Russian""",
      """langs.samoan""": """Samoan""",
      """langs.scots_gaelic""": """Scots Gaelic""",
      """langs.serbian""": """Serbian""",
      """langs.sesotho""": """Sesotho""",
      """langs.shona""": """Shona""",
      """langs.sindhi""": """Sindhi""",
      """langs.sinhala""": """Sinhala""",
      """langs.slovak""": """Slovak""",
      """langs.slovenian""": """Slovenian""",
      """langs.somali""": """Somali""",
      """langs.spanish""": """Spanish""",
      """langs.sundanese""": """Sundanese""",
      """langs.swahili""": """Swahili""",
      """langs.swedish""": """Swedish""",
      """langs.tajik""": """Tajik""",
      """langs.tamil""": """Tamil""",
      """langs.tatar""": """Tatar""",
      """langs.telugu""": """Telugu""",
      """langs.thai""": """Thai""",
      """langs.traditional_chinese""": """Traditional Chinese""",
      """langs.turkish""": """Turkish""",
      """langs.turkmen""": """Turkmen""",
      """langs.ukrainian""": """Ukrainian""",
      """langs.urdu""": """Urdu""",
      """langs.uyghur""": """Uyghur""",
      """langs.uzbek""": """Uzbek""",
      """langs.vietnamese""": """Vietnamese""",
      """langs.welsh""": """Welsh""",
      """langs.xhosa""": """Xhosa""",
      """langs.yiddish""": """Yiddish""",
      """langs.yoruba""": """Yoruba""",
      """langs.zulu""": """Zulu""",
      """main.about""": """About""",
      """main.appearance""": """Appearance""",
      """main.audio_limit""":
          """Cannot get audio for more than 200 characters""",
      """main.autodetect_not_supported""": """Autodetect not supported""",
      """main.cancel""": """Cancel""",
      """main.contribute""": """Contribute""",
      """main.copied_to_clipboard""": """Copied to clipboard""",
      """main.dark""": """Dark""",
      """main.definitions""": """Definitions""",
      """main.donate""": """Donate""",
      """main.enter_text_here""": """Enter text here""",
      """main.error""": """There was an error""",
      """main.follow_system""": """Follow system""",
      """main.help""": """Help""",
      """main.input_limit""": """The translation input is above 5000""",
      """main.install""": """Install""",
      """main.license""": """License""",
      """main.light""": """Light""",
      """main.no_internet""": """No internet connection""",
      """main.ok""": """OK""",
      """main.report_bug""": """Report a bug""",
      """main.settings""": """Settings""",
      """main.something_went_wrong""": """Something went wrong""",
      """main.text_recognition""": """Text Recognition""",
      """main.text_to_speech""": """Text-To-Speech""",
      """main.theme""": """Theme""",
      """main.translate""": """Translate""",
      """main.translation""": """Translation""",
      """main.translations""": """Translations""",
      """main.version""": """Version""",
      """main.website""": """Website""",
    };
