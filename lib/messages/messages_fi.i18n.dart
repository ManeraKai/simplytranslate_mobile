// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'fi';
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

class MessagesFi extends Messages {
  const MessagesFi();
  String get locale => "fi";
  String get languageCode => "fi";
  LangsMessagesFi get langs => LangsMessagesFi(this);
  MainMessagesFi get main => MainMessagesFi(this);
}

class LangsMessagesFi extends LangsMessages {
  final MessagesFi _parent;
  const LangsMessagesFi(this._parent) : super(_parent);
  String get afrikaans => """afrikaans""";
  String get albanian => """albania""";
  String get amharic => """amhara""";
  String get arabic => """arabia""";
  String get armenian => """armenia""";
  String get autodetect => """Automaattinen""";
  String get azerbaijani => """azerbaidžani""";
  String get basque => """baski""";
  String get belarusian => """valkovenäjä""";
  String get bengali => """bengali""";
  String get bosnian => """bosnia""";
  String get bulgarian => """bulgaria""";
  String get catalan => """katalaani""";
  String get cebuano => """cebuano""";
  String get chichewa => """chichewa""";
  String get chinese => """kiina""";
  String get corsican => """korsika""";
  String get croatian => """kroaatti""";
  String get czech => """tšekki""";
  String get danish => """tanska""";
  String get dutch => """hollanti""";
  String get english => """englanti""";
  String get esperanto => """esperanto""";
  String get estonian => """viro""";
  String get filipino => """Filipino""";
  String get finnish => """suomi""";
  String get french => """ranska""";
  String get frisian => """friisi""";
  String get galician => """Galician""";
  String get georgian => """Georgian""";
  String get german => """saksa""";
  String get greek => """kreikka""";
  String get gujarati => """gudžarati""";
  String get haitian_creole => """Haitin kreoli""";
  String get hausa => """hausa""";
  String get hawaiian => """havaiji""";
  String get hebrew => """heprea""";
  String get hindi => """hindi""";
  String get hmong => """hmong""";
  String get hungarian => """unkari""";
  String get icelandic => """islanti""";
  String get igbo => """igbo""";
  String get indonesian => """indonesia""";
  String get irish => """iiri""";
  String get italian => """italia""";
  String get japanese => """japani""";
  String get javanese => """jaava""";
  String get kannada => """kannada""";
  String get kazakh => """kazakki""";
  String get khmer => """khmer""";
  String get kinyarwanda => """kinyarwanda""";
  String get korean => """korea""";
  String get kurdish_kurmanji => """kurdi (kurmanji)""";
  String get kyrgyz => """kirgiisi""";
  String get lao => """lao""";
  String get latin => """latina""";
  String get latvian => """latvia""";
  String get lithuanian => """liettua""";
  String get luxembourgish => """Luxembourgish""";
  String get macedonian => """Macedonian""";
  String get malagasy => """Malagasy""";
  String get malay => """Malay""";
  String get malayalam => """Malayalam""";
  String get maltese => """malta""";
  String get maori => """maori""";
  String get marathi => """marathi""";
  String get mongolian => """mongoli""";
  String get myanmar_burmese => """Myanmar (Burmese)""";
  String get nepali => """nepali""";
  String get norwegian => """norja""";
  String get odia_oriya => """Odia (Oriya)""";
  String get pashto => """paštu""";
  String get persian => """persia""";
  String get polish => """puola""";
  String get portuguese => """portugali""";
  String get punjabi => """punjabi""";
  String get romanian => """romania""";
  String get russian => """venäjä""";
  String get samoan => """Samoan""";
  String get scots_gaelic => """skotlantilainen gaeli""";
  String get serbian => """Serbian""";
  String get sesotho => """Sesotho""";
  String get shona => """Shona""";
  String get sindhi => """Sindhi""";
  String get sinhala => """Sinhala""";
  String get slovak => """slovakki""";
  String get slovenian => """Slovenian""";
  String get somali => """somali""";
  String get spanish => """espanja""";
  String get sundanese => """Sundanese""";
  String get swahili => """Swahili""";
  String get swedish => """ruotsi""";
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
  String get uzbek => """uzbekki""";
  String get vietnamese => """Vietnamese""";
  String get welsh => """kymri""";
  String get xhosa => """xhosa""";
  String get yiddish => """jiddiš""";
  String get yoruba => """joruba""";
  String get zulu => """zulu""";
}

class MainMessagesFi extends MainMessages {
  final MessagesFi _parent;
  const MainMessagesFi(this._parent) : super(_parent);
  String get about => """Tietoja""";
  String get appearance => """Ulkonäkö""";
  String get audio_limit => """Ääntä ei voi saada yli 200 merkille""";
  String get autodetect_not_supported =>
      """Automaattista tunnistusta ei tueta""";
  String get cancel => """Peruuta""";
  String get contribute => """Osallistu""";
  String get copied_to_clipboard => """Tallennettu leikepöydälle""";
  String get dark => """Tumma""";
  String get definitions => """Määritelmät""";
  String get donate => """Lahjoita""";
  String get enter_text_here => """Kirjoita teksti tähän""";
  String get error => """Tapahtui virhe""";
  String get follow_system => """Seuraa järjestelmää""";
  String get help => """Apua""";
  String get input_limit => """Käännöksen syöttö on yli 5000""";
  String get install => """Asenna""";
  String get license => """Lisenssi""";
  String get light => """Vaalea""";
  String get no_internet => """Ei internet-yhteyttä""";
  String get ok => """OK""";
  String get report_bug => """Ilmoita virheestä""";
  String get settings => """Asetukset""";
  String get something_went_wrong => """Jokin meni pieleen""";
  String get text_recognition => """Tekstintunnistus""";
  String get text_to_speech => """Teksti puheeksi""";
  String get theme => """Teema""";
  String get translate => """Käännä""";
  String get translation => """Käännös""";
  String get translations => """Käännökset""";
  String get version => """Versio""";
  String get website => """Verkkosivusto""";
}

Map<String, String> get messagesFiMap => {
      """langs.afrikaans""": """afrikaans""",
      """langs.albanian""": """albania""",
      """langs.amharic""": """amhara""",
      """langs.arabic""": """arabia""",
      """langs.armenian""": """armenia""",
      """langs.autodetect""": """Automaattinen""",
      """langs.azerbaijani""": """azerbaidžani""",
      """langs.basque""": """baski""",
      """langs.belarusian""": """valkovenäjä""",
      """langs.bengali""": """bengali""",
      """langs.bosnian""": """bosnia""",
      """langs.bulgarian""": """bulgaria""",
      """langs.catalan""": """katalaani""",
      """langs.cebuano""": """cebuano""",
      """langs.chichewa""": """chichewa""",
      """langs.chinese""": """kiina""",
      """langs.corsican""": """korsika""",
      """langs.croatian""": """kroaatti""",
      """langs.czech""": """tšekki""",
      """langs.danish""": """tanska""",
      """langs.dutch""": """hollanti""",
      """langs.english""": """englanti""",
      """langs.esperanto""": """esperanto""",
      """langs.estonian""": """viro""",
      """langs.filipino""": """Filipino""",
      """langs.finnish""": """suomi""",
      """langs.french""": """ranska""",
      """langs.frisian""": """friisi""",
      """langs.galician""": """Galician""",
      """langs.georgian""": """Georgian""",
      """langs.german""": """saksa""",
      """langs.greek""": """kreikka""",
      """langs.gujarati""": """gudžarati""",
      """langs.haitian_creole""": """Haitin kreoli""",
      """langs.hausa""": """hausa""",
      """langs.hawaiian""": """havaiji""",
      """langs.hebrew""": """heprea""",
      """langs.hindi""": """hindi""",
      """langs.hmong""": """hmong""",
      """langs.hungarian""": """unkari""",
      """langs.icelandic""": """islanti""",
      """langs.igbo""": """igbo""",
      """langs.indonesian""": """indonesia""",
      """langs.irish""": """iiri""",
      """langs.italian""": """italia""",
      """langs.japanese""": """japani""",
      """langs.javanese""": """jaava""",
      """langs.kannada""": """kannada""",
      """langs.kazakh""": """kazakki""",
      """langs.khmer""": """khmer""",
      """langs.kinyarwanda""": """kinyarwanda""",
      """langs.korean""": """korea""",
      """langs.kurdish_kurmanji""": """kurdi (kurmanji)""",
      """langs.kyrgyz""": """kirgiisi""",
      """langs.lao""": """lao""",
      """langs.latin""": """latina""",
      """langs.latvian""": """latvia""",
      """langs.lithuanian""": """liettua""",
      """langs.luxembourgish""": """Luxembourgish""",
      """langs.macedonian""": """Macedonian""",
      """langs.malagasy""": """Malagasy""",
      """langs.malay""": """Malay""",
      """langs.malayalam""": """Malayalam""",
      """langs.maltese""": """malta""",
      """langs.maori""": """maori""",
      """langs.marathi""": """marathi""",
      """langs.mongolian""": """mongoli""",
      """langs.myanmar_burmese""": """Myanmar (Burmese)""",
      """langs.nepali""": """nepali""",
      """langs.norwegian""": """norja""",
      """langs.odia_oriya""": """Odia (Oriya)""",
      """langs.pashto""": """paštu""",
      """langs.persian""": """persia""",
      """langs.polish""": """puola""",
      """langs.portuguese""": """portugali""",
      """langs.punjabi""": """punjabi""",
      """langs.romanian""": """romania""",
      """langs.russian""": """venäjä""",
      """langs.samoan""": """Samoan""",
      """langs.scots_gaelic""": """skotlantilainen gaeli""",
      """langs.serbian""": """Serbian""",
      """langs.sesotho""": """Sesotho""",
      """langs.shona""": """Shona""",
      """langs.sindhi""": """Sindhi""",
      """langs.sinhala""": """Sinhala""",
      """langs.slovak""": """slovakki""",
      """langs.slovenian""": """Slovenian""",
      """langs.somali""": """somali""",
      """langs.spanish""": """espanja""",
      """langs.sundanese""": """Sundanese""",
      """langs.swahili""": """Swahili""",
      """langs.swedish""": """ruotsi""",
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
      """langs.uzbek""": """uzbekki""",
      """langs.vietnamese""": """Vietnamese""",
      """langs.welsh""": """kymri""",
      """langs.xhosa""": """xhosa""",
      """langs.yiddish""": """jiddiš""",
      """langs.yoruba""": """joruba""",
      """langs.zulu""": """zulu""",
      """main.about""": """Tietoja""",
      """main.appearance""": """Ulkonäkö""",
      """main.audio_limit""": """Ääntä ei voi saada yli 200 merkille""",
      """main.autodetect_not_supported""":
          """Automaattista tunnistusta ei tueta""",
      """main.cancel""": """Peruuta""",
      """main.contribute""": """Osallistu""",
      """main.copied_to_clipboard""": """Tallennettu leikepöydälle""",
      """main.dark""": """Tumma""",
      """main.definitions""": """Määritelmät""",
      """main.donate""": """Lahjoita""",
      """main.enter_text_here""": """Kirjoita teksti tähän""",
      """main.error""": """Tapahtui virhe""",
      """main.follow_system""": """Seuraa järjestelmää""",
      """main.help""": """Apua""",
      """main.input_limit""": """Käännöksen syöttö on yli 5000""",
      """main.install""": """Asenna""",
      """main.license""": """Lisenssi""",
      """main.light""": """Vaalea""",
      """main.no_internet""": """Ei internet-yhteyttä""",
      """main.ok""": """OK""",
      """main.report_bug""": """Ilmoita virheestä""",
      """main.settings""": """Asetukset""",
      """main.something_went_wrong""": """Jokin meni pieleen""",
      """main.text_recognition""": """Tekstintunnistus""",
      """main.text_to_speech""": """Teksti puheeksi""",
      """main.theme""": """Teema""",
      """main.translate""": """Käännä""",
      """main.translation""": """Käännös""",
      """main.translations""": """Käännökset""",
      """main.version""": """Versio""",
      """main.website""": """Verkkosivusto""",
    };
