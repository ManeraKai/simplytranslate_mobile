// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'pl';
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

class MessagesPl extends Messages {
  const MessagesPl();
  String get locale => "pl";
  String get languageCode => "pl";
  LangsMessagesPl get langs => LangsMessagesPl(this);
  MainMessagesPl get main => MainMessagesPl(this);
}

class LangsMessagesPl extends LangsMessages {
  final MessagesPl _parent;
  const LangsMessagesPl(this._parent) : super(_parent);
  String get afrikaans => """afrikaans""";
  String get albanian => """albański""";
  String get amharic => """amharski""";
  String get arabic => """arabski""";
  String get armenian => """ormiański""";
  String get autodetect => """Autowykrywanie""";
  String get azerbaijani => """azerski""";
  String get basque => """baskijski""";
  String get belarusian => """białoruski""";
  String get bengali => """bengalski""";
  String get bosnian => """bośniacki""";
  String get bulgarian => """bułgarski""";
  String get catalan => """kataloński""";
  String get cebuano => """cebuański""";
  String get chichewa => """cziczewa""";
  String get chinese => """chiński""";
  String get corsican => """korsykański""";
  String get croatian => """chorwacki""";
  String get czech => """czeski""";
  String get danish => """duński""";
  String get dutch => """niderlandzki""";
  String get english => """angielski""";
  String get esperanto => """esperanto""";
  String get estonian => """estoński""";
  String get filipino => """filipiński""";
  String get finnish => """fiński""";
  String get french => """francuski""";
  String get frisian => """fryzyjski""";
  String get galician => """galicyjski""";
  String get georgian => """gruziński""";
  String get german => """niemiecki""";
  String get greek => """grecki""";
  String get gujarati => """gudżarati""";
  String get haitian_creole => """kreolski (Haiti)""";
  String get hausa => """hausa""";
  String get hawaiian => """hawajski""";
  String get hebrew => """hebrajski""";
  String get hindi => """hindi""";
  String get hmong => """hmong""";
  String get hungarian => """węgierski""";
  String get icelandic => """islandzki""";
  String get igbo => """igbo""";
  String get indonesian => """indonezyjski""";
  String get irish => """irlandzki""";
  String get italian => """włoski""";
  String get japanese => """japoński""";
  String get javanese => """jawajski""";
  String get kannada => """kannada""";
  String get kazakh => """kazachski""";
  String get khmer => """khmerski""";
  String get kinyarwanda => """ruanda-rundi""";
  String get korean => """koreański""";
  String get kurdish_kurmanji => """kurdyjski""";
  String get kyrgyz => """kirgiski""";
  String get lao => """laotański""";
  String get latin => """łaciński""";
  String get latvian => """łotewski""";
  String get lithuanian => """litewski""";
  String get luxembourgish => """luksemburski""";
  String get macedonian => """macedoński""";
  String get malagasy => """malgaski""";
  String get malay => """malajski""";
  String get malayalam => """malajalam""";
  String get maltese => """maltański""";
  String get maori => """maori""";
  String get marathi => """marathi""";
  String get mongolian => """mongolski""";
  String get myanmar_burmese => """birmański""";
  String get nepali => """nepalski""";
  String get norwegian => """norweski""";
  String get odia_oriya => """orija""";
  String get pashto => """paszto""";
  String get persian => """perski""";
  String get polish => """polski""";
  String get portuguese => """portugalski""";
  String get punjabi => """pendżabski""";
  String get romanian => """rumuński""";
  String get russian => """rosyjski""";
  String get samoan => """samoański""";
  String get scots_gaelic => """szkocki gaelicki""";
  String get serbian => """serbski""";
  String get sesotho => """sotho""";
  String get shona => """shona""";
  String get sindhi => """sindhi""";
  String get sinhala => """syngaleski""";
  String get slovak => """słowacki""";
  String get slovenian => """słoweński""";
  String get somali => """somalijski""";
  String get spanish => """hiszpański""";
  String get sundanese => """sundajski""";
  String get swahili => """suahili""";
  String get swedish => """szwedzki""";
  String get tajik => """tadżycki""";
  String get tamil => """tamilski""";
  String get tatar => """tatarski""";
  String get telugu => """telugu""";
  String get thai => """tajski""";
  String get traditional_chinese => """Traditional Chinese""";
  String get turkish => """turecki""";
  String get turkmen => """turkmeński""";
  String get ukrainian => """ukraiński""";
  String get urdu => """urdu""";
  String get uyghur => """ujgurski""";
  String get uzbek => """uzbecki""";
  String get vietnamese => """wietnamski""";
  String get welsh => """walijski""";
  String get xhosa => """xhosa""";
  String get yiddish => """jidysz""";
  String get yoruba => """joruba""";
  String get zulu => """zulu""";
}

class MainMessagesPl extends MainMessages {
  final MessagesPl _parent;
  const MainMessagesPl(this._parent) : super(_parent);
  String get about => """O aplikacji""";
  String get appearance => """Wygląd""";
  String get audio_limit =>
      """Nie można uzyskać dźwięku dla ponad 200 znaków""";
  String get autodetect_not_supported =>
      """Autowykrywanie nie jest obsługiwane""";
  String get cancel => """Anuluj""";
  String get contribute => """Wnieś swój wkład""";
  String get copied_to_clipboard => """Skopiowano do schowka""";
  String get dark => """Ciemny""";
  String get definitions => """Definicje""";
  String get donate => """Wesprzyj""";
  String get enter_text_here => """Wpisz tutaj tekst""";
  String get error => """Wystąpił błąd""";
  String get follow_system => """Zgodny z systemowym""";
  String get help => """Pomoc""";
  String get input_limit => """Tekst źródłowy ma ponad 5000 znaków""";
  String get install => """Zainstaluj""";
  String get license => """Licencja""";
  String get light => """Jasny""";
  String get no_internet => """Brak połączenia z Internetem""";
  String get ok => """OK""";
  String get report_bug => """Zgłoś błąd""";
  String get settings => """Ustawienia""";
  String get something_went_wrong => """Coś poszło nie tak""";
  String get text_recognition => """Rozpoznawanie tekstu""";
  String get text_to_speech => """Zamiana tekstu na mowę""";
  String get theme => """Motyw""";
  String get translate => """Przetłumacz""";
  String get translation => """Tłumaczenie""";
  String get translations => """Tłumaczenia""";
  String get version => """Wersja""";
  String get website => """Strona internetowa""";
}

Map<String, String> get messagesPlMap => {
      """langs.afrikaans""": """afrikaans""",
      """langs.albanian""": """albański""",
      """langs.amharic""": """amharski""",
      """langs.arabic""": """arabski""",
      """langs.armenian""": """ormiański""",
      """langs.autodetect""": """Autowykrywanie""",
      """langs.azerbaijani""": """azerski""",
      """langs.basque""": """baskijski""",
      """langs.belarusian""": """białoruski""",
      """langs.bengali""": """bengalski""",
      """langs.bosnian""": """bośniacki""",
      """langs.bulgarian""": """bułgarski""",
      """langs.catalan""": """kataloński""",
      """langs.cebuano""": """cebuański""",
      """langs.chichewa""": """cziczewa""",
      """langs.chinese""": """chiński""",
      """langs.corsican""": """korsykański""",
      """langs.croatian""": """chorwacki""",
      """langs.czech""": """czeski""",
      """langs.danish""": """duński""",
      """langs.dutch""": """niderlandzki""",
      """langs.english""": """angielski""",
      """langs.esperanto""": """esperanto""",
      """langs.estonian""": """estoński""",
      """langs.filipino""": """filipiński""",
      """langs.finnish""": """fiński""",
      """langs.french""": """francuski""",
      """langs.frisian""": """fryzyjski""",
      """langs.galician""": """galicyjski""",
      """langs.georgian""": """gruziński""",
      """langs.german""": """niemiecki""",
      """langs.greek""": """grecki""",
      """langs.gujarati""": """gudżarati""",
      """langs.haitian_creole""": """kreolski (Haiti)""",
      """langs.hausa""": """hausa""",
      """langs.hawaiian""": """hawajski""",
      """langs.hebrew""": """hebrajski""",
      """langs.hindi""": """hindi""",
      """langs.hmong""": """hmong""",
      """langs.hungarian""": """węgierski""",
      """langs.icelandic""": """islandzki""",
      """langs.igbo""": """igbo""",
      """langs.indonesian""": """indonezyjski""",
      """langs.irish""": """irlandzki""",
      """langs.italian""": """włoski""",
      """langs.japanese""": """japoński""",
      """langs.javanese""": """jawajski""",
      """langs.kannada""": """kannada""",
      """langs.kazakh""": """kazachski""",
      """langs.khmer""": """khmerski""",
      """langs.kinyarwanda""": """ruanda-rundi""",
      """langs.korean""": """koreański""",
      """langs.kurdish_kurmanji""": """kurdyjski""",
      """langs.kyrgyz""": """kirgiski""",
      """langs.lao""": """laotański""",
      """langs.latin""": """łaciński""",
      """langs.latvian""": """łotewski""",
      """langs.lithuanian""": """litewski""",
      """langs.luxembourgish""": """luksemburski""",
      """langs.macedonian""": """macedoński""",
      """langs.malagasy""": """malgaski""",
      """langs.malay""": """malajski""",
      """langs.malayalam""": """malajalam""",
      """langs.maltese""": """maltański""",
      """langs.maori""": """maori""",
      """langs.marathi""": """marathi""",
      """langs.mongolian""": """mongolski""",
      """langs.myanmar_burmese""": """birmański""",
      """langs.nepali""": """nepalski""",
      """langs.norwegian""": """norweski""",
      """langs.odia_oriya""": """orija""",
      """langs.pashto""": """paszto""",
      """langs.persian""": """perski""",
      """langs.polish""": """polski""",
      """langs.portuguese""": """portugalski""",
      """langs.punjabi""": """pendżabski""",
      """langs.romanian""": """rumuński""",
      """langs.russian""": """rosyjski""",
      """langs.samoan""": """samoański""",
      """langs.scots_gaelic""": """szkocki gaelicki""",
      """langs.serbian""": """serbski""",
      """langs.sesotho""": """sotho""",
      """langs.shona""": """shona""",
      """langs.sindhi""": """sindhi""",
      """langs.sinhala""": """syngaleski""",
      """langs.slovak""": """słowacki""",
      """langs.slovenian""": """słoweński""",
      """langs.somali""": """somalijski""",
      """langs.spanish""": """hiszpański""",
      """langs.sundanese""": """sundajski""",
      """langs.swahili""": """suahili""",
      """langs.swedish""": """szwedzki""",
      """langs.tajik""": """tadżycki""",
      """langs.tamil""": """tamilski""",
      """langs.tatar""": """tatarski""",
      """langs.telugu""": """telugu""",
      """langs.thai""": """tajski""",
      """langs.traditional_chinese""": """Traditional Chinese""",
      """langs.turkish""": """turecki""",
      """langs.turkmen""": """turkmeński""",
      """langs.ukrainian""": """ukraiński""",
      """langs.urdu""": """urdu""",
      """langs.uyghur""": """ujgurski""",
      """langs.uzbek""": """uzbecki""",
      """langs.vietnamese""": """wietnamski""",
      """langs.welsh""": """walijski""",
      """langs.xhosa""": """xhosa""",
      """langs.yiddish""": """jidysz""",
      """langs.yoruba""": """joruba""",
      """langs.zulu""": """zulu""",
      """main.about""": """O aplikacji""",
      """main.appearance""": """Wygląd""",
      """main.audio_limit""":
          """Nie można uzyskać dźwięku dla ponad 200 znaków""",
      """main.autodetect_not_supported""":
          """Autowykrywanie nie jest obsługiwane""",
      """main.cancel""": """Anuluj""",
      """main.contribute""": """Wnieś swój wkład""",
      """main.copied_to_clipboard""": """Skopiowano do schowka""",
      """main.dark""": """Ciemny""",
      """main.definitions""": """Definicje""",
      """main.donate""": """Wesprzyj""",
      """main.enter_text_here""": """Wpisz tutaj tekst""",
      """main.error""": """Wystąpił błąd""",
      """main.follow_system""": """Zgodny z systemowym""",
      """main.help""": """Pomoc""",
      """main.input_limit""": """Tekst źródłowy ma ponad 5000 znaków""",
      """main.install""": """Zainstaluj""",
      """main.license""": """Licencja""",
      """main.light""": """Jasny""",
      """main.no_internet""": """Brak połączenia z Internetem""",
      """main.ok""": """OK""",
      """main.report_bug""": """Zgłoś błąd""",
      """main.settings""": """Ustawienia""",
      """main.something_went_wrong""": """Coś poszło nie tak""",
      """main.text_recognition""": """Rozpoznawanie tekstu""",
      """main.text_to_speech""": """Zamiana tekstu na mowę""",
      """main.theme""": """Motyw""",
      """main.translate""": """Przetłumacz""",
      """main.translation""": """Tłumaczenie""",
      """main.translations""": """Tłumaczenia""",
      """main.version""": """Wersja""",
      """main.website""": """Strona internetowa""",
    };
