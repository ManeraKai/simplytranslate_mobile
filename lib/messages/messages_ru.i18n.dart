// GENERATED FILE, do not edit!
// ignore_for_file: annotate_overrides, non_constant_identifier_names, prefer_single_quotes, unused_element, unused_field
import 'package:i18n/i18n.dart' as i18n;
import 'messages.i18n.dart';

String get _languageCode => 'ru';
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

class MessagesRu extends Messages {
  const MessagesRu();
  String get locale => "ru";
  String get languageCode => "ru";
  LangsMessagesRu get langs => LangsMessagesRu(this);
  MainMessagesRu get main => MainMessagesRu(this);
}

class LangsMessagesRu extends LangsMessages {
  final MessagesRu _parent;
  const LangsMessagesRu(this._parent) : super(_parent);
  String get afrikaans => """Африкаанс""";
  String get albanian => """Албанский""";
  String get amharic => """Амхарский""";
  String get arabic => """Арабский""";
  String get armenian => """Армянский""";
  String get autodetect => """Определить язык""";
  String get azerbaijani => """Азербайджанский""";
  String get basque => """Баскский""";
  String get belarusian => """Белорусский""";
  String get bengali => """Бенгальский""";
  String get bosnian => """Боснийский""";
  String get bulgarian => """Болгарский""";
  String get catalan => """Каталанский""";
  String get cebuano => """Себуанский""";
  String get chichewa => """Чичева""";
  String get chinese => """Китайский""";
  String get corsican => """Корсиканский""";
  String get croatian => """Хорватский""";
  String get czech => """Чешский""";
  String get danish => """Датский""";
  String get dutch => """Нидерландский""";
  String get english => """Английский""";
  String get esperanto => """Эсперанто""";
  String get estonian => """Эстонский""";
  String get filipino => """Филиппинский""";
  String get finnish => """Финский""";
  String get french => """Французский""";
  String get frisian => """Фризский""";
  String get galician => """Галисийский""";
  String get georgian => """Грузинский""";
  String get german => """Немецкий""";
  String get greek => """Греческий""";
  String get gujarati => """Гуджарати""";
  String get haitian_creole => """Креольский (Гаити)""";
  String get hausa => """Хауса""";
  String get hawaiian => """Гавайский""";
  String get hebrew => """Иврит""";
  String get hindi => """Хинди""";
  String get hmong => """Хмонг""";
  String get hungarian => """Венгерский""";
  String get icelandic => """Исландский""";
  String get igbo => """Игбо""";
  String get indonesian => """Индонезийский""";
  String get irish => """Ирландский""";
  String get italian => """Итальянский""";
  String get japanese => """Японский""";
  String get javanese => """Яванский""";
  String get kannada => """Каннада""";
  String get kazakh => """Казахский""";
  String get khmer => """Кхмерский""";
  String get kinyarwanda => """Киньяруанда""";
  String get korean => """Корейский""";
  String get kurdish_kurmanji => """Курдский (Курманджи)""";
  String get kyrgyz => """Киргизский""";
  String get lao => """Лаосский""";
  String get latin => """Латинский""";
  String get latvian => """Латвийский""";
  String get lithuanian => """Литовский""";
  String get luxembourgish => """Люксембургский""";
  String get macedonian => """Македонский""";
  String get malagasy => """Малагасийский""";
  String get malay => """Малайский""";
  String get malayalam => """Малаялам""";
  String get maltese => """Мальтийский""";
  String get maori => """Маори""";
  String get marathi => """Маратхи""";
  String get mongolian => """Монгольский""";
  String get myanmar_burmese => """Бирманский (Мьянма)""";
  String get nepali => """Непальский""";
  String get norwegian => """Норвежский""";
  String get odia_oriya => """Одиа (Ория)""";
  String get pashto => """Пушту""";
  String get persian => """Персидский""";
  String get polish => """Польский""";
  String get portuguese => """Португальский""";
  String get punjabi => """Панджаби""";
  String get romanian => """Румынский""";
  String get russian => """Русский""";
  String get samoan => """Самоанский""";
  String get scots_gaelic => """Шотландский (Гэльский)""";
  String get serbian => """Сербский""";
  String get sesotho => """Сесото""";
  String get shona => """Шона""";
  String get sindhi => """Синдхи""";
  String get sinhala => """Синхала""";
  String get slovak => """Словацкий""";
  String get slovenian => """Словенский""";
  String get somali => """Сомалийский""";
  String get spanish => """Испанский""";
  String get sundanese => """Суданский""";
  String get swahili => """Суахили""";
  String get swedish => """Шведский""";
  String get tajik => """Таджикский""";
  String get tamil => """Тамильский""";
  String get tatar => """Татарский""";
  String get telugu => """Телугу""";
  String get thai => """Тайский""";
  String get traditional_chinese => """Traditional Chinese""";
  String get turkish => """Турецкий""";
  String get turkmen => """Туркменский""";
  String get ukrainian => """Украинский""";
  String get urdu => """Урду""";
  String get uyghur => """Уйгурский""";
  String get uzbek => """Узбекский""";
  String get vietnamese => """Вьетнамский""";
  String get welsh => """Валлийский""";
  String get xhosa => """Кхоса""";
  String get yiddish => """Идиш""";
  String get yoruba => """Йоруба""";
  String get zulu => """Зулу""";
}

class MainMessagesRu extends MainMessages {
  final MessagesRu _parent;
  const MainMessagesRu(this._parent) : super(_parent);
  String get about => """О приложении""";
  String get appearance => """Внешний вид""";
  String get audio_limit =>
      """Невозможно воспроизвести аудио более чем для 200 символов""";
  String get autodetect_not_supported =>
      """Автоматическое определение не поддерживается""";
  String get cancel => """Отмена""";
  String get contribute => """Сделать вклад""";
  String get copied_to_clipboard => """Скопировано в буфер обмена""";
  String get dark => """Тёмная""";
  String get definitions => """Определения""";
  String get donate => """Пожертвовать""";
  String get enter_text_here => """Введите текст в это поле""";
  String get error => """Произошла ошибка""";
  String get follow_system => """Как в системе""";
  String get help => """Помощь""";
  String get input_limit => """Введённый текст больше 5000 символов""";
  String get install => """Установить""";
  String get license => """Лицензия""";
  String get light => """Светлая""";
  String get no_internet => """Нет подключения к интернету""";
  String get ok => """OK""";
  String get report_bug => """Сообщить о проблеме""";
  String get settings => """Настройки""";
  String get something_went_wrong => """Что-то пошло не так""";
  String get text_recognition => """Распознавание текста""";
  String get text_to_speech => """Текст-в-Речь (TTS)""";
  String get theme => """Тема""";
  String get translate => """Перевести""";
  String get translation => """Перевод""";
  String get translations => """Переводы""";
  String get version => """Версия""";
  String get website => """Веб-сайт""";
}

Map<String, String> get messagesRuMap => {
      """langs.afrikaans""": """Африкаанс""",
      """langs.albanian""": """Албанский""",
      """langs.amharic""": """Амхарский""",
      """langs.arabic""": """Арабский""",
      """langs.armenian""": """Армянский""",
      """langs.autodetect""": """Определить язык""",
      """langs.azerbaijani""": """Азербайджанский""",
      """langs.basque""": """Баскский""",
      """langs.belarusian""": """Белорусский""",
      """langs.bengali""": """Бенгальский""",
      """langs.bosnian""": """Боснийский""",
      """langs.bulgarian""": """Болгарский""",
      """langs.catalan""": """Каталанский""",
      """langs.cebuano""": """Себуанский""",
      """langs.chichewa""": """Чичева""",
      """langs.chinese""": """Китайский""",
      """langs.corsican""": """Корсиканский""",
      """langs.croatian""": """Хорватский""",
      """langs.czech""": """Чешский""",
      """langs.danish""": """Датский""",
      """langs.dutch""": """Нидерландский""",
      """langs.english""": """Английский""",
      """langs.esperanto""": """Эсперанто""",
      """langs.estonian""": """Эстонский""",
      """langs.filipino""": """Филиппинский""",
      """langs.finnish""": """Финский""",
      """langs.french""": """Французский""",
      """langs.frisian""": """Фризский""",
      """langs.galician""": """Галисийский""",
      """langs.georgian""": """Грузинский""",
      """langs.german""": """Немецкий""",
      """langs.greek""": """Греческий""",
      """langs.gujarati""": """Гуджарати""",
      """langs.haitian_creole""": """Креольский (Гаити)""",
      """langs.hausa""": """Хауса""",
      """langs.hawaiian""": """Гавайский""",
      """langs.hebrew""": """Иврит""",
      """langs.hindi""": """Хинди""",
      """langs.hmong""": """Хмонг""",
      """langs.hungarian""": """Венгерский""",
      """langs.icelandic""": """Исландский""",
      """langs.igbo""": """Игбо""",
      """langs.indonesian""": """Индонезийский""",
      """langs.irish""": """Ирландский""",
      """langs.italian""": """Итальянский""",
      """langs.japanese""": """Японский""",
      """langs.javanese""": """Яванский""",
      """langs.kannada""": """Каннада""",
      """langs.kazakh""": """Казахский""",
      """langs.khmer""": """Кхмерский""",
      """langs.kinyarwanda""": """Киньяруанда""",
      """langs.korean""": """Корейский""",
      """langs.kurdish_kurmanji""": """Курдский (Курманджи)""",
      """langs.kyrgyz""": """Киргизский""",
      """langs.lao""": """Лаосский""",
      """langs.latin""": """Латинский""",
      """langs.latvian""": """Латвийский""",
      """langs.lithuanian""": """Литовский""",
      """langs.luxembourgish""": """Люксембургский""",
      """langs.macedonian""": """Македонский""",
      """langs.malagasy""": """Малагасийский""",
      """langs.malay""": """Малайский""",
      """langs.malayalam""": """Малаялам""",
      """langs.maltese""": """Мальтийский""",
      """langs.maori""": """Маори""",
      """langs.marathi""": """Маратхи""",
      """langs.mongolian""": """Монгольский""",
      """langs.myanmar_burmese""": """Бирманский (Мьянма)""",
      """langs.nepali""": """Непальский""",
      """langs.norwegian""": """Норвежский""",
      """langs.odia_oriya""": """Одиа (Ория)""",
      """langs.pashto""": """Пушту""",
      """langs.persian""": """Персидский""",
      """langs.polish""": """Польский""",
      """langs.portuguese""": """Португальский""",
      """langs.punjabi""": """Панджаби""",
      """langs.romanian""": """Румынский""",
      """langs.russian""": """Русский""",
      """langs.samoan""": """Самоанский""",
      """langs.scots_gaelic""": """Шотландский (Гэльский)""",
      """langs.serbian""": """Сербский""",
      """langs.sesotho""": """Сесото""",
      """langs.shona""": """Шона""",
      """langs.sindhi""": """Синдхи""",
      """langs.sinhala""": """Синхала""",
      """langs.slovak""": """Словацкий""",
      """langs.slovenian""": """Словенский""",
      """langs.somali""": """Сомалийский""",
      """langs.spanish""": """Испанский""",
      """langs.sundanese""": """Суданский""",
      """langs.swahili""": """Суахили""",
      """langs.swedish""": """Шведский""",
      """langs.tajik""": """Таджикский""",
      """langs.tamil""": """Тамильский""",
      """langs.tatar""": """Татарский""",
      """langs.telugu""": """Телугу""",
      """langs.thai""": """Тайский""",
      """langs.traditional_chinese""": """Traditional Chinese""",
      """langs.turkish""": """Турецкий""",
      """langs.turkmen""": """Туркменский""",
      """langs.ukrainian""": """Украинский""",
      """langs.urdu""": """Урду""",
      """langs.uyghur""": """Уйгурский""",
      """langs.uzbek""": """Узбекский""",
      """langs.vietnamese""": """Вьетнамский""",
      """langs.welsh""": """Валлийский""",
      """langs.xhosa""": """Кхоса""",
      """langs.yiddish""": """Идиш""",
      """langs.yoruba""": """Йоруба""",
      """langs.zulu""": """Зулу""",
      """main.about""": """О приложении""",
      """main.appearance""": """Внешний вид""",
      """main.audio_limit""":
          """Невозможно воспроизвести аудио более чем для 200 символов""",
      """main.autodetect_not_supported""":
          """Автоматическое определение не поддерживается""",
      """main.cancel""": """Отмена""",
      """main.contribute""": """Сделать вклад""",
      """main.copied_to_clipboard""": """Скопировано в буфер обмена""",
      """main.dark""": """Тёмная""",
      """main.definitions""": """Определения""",
      """main.donate""": """Пожертвовать""",
      """main.enter_text_here""": """Введите текст в это поле""",
      """main.error""": """Произошла ошибка""",
      """main.follow_system""": """Как в системе""",
      """main.help""": """Помощь""",
      """main.input_limit""": """Введённый текст больше 5000 символов""",
      """main.install""": """Установить""",
      """main.license""": """Лицензия""",
      """main.light""": """Светлая""",
      """main.no_internet""": """Нет подключения к интернету""",
      """main.ok""": """OK""",
      """main.report_bug""": """Сообщить о проблеме""",
      """main.settings""": """Настройки""",
      """main.something_went_wrong""": """Что-то пошло не так""",
      """main.text_recognition""": """Распознавание текста""",
      """main.text_to_speech""": """Текст-в-Речь (TTS)""",
      """main.theme""": """Тема""",
      """main.translate""": """Перевести""",
      """main.translation""": """Перевод""",
      """main.translations""": """Переводы""",
      """main.version""": """Версия""",
      """main.website""": """Веб-сайт""",
    };
