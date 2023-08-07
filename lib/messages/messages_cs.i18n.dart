// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'cs';
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

class MessagesCs extends Messages {
  const MessagesCs();
  String get locale => "cs";
  String get languageCode => "cs";
  LangsMessagesCs get langs => LangsMessagesCs(this);
  MainMessagesCs get main => MainMessagesCs(this);
}

class LangsMessagesCs extends LangsMessages {
  final MessagesCs _parent;
  const LangsMessagesCs(this._parent) : super(_parent);
  String get afrikaans => """afrikánština""";
  String get albanian => """albánština""";
  String get amharic => """amharština""";
  String get arabic => """arabština""";
  String get armenian => """arménština""";
  String get autodetect => """Detekovat automaticky""";
  String get azerbaijani => """ázerbájdžánština""";
  String get basque => """baskičtina""";
  String get belarusian => """běloruština""";
  String get bengali => """bengálština""";
  String get bosnian => """bosenština""";
  String get bulgarian => """bulharština""";
  String get catalan => """katalánština""";
  String get cebuano => """cebuánština""";
  String get chichewa => """Chichewa""";
  String get chinese => """čínština""";
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
  String get zulu => """Zul""";
}

class MainMessagesCs extends MainMessages {
  final MessagesCs _parent;
  const MainMessagesCs(this._parent) : super(_parent);
  String get about => """O aplikaci""";
  String get appearance => """Vzhled""";
  String get audio_limit => """Nelze získat zvuk pro více než 200 znaků""";
  String get autodetect_not_supported =>
      """Automatická detekce není podporována""";
  String get cancel => """Zrušit""";
  String get contribute => """Přispějte""";
  String get copied_to_clipboard => """Zkopírováno do schránky""";
  String get dark => """Tmavý""";
  String get definitions => """Definice""";
  String get donate => """Darovat""";
  String get enter_text_here => """Zde zadejte text""";
  String get error => """Něco se nepovedlo""";
  String get follow_system => """Systémový""";
  String get help => """Nápověda""";
  String get input_limit => """Chcete přeložit více než 5000 znaků""";
  String get install => """Nainstalovat""";
  String get license => """Licence""";
  String get light => """Světlý""";
  String get no_internet => """Jste bez internetu""";
  String get ok => """OK""";
  String get report_bug => """Nahlásit chybu""";
  String get settings => """Nastavení""";
  String get something_went_wrong => """Něco se pokazilo""";
  String get text_recognition => """Rozpoznávání textu""";
  String get text_to_speech => """Převod textu na řeč""";
  String get theme => """Motiv""";
  String get translate => """Přeložit""";
  String get translation => """Překlad""";
  String get translations => """Překlady""";
  String get version => """Verze""";
  String get website => """Webové stránky""";
}

Map<String, String> get messagesCsMap => {
      """langs.afrikaans""": """afrikánština""",
      """langs.albanian""": """albánština""",
      """langs.amharic""": """amharština""",
      """langs.arabic""": """arabština""",
      """langs.armenian""": """arménština""",
      """langs.autodetect""": """Detekovat automaticky""",
      """langs.azerbaijani""": """ázerbájdžánština""",
      """langs.basque""": """baskičtina""",
      """langs.belarusian""": """běloruština""",
      """langs.bengali""": """bengálština""",
      """langs.bosnian""": """bosenština""",
      """langs.bulgarian""": """bulharština""",
      """langs.catalan""": """katalánština""",
      """langs.cebuano""": """cebuánština""",
      """langs.chichewa""": """Chichewa""",
      """langs.chinese""": """čínština""",
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
      """langs.zulu""": """Zul""",
      """main.about""": """O aplikaci""",
      """main.appearance""": """Vzhled""",
      """main.audio_limit""": """Nelze získat zvuk pro více než 200 znaků""",
      """main.autodetect_not_supported""":
          """Automatická detekce není podporována""",
      """main.cancel""": """Zrušit""",
      """main.contribute""": """Přispějte""",
      """main.copied_to_clipboard""": """Zkopírováno do schránky""",
      """main.dark""": """Tmavý""",
      """main.definitions""": """Definice""",
      """main.donate""": """Darovat""",
      """main.enter_text_here""": """Zde zadejte text""",
      """main.error""": """Něco se nepovedlo""",
      """main.follow_system""": """Systémový""",
      """main.help""": """Nápověda""",
      """main.input_limit""": """Chcete přeložit více než 5000 znaků""",
      """main.install""": """Nainstalovat""",
      """main.license""": """Licence""",
      """main.light""": """Světlý""",
      """main.no_internet""": """Jste bez internetu""",
      """main.ok""": """OK""",
      """main.report_bug""": """Nahlásit chybu""",
      """main.settings""": """Nastavení""",
      """main.something_went_wrong""": """Něco se pokazilo""",
      """main.text_recognition""": """Rozpoznávání textu""",
      """main.text_to_speech""": """Převod textu na řeč""",
      """main.theme""": """Motiv""",
      """main.translate""": """Přeložit""",
      """main.translation""": """Překlad""",
      """main.translations""": """Překlady""",
      """main.version""": """Verze""",
      """main.website""": """Webové stránky""",
    };
