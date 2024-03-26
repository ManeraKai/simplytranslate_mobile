import 'package:flutter/material.dart';

import 'messages/messages.i18n.dart';
import 'messages/messages_ar.i18n.dart';
import 'messages/messages_cs.i18n.dart';
import 'messages/messages_de.i18n.dart';
import 'messages/messages_el.i18n.dart';
import 'messages/messages_en.i18n.dart';
import 'messages/messages_eo.i18n.dart';
import 'messages/messages_es.i18n.dart';
import 'messages/messages_fa.i18n.dart';
import 'messages/messages_fi.i18n.dart';
import 'messages/messages_fr.i18n.dart';
import 'messages/messages_hu.i18n.dart';
import 'messages/messages_is.i18n.dart';
import 'messages/messages_it.i18n.dart';
import 'messages/messages_ja.i18n.dart';
import 'messages/messages_ko.i18n.dart';
import 'messages/messages_ml.i18n.dart';
import 'messages/messages_nb_NO.i18n.dart';
import 'messages/messages_pl.i18n.dart';
import 'messages/messages_pt_BR.i18n.dart';
import 'messages/messages_ru.i18n.dart';
import 'messages/messages_tr.i18n.dart';
import 'messages/messages_uk.i18n.dart';
import 'messages/messages_zh_HK.i18n.dart';

var langs = [
  MessagesAr(),
  MessagesCs(),
  MessagesDe(),
  MessagesEl(),
  MessagesEn(),
  MessagesEo(),
  MessagesEs(),
  MessagesFa(),
  MessagesFi(),
  MessagesFr(),
  MessagesHu(),
  MessagesIs(),
  MessagesIt(),
  MessagesJa(),
  MessagesKo(),
  MessagesMl(),
  MessagesNbNO(),
  MessagesPl(),
  MessagesPtBR(),
  MessagesRu(),
  MessagesTr(),
  MessagesUk(),
  MessagesZhHK(),
];

late Locale appLocale;

Messages i18n() {
  var locale = appLocale;
  for (var lang in langs) {
    if (lang.locale == "${locale.languageCode}_${locale.countryCode}") return lang;
  }
  for (var lang in langs) {
    if (lang.languageCode == locale.languageCode) return lang;
  }
  return Messages();
}
