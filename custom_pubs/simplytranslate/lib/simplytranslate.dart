library simplytranslate;

import 'dart:typed_data';
import 'package:html/parser.dart' as html;

import 'package:http/http.dart' as http;

Future<Uint8List> tts(String text, String language) async {
  final url = Uri.parse(
    "https://translate.google.com/translate_tts?tl=$language&q=${Uri.encodeQueryComponent(text)}&client=tw-ob",
  );
  final response = await http.get(url);
  return response.bodyBytes;
}

Future<Map<String, Object>> translate(
    String text, String from, String to) async {
  Map<String, Object> response = {};
  final url = Uri.parse(
    "https://translate.google.com/m?tl=$to&hl=$from&q=${Uri.encodeQueryComponent(text)}",
  );
  var document = html.parse((await http.get(url)).body);
  response['text'] =
      document.getElementsByClassName('result-container')[0].innerHtml;

  return response;
}
