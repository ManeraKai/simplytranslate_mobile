// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'it';
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

class MessagesIt extends Messages {
  const MessagesIt();
  String get locale => "it";
  String get languageCode => "it";
  LangsMessagesIt get langs => LangsMessagesIt(this);
  MainMessagesIt get main => MainMessagesIt(this);
}

class LangsMessagesIt extends LangsMessages {
  final MessagesIt _parent;
  const LangsMessagesIt(this._parent) : super(_parent);
  String get afrikaans => """afrikaans""";
  String get albanian => """albanese""";
  String get amharic => """amarico""";
  String get arabic => """arabo""";
  String get armenian => """armeno""";
  String get autodetect => """Automatico""";
  String get azerbaijani => """azerbaigiano""";
  String get basque => """basco""";
  String get belarusian => """bielorusso""";
  String get bengali => """bengalese""";
  String get bosnian => """bosniaco""";
  String get bulgarian => """bulgaro""";
  String get catalan => """catalano""";
  String get cebuano => """cebuano""";
  String get chichewa => """chichewa""";
  String get chinese => """cinese""";
  String get corsican => """corso""";
  String get croatian => """croato""";
  String get czech => """ceco""";
  String get danish => """danese""";
  String get dutch => """olandese""";
  String get english => """inglese""";
  String get esperanto => """esperanto""";
  String get estonian => """estone""";
  String get filipino => """filippino""";
  String get finnish => """finlandese""";
  String get french => """francese""";
  String get frisian => """frisone""";
  String get galician => """galiziano""";
  String get georgian => """georgiano""";
  String get german => """tedesco""";
  String get greek => """greco""";
  String get gujarati => """gujarati""";
  String get haitian_creole => """creolo haitiano""";
  String get hausa => """hausa""";
  String get hawaiian => """hawaiano""";
  String get hebrew => """ebraico""";
  String get hindi => """hindi""";
  String get hmong => """hmong""";
  String get hungarian => """ungherese""";
  String get icelandic => """islandese""";
  String get igbo => """igbo""";
  String get indonesian => """indonesiano""";
  String get irish => """irlandese""";
  String get italian => """italiano""";
  String get japanese => """giapponese""";
  String get javanese => """giavanese""";
  String get kannada => """kannada""";
  String get kazakh => """kazako""";
  String get khmer => """khmer""";
  String get kinyarwanda => """kinyarwanda""";
  String get korean => """coreano""";
  String get kurdish_kurmanji => """curdo (kurmanji)""";
  String get kyrgyz => """kirghiso""";
  String get lao => """lao""";
  String get latin => """latino""";
  String get latvian => """lettone""";
  String get lithuanian => """lituano""";
  String get luxembourgish => """lussemburghese""";
  String get macedonian => """macedone""";
  String get malagasy => """malgascio""";
  String get malay => """malese""";
  String get malayalam => """malayalam""";
  String get maltese => """maltese""";
  String get maori => """maori""";
  String get marathi => """marathi""";
  String get mongolian => """mongolo""";
  String get myanmar_burmese => """birmano""";
  String get nepali => """nepalese""";
  String get norwegian => """norvegese""";
  String get odia_oriya => """odia (oriya)""";
  String get pashto => """pashtu""";
  String get persian => """persiano""";
  String get polish => """polacco""";
  String get portuguese => """portoghese""";
  String get punjabi => """punjabi""";
  String get romanian => """rumeno""";
  String get russian => """russo""";
  String get samoan => """samoano""";
  String get scots_gaelic => """gaelico scozzese""";
  String get serbian => """serbo""";
  String get sesotho => """sesotho""";
  String get shona => """shona""";
  String get sindhi => """sindhi""";
  String get sinhala => """singalese""";
  String get slovak => """slovacco""";
  String get slovenian => """sloveno""";
  String get somali => """somalo""";
  String get spanish => """spagnolo""";
  String get sundanese => """sundanese""";
  String get swahili => """swahili""";
  String get swedish => """svedese""";
  String get tajik => """tagico""";
  String get tamil => """tamil""";
  String get tatar => """tataro""";
  String get telugu => """telugu""";
  String get thai => """thailandese""";
  String get traditional_chinese => """Traditional Chinese""";
  String get turkish => """turco""";
  String get turkmen => """turkmeno""";
  String get ukrainian => """ucraino""";
  String get urdu => """urdu""";
  String get uyghur => """uiguro""";
  String get uzbek => """uzbeco""";
  String get vietnamese => """vietnamita""";
  String get welsh => """gallese""";
  String get xhosa => """xhosa""";
  String get yiddish => """yiddish""";
  String get yoruba => """yoruba""";
  String get zulu => """zulu""";
}

class MainMessagesIt extends MainMessages {
  final MessagesIt _parent;
  const MainMessagesIt(this._parent) : super(_parent);
  String get about => """Informazioni""";
  String get appearance => """Aspetto""";
  String get audio_limit =>
      """Impossibile ottenere l'audio per più di 200 caratteri""";
  String get autodetect_not_supported =>
      """Rilevamento automatico non supportato""";
  String get cancel => """Annulla""";
  String get contribute => """Contribuisci""";
  String get copied_to_clipboard => """Copiato negli appunti""";
  String get dark => """Scuro""";
  String get definitions => """Definizioni""";
  String get donate => """Dona""";
  String get enter_text_here => """Inserisci il testo qui""";
  String get error => """Si è verificato un errore""";
  String get follow_system => """Segui il sistema""";
  String get help => """Aiuto""";
  String get input_limit =>
      """Il testo di traduzione inserito è superiore a 5000""";
  String get install => """Installa""";
  String get license => """Licenza""";
  String get light => """Chiaro""";
  String get no_internet => """Nessuna connessione internet""";
  String get ok => """OK""";
  String get report_bug => """Segnala un errore""";
  String get settings => """Impostazioni""";
  String get something_went_wrong => """Qualcosa è andato storto""";
  String get text_recognition => """Riconoscimento del testo""";
  String get text_to_speech => """Sintesi vocale""";
  String get theme => """Tema""";
  String get translate => """Traduci""";
  String get translation => """Traduzione""";
  String get translations => """Traduzioni""";
  String get version => """Versione""";
  String get website => """Sito web""";
}

Map<String, String> get messagesItMap => {
      """langs.afrikaans""": """afrikaans""",
      """langs.albanian""": """albanese""",
      """langs.amharic""": """amarico""",
      """langs.arabic""": """arabo""",
      """langs.armenian""": """armeno""",
      """langs.autodetect""": """Automatico""",
      """langs.azerbaijani""": """azerbaigiano""",
      """langs.basque""": """basco""",
      """langs.belarusian""": """bielorusso""",
      """langs.bengali""": """bengalese""",
      """langs.bosnian""": """bosniaco""",
      """langs.bulgarian""": """bulgaro""",
      """langs.catalan""": """catalano""",
      """langs.cebuano""": """cebuano""",
      """langs.chichewa""": """chichewa""",
      """langs.chinese""": """cinese""",
      """langs.corsican""": """corso""",
      """langs.croatian""": """croato""",
      """langs.czech""": """ceco""",
      """langs.danish""": """danese""",
      """langs.dutch""": """olandese""",
      """langs.english""": """inglese""",
      """langs.esperanto""": """esperanto""",
      """langs.estonian""": """estone""",
      """langs.filipino""": """filippino""",
      """langs.finnish""": """finlandese""",
      """langs.french""": """francese""",
      """langs.frisian""": """frisone""",
      """langs.galician""": """galiziano""",
      """langs.georgian""": """georgiano""",
      """langs.german""": """tedesco""",
      """langs.greek""": """greco""",
      """langs.gujarati""": """gujarati""",
      """langs.haitian_creole""": """creolo haitiano""",
      """langs.hausa""": """hausa""",
      """langs.hawaiian""": """hawaiano""",
      """langs.hebrew""": """ebraico""",
      """langs.hindi""": """hindi""",
      """langs.hmong""": """hmong""",
      """langs.hungarian""": """ungherese""",
      """langs.icelandic""": """islandese""",
      """langs.igbo""": """igbo""",
      """langs.indonesian""": """indonesiano""",
      """langs.irish""": """irlandese""",
      """langs.italian""": """italiano""",
      """langs.japanese""": """giapponese""",
      """langs.javanese""": """giavanese""",
      """langs.kannada""": """kannada""",
      """langs.kazakh""": """kazako""",
      """langs.khmer""": """khmer""",
      """langs.kinyarwanda""": """kinyarwanda""",
      """langs.korean""": """coreano""",
      """langs.kurdish_kurmanji""": """curdo (kurmanji)""",
      """langs.kyrgyz""": """kirghiso""",
      """langs.lao""": """lao""",
      """langs.latin""": """latino""",
      """langs.latvian""": """lettone""",
      """langs.lithuanian""": """lituano""",
      """langs.luxembourgish""": """lussemburghese""",
      """langs.macedonian""": """macedone""",
      """langs.malagasy""": """malgascio""",
      """langs.malay""": """malese""",
      """langs.malayalam""": """malayalam""",
      """langs.maltese""": """maltese""",
      """langs.maori""": """maori""",
      """langs.marathi""": """marathi""",
      """langs.mongolian""": """mongolo""",
      """langs.myanmar_burmese""": """birmano""",
      """langs.nepali""": """nepalese""",
      """langs.norwegian""": """norvegese""",
      """langs.odia_oriya""": """odia (oriya)""",
      """langs.pashto""": """pashtu""",
      """langs.persian""": """persiano""",
      """langs.polish""": """polacco""",
      """langs.portuguese""": """portoghese""",
      """langs.punjabi""": """punjabi""",
      """langs.romanian""": """rumeno""",
      """langs.russian""": """russo""",
      """langs.samoan""": """samoano""",
      """langs.scots_gaelic""": """gaelico scozzese""",
      """langs.serbian""": """serbo""",
      """langs.sesotho""": """sesotho""",
      """langs.shona""": """shona""",
      """langs.sindhi""": """sindhi""",
      """langs.sinhala""": """singalese""",
      """langs.slovak""": """slovacco""",
      """langs.slovenian""": """sloveno""",
      """langs.somali""": """somalo""",
      """langs.spanish""": """spagnolo""",
      """langs.sundanese""": """sundanese""",
      """langs.swahili""": """swahili""",
      """langs.swedish""": """svedese""",
      """langs.tajik""": """tagico""",
      """langs.tamil""": """tamil""",
      """langs.tatar""": """tataro""",
      """langs.telugu""": """telugu""",
      """langs.thai""": """thailandese""",
      """langs.traditional_chinese""": """Traditional Chinese""",
      """langs.turkish""": """turco""",
      """langs.turkmen""": """turkmeno""",
      """langs.ukrainian""": """ucraino""",
      """langs.urdu""": """urdu""",
      """langs.uyghur""": """uiguro""",
      """langs.uzbek""": """uzbeco""",
      """langs.vietnamese""": """vietnamita""",
      """langs.welsh""": """gallese""",
      """langs.xhosa""": """xhosa""",
      """langs.yiddish""": """yiddish""",
      """langs.yoruba""": """yoruba""",
      """langs.zulu""": """zulu""",
      """main.about""": """Informazioni""",
      """main.appearance""": """Aspetto""",
      """main.audio_limit""":
          """Impossibile ottenere l'audio per più di 200 caratteri""",
      """main.autodetect_not_supported""":
          """Rilevamento automatico non supportato""",
      """main.cancel""": """Annulla""",
      """main.contribute""": """Contribuisci""",
      """main.copied_to_clipboard""": """Copiato negli appunti""",
      """main.dark""": """Scuro""",
      """main.definitions""": """Definizioni""",
      """main.donate""": """Dona""",
      """main.enter_text_here""": """Inserisci il testo qui""",
      """main.error""": """Si è verificato un errore""",
      """main.follow_system""": """Segui il sistema""",
      """main.help""": """Aiuto""",
      """main.input_limit""":
          """Il testo di traduzione inserito è superiore a 5000""",
      """main.install""": """Installa""",
      """main.license""": """Licenza""",
      """main.light""": """Chiaro""",
      """main.no_internet""": """Nessuna connessione internet""",
      """main.ok""": """OK""",
      """main.report_bug""": """Segnala un errore""",
      """main.settings""": """Impostazioni""",
      """main.something_went_wrong""": """Qualcosa è andato storto""",
      """main.text_recognition""": """Riconoscimento del testo""",
      """main.text_to_speech""": """Sintesi vocale""",
      """main.theme""": """Tema""",
      """main.translate""": """Traduci""",
      """main.translation""": """Traduzione""",
      """main.translations""": """Traduzioni""",
      """main.version""": """Versione""",
      """main.website""": """Sito web""",
    };
