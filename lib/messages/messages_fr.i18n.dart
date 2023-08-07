// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'fr';
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

class MessagesFr extends Messages {
  const MessagesFr();
  String get locale => "fr";
  String get languageCode => "fr";
  LangsMessagesFr get langs => LangsMessagesFr(this);
  MainMessagesFr get main => MainMessagesFr(this);
}

class LangsMessagesFr extends LangsMessages {
  final MessagesFr _parent;
  const LangsMessagesFr(this._parent) : super(_parent);
  String get afrikaans => """afrikaans""";
  String get albanian => """albanais""";
  String get amharic => """amharique""";
  String get arabic => """arabe""";
  String get armenian => """arménien""";
  String get autodetect => """Autodétection""";
  String get azerbaijani => """azerbaïdjanais""";
  String get basque => """basque""";
  String get belarusian => """biélorusse""";
  String get bengali => """bengali""";
  String get bosnian => """bosnien""";
  String get bulgarian => """bulgare""";
  String get catalan => """catalan""";
  String get cebuano => """cebuano""";
  String get chichewa => """chichewa""";
  String get chinese => """chinois""";
  String get corsican => """corse""";
  String get croatian => """croate""";
  String get czech => """tchèque""";
  String get danish => """danois""";
  String get dutch => """néerlandais""";
  String get english => """anglais""";
  String get esperanto => """espéranto""";
  String get estonian => """estonien""";
  String get filipino => """philippin""";
  String get finnish => """finnois""";
  String get french => """français""";
  String get frisian => """frison""";
  String get galician => """galicien""";
  String get georgian => """géorgien""";
  String get german => """allemand""";
  String get greek => """grec""";
  String get gujarati => """goudjarati""";
  String get haitian_creole => """créole haïtien""";
  String get hausa => """haoussa""";
  String get hawaiian => """hawaïen""";
  String get hebrew => """hébreu""";
  String get hindi => """hindi""";
  String get hmong => """hmong""";
  String get hungarian => """hongrois""";
  String get icelandic => """islandais""";
  String get igbo => """igbo""";
  String get indonesian => """indonésien""";
  String get irish => """irlandais""";
  String get italian => """italien""";
  String get japanese => """japonais""";
  String get javanese => """javanais""";
  String get kannada => """kannada""";
  String get kazakh => """kazakh""";
  String get khmer => """khmer""";
  String get kinyarwanda => """kinyarwanda""";
  String get korean => """coréen""";
  String get kurdish_kurmanji => """kurde (kurmanji)""";
  String get kyrgyz => """kirghize""";
  String get lao => """laotien""";
  String get latin => """latin""";
  String get latvian => """letton""";
  String get lithuanian => """lituanien""";
  String get luxembourgish => """luxembourgeois""";
  String get macedonian => """macédonien""";
  String get malagasy => """malgache""";
  String get malay => """malais""";
  String get malayalam => """malayalam""";
  String get maltese => """maltais""";
  String get maori => """maori""";
  String get marathi => """marathi""";
  String get mongolian => """mongol""";
  String get myanmar_burmese => """birman""";
  String get nepali => """népalais""";
  String get norwegian => """norvégien""";
  String get odia_oriya => """odia (oriya)""";
  String get pashto => """pachto""";
  String get persian => """persan""";
  String get polish => """polonais""";
  String get portuguese => """portugais""";
  String get punjabi => """pendjabi""";
  String get romanian => """roumain""";
  String get russian => """russe""";
  String get samoan => """samoan""";
  String get scots_gaelic => """gaélique écossais""";
  String get serbian => """serbe""";
  String get sesotho => """sesotho""";
  String get shona => """shona""";
  String get sindhi => """sindhi""";
  String get sinhala => """singhalais""";
  String get slovak => """slovaque""";
  String get slovenian => """slovène""";
  String get somali => """somali""";
  String get spanish => """espagnol""";
  String get sundanese => """soundanais""";
  String get swahili => """swahili""";
  String get swedish => """suédois""";
  String get tajik => """tadjik""";
  String get tamil => """tamoul""";
  String get tatar => """tatar""";
  String get telugu => """télougou""";
  String get thai => """thaï""";
  String get traditional_chinese => """Traditional Chinese""";
  String get turkish => """turc""";
  String get turkmen => """turkmène""";
  String get ukrainian => """ukrainien""";
  String get urdu => """ourdou""";
  String get uyghur => """ouïghour""";
  String get uzbek => """ouzbek""";
  String get vietnamese => """vietnamien""";
  String get welsh => """gallois""";
  String get xhosa => """xhosa""";
  String get yiddish => """yiddish""";
  String get yoruba => """yorouba""";
  String get zulu => """zoulou""";
}

class MainMessagesFr extends MainMessages {
  final MessagesFr _parent;
  const MainMessagesFr(this._parent) : super(_parent);
  String get about => """À propos""";
  String get appearance => """Apparence""";
  String get audio_limit =>
      """Impossible d'obtenir le son pour plus de 200 caractères""";
  String get autodetect_not_supported =>
      """Autodétection non prise en charge""";
  String get cancel => """Annuler""";
  String get contribute => """Contribuer""";
  String get copied_to_clipboard => """Copié dans le presse-papiers""";
  String get dark => """Sombre""";
  String get definitions => """Définitions""";
  String get donate => """Faire un don""";
  String get enter_text_here => """Entrez le texte ici""";
  String get error => """Il y a eu une erreur""";
  String get follow_system => """Selon le système""";
  String get help => """Aide""";
  String get input_limit =>
      """Le texte saisi de la traduction est supérieur à 5000""";
  String get install => """Installer""";
  String get license => """Licence""";
  String get light => """Clair""";
  String get no_internet => """Pas de connexion internet""";
  String get ok => """OK""";
  String get report_bug => """Signaler une erreur""";
  String get settings => """Paramètres""";
  String get something_went_wrong => """Quelque chose a mal tourné""";
  String get text_recognition => """Reconnaissance du texte""";
  String get text_to_speech => """Synthèse vocale""";
  String get theme => """Thème""";
  String get translate => """Traduire""";
  String get translation => """Traduction""";
  String get translations => """Traductions""";
  String get version => """Version""";
  String get website => """Site web""";
}

Map<String, String> get messagesFrMap => {
      """langs.afrikaans""": """afrikaans""",
      """langs.albanian""": """albanais""",
      """langs.amharic""": """amharique""",
      """langs.arabic""": """arabe""",
      """langs.armenian""": """arménien""",
      """langs.autodetect""": """Autodétection""",
      """langs.azerbaijani""": """azerbaïdjanais""",
      """langs.basque""": """basque""",
      """langs.belarusian""": """biélorusse""",
      """langs.bengali""": """bengali""",
      """langs.bosnian""": """bosnien""",
      """langs.bulgarian""": """bulgare""",
      """langs.catalan""": """catalan""",
      """langs.cebuano""": """cebuano""",
      """langs.chichewa""": """chichewa""",
      """langs.chinese""": """chinois""",
      """langs.corsican""": """corse""",
      """langs.croatian""": """croate""",
      """langs.czech""": """tchèque""",
      """langs.danish""": """danois""",
      """langs.dutch""": """néerlandais""",
      """langs.english""": """anglais""",
      """langs.esperanto""": """espéranto""",
      """langs.estonian""": """estonien""",
      """langs.filipino""": """philippin""",
      """langs.finnish""": """finnois""",
      """langs.french""": """français""",
      """langs.frisian""": """frison""",
      """langs.galician""": """galicien""",
      """langs.georgian""": """géorgien""",
      """langs.german""": """allemand""",
      """langs.greek""": """grec""",
      """langs.gujarati""": """goudjarati""",
      """langs.haitian_creole""": """créole haïtien""",
      """langs.hausa""": """haoussa""",
      """langs.hawaiian""": """hawaïen""",
      """langs.hebrew""": """hébreu""",
      """langs.hindi""": """hindi""",
      """langs.hmong""": """hmong""",
      """langs.hungarian""": """hongrois""",
      """langs.icelandic""": """islandais""",
      """langs.igbo""": """igbo""",
      """langs.indonesian""": """indonésien""",
      """langs.irish""": """irlandais""",
      """langs.italian""": """italien""",
      """langs.japanese""": """japonais""",
      """langs.javanese""": """javanais""",
      """langs.kannada""": """kannada""",
      """langs.kazakh""": """kazakh""",
      """langs.khmer""": """khmer""",
      """langs.kinyarwanda""": """kinyarwanda""",
      """langs.korean""": """coréen""",
      """langs.kurdish_kurmanji""": """kurde (kurmanji)""",
      """langs.kyrgyz""": """kirghize""",
      """langs.lao""": """laotien""",
      """langs.latin""": """latin""",
      """langs.latvian""": """letton""",
      """langs.lithuanian""": """lituanien""",
      """langs.luxembourgish""": """luxembourgeois""",
      """langs.macedonian""": """macédonien""",
      """langs.malagasy""": """malgache""",
      """langs.malay""": """malais""",
      """langs.malayalam""": """malayalam""",
      """langs.maltese""": """maltais""",
      """langs.maori""": """maori""",
      """langs.marathi""": """marathi""",
      """langs.mongolian""": """mongol""",
      """langs.myanmar_burmese""": """birman""",
      """langs.nepali""": """népalais""",
      """langs.norwegian""": """norvégien""",
      """langs.odia_oriya""": """odia (oriya)""",
      """langs.pashto""": """pachto""",
      """langs.persian""": """persan""",
      """langs.polish""": """polonais""",
      """langs.portuguese""": """portugais""",
      """langs.punjabi""": """pendjabi""",
      """langs.romanian""": """roumain""",
      """langs.russian""": """russe""",
      """langs.samoan""": """samoan""",
      """langs.scots_gaelic""": """gaélique écossais""",
      """langs.serbian""": """serbe""",
      """langs.sesotho""": """sesotho""",
      """langs.shona""": """shona""",
      """langs.sindhi""": """sindhi""",
      """langs.sinhala""": """singhalais""",
      """langs.slovak""": """slovaque""",
      """langs.slovenian""": """slovène""",
      """langs.somali""": """somali""",
      """langs.spanish""": """espagnol""",
      """langs.sundanese""": """soundanais""",
      """langs.swahili""": """swahili""",
      """langs.swedish""": """suédois""",
      """langs.tajik""": """tadjik""",
      """langs.tamil""": """tamoul""",
      """langs.tatar""": """tatar""",
      """langs.telugu""": """télougou""",
      """langs.thai""": """thaï""",
      """langs.traditional_chinese""": """Traditional Chinese""",
      """langs.turkish""": """turc""",
      """langs.turkmen""": """turkmène""",
      """langs.ukrainian""": """ukrainien""",
      """langs.urdu""": """ourdou""",
      """langs.uyghur""": """ouïghour""",
      """langs.uzbek""": """ouzbek""",
      """langs.vietnamese""": """vietnamien""",
      """langs.welsh""": """gallois""",
      """langs.xhosa""": """xhosa""",
      """langs.yiddish""": """yiddish""",
      """langs.yoruba""": """yorouba""",
      """langs.zulu""": """zoulou""",
      """main.about""": """À propos""",
      """main.appearance""": """Apparence""",
      """main.audio_limit""":
          """Impossible d'obtenir le son pour plus de 200 caractères""",
      """main.autodetect_not_supported""":
          """Autodétection non prise en charge""",
      """main.cancel""": """Annuler""",
      """main.contribute""": """Contribuer""",
      """main.copied_to_clipboard""": """Copié dans le presse-papiers""",
      """main.dark""": """Sombre""",
      """main.definitions""": """Définitions""",
      """main.donate""": """Faire un don""",
      """main.enter_text_here""": """Entrez le texte ici""",
      """main.error""": """Il y a eu une erreur""",
      """main.follow_system""": """Selon le système""",
      """main.help""": """Aide""",
      """main.input_limit""":
          """Le texte saisi de la traduction est supérieur à 5000""",
      """main.install""": """Installer""",
      """main.license""": """Licence""",
      """main.light""": """Clair""",
      """main.no_internet""": """Pas de connexion internet""",
      """main.ok""": """OK""",
      """main.report_bug""": """Signaler une erreur""",
      """main.settings""": """Paramètres""",
      """main.something_went_wrong""": """Quelque chose a mal tourné""",
      """main.text_recognition""": """Reconnaissance du texte""",
      """main.text_to_speech""": """Synthèse vocale""",
      """main.theme""": """Thème""",
      """main.translate""": """Traduire""",
      """main.translation""": """Traduction""",
      """main.translations""": """Traductions""",
      """main.version""": """Version""",
      """main.website""": """Site web""",
    };
