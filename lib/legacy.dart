// getting supported languages from instance.
// Made it legacy because supported languages won't change to the point where it shoud be updated every start.

// final url;
//                   if (instance == "custom") {
//                     if (customInstance.endsWith("/")) {
//                       print("trimming last slash");
//                       customInstance = customInstance.substring(
//                           0, customInstance.length - 1);
//                     }
//                     if (customInstance.startsWith("https://")) {
//                       customInstance = customInstance.trim();
//                       url = Uri.https(customInstance.substring(8), '/');
//                       print("custom https://");
//                     } else if (customInstance.startsWith("http://")) {
//                       print("http://");
//                       url = Uri.http(customInstance.substring(7), '/');
//                     } else {
//                       url = Uri.https(customInstance, '/');
//                       print("custom else https://");
//                     }
//                   } else {
//                     url = Uri.https(
//                         instances[instanceIndex].toString().substring(8), '/');
//                     print("default https://");
//                   }
//                   final response = await http.get(url);
//                   if (response.statusCode == 200) {
//                     String x = parse(response.body)
//                         .getElementById("from_language")!
//                         .innerHtml;
//                     x = x.replaceAll('<', '');
//                     x = x.replaceAll('>', '');
//                     x = x.replaceAll('/', '');
//                     x = x.replaceAll('"', '');
//                     x = x.replaceAll('=', '');
//                     x = x.replaceAll('selected', '');
//                     x = x.replaceAll('value', '');
//                     x = x.replaceAll('option', '');
//                     x = x.replaceAll('(', '');
//                     x = x.replaceAll(')', '');
//                     x = x.replaceAll(
//                         RegExp(
//                             '[ \f\n\r\t\v\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]'),
//                         '');
//                     var y = 0;
//                     List<String> z = [];
//                     for (var i = 0; i < x.length - 1; i++) {
//                       if (x[i].toUpperCase() == x[i]) {
//                         y = 1;
//                       }
//                       if (x[i].toUpperCase() == x[i] && y == 1) {
//                         if (!z.contains(x.substring(0, i)) &&
//                             x.substring(0, i).isNotEmpty)
//                           z.add(x.substring(0, i));
//                         x = x.substring(i, x.length - 1);
//                         y = 0;
//                         i = 0;
//                       }
//                     }
//                     supportedLanguages = z;
//                     return 'Success';
//                   } else
//                     return 'Request failed with status: ${response.statusCode}.';
