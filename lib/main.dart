import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import "dart:math";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

String fromLanguage = "English";
String toLanguage = "Arabic";
String instance = "https://translate.metalune.xyz";
int instanceIndex = 0;

String translationInput = "";
String translationOutput = "";

String customInstance = "";
enum customInstanceValidation {
  False,
  True,
  NotChecked,
}

var isCustomInstanceValid = customInstanceValidation.NotChecked;

bool checkLoading = false;

bool loading = false;

List<String> supportedLanguages = [];

const greyColor = Color(0xff131618);
const lightgreyColor = Color(0xff495057);
const secondgreyColor = Color(0xff212529);
const whiteColor = Color(0xfff5f6f7);

final boxDecorationCustom = BoxDecoration(
    color: greyColor,
    border: Border.all(
      color: lightgreyColor,
      width: 2,
      style: BorderStyle.solid,
    ));

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
            bodyText2: const TextStyle(color: whiteColor),
            subtitle1: const TextStyle(color: whiteColor),
            headline6: const TextStyle(color: whiteColor)),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(greyColor),
            overlayColor: MaterialStateProperty.all(greyColor),
            foregroundColor: MaterialStateProperty.all(whiteColor),
          ),
        ),
      ),
      title: 'Simply Translate',
      home: Scaffold(
        backgroundColor: secondgreyColor,
        body: FutureBuilder(
          future: () async {
            final tmpData =
                json.decode(await rootBundle.loadString('instances.json'));
            List<String> data = [];
            for (var x in tmpData) data.add(x.toString());
            return data;
          }(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              dynamic instances = snapshot.data;

              Future<String> translate(String input) async {
                final url;
                if (instance == "custom") {
                  if (customInstance.endsWith("/")) {
                    print("trimming last slash");
                    customInstance =
                        customInstance.substring(0, customInstance.length - 1);
                  }
                  if (customInstance.startsWith("https://")) {
                    customInstance = customInstance.trim();
                    url = Uri.https(customInstance.substring(8), '/');
                    print("custom https://");
                  } else if (customInstance.startsWith("http://")) {
                    print("http://");
                    url = Uri.http(customInstance.substring(7), '/');
                  } else {
                    url = Uri.https(customInstance, '/');
                    print("custom else https://");
                  }
                } else {
                  url = Uri.https(
                      instances[instanceIndex].toString().substring(8), '/');
                  print("default https://");
                }

                final response = await http.post(url, body: {
                  "from_language": fromLanguage,
                  "to_language": toLanguage,
                  "input": input,
                });
                if (response.statusCode == 200)
                  return response.body;
                else
                  return 'Request failed with status: ${response.statusCode}.';
              }

              updateTranslation(input) async {
                return parse(await translate(input))
                    .getElementsByClassName("translation")[0]
                    .innerHtml;
              }

              var submitTranslation = () async {
                FocusScope.of(context).unfocus();
                final x = await updateTranslation(translationInput);
                translationOutput = x;
              };

              return FutureBuilder(
                future: () async {
                  final url;
                  if (instance == "custom") {
                    if (customInstance.endsWith("/")) {
                      print("trimming last slash");
                      customInstance = customInstance.substring(
                          0, customInstance.length - 1);
                    }
                    if (customInstance.startsWith("https://")) {
                      customInstance = customInstance.trim();
                      url = Uri.https(customInstance.substring(8), '/');
                      print("custom https://");
                    } else if (customInstance.startsWith("http://")) {
                      print("http://");
                      url = Uri.http(customInstance.substring(7), '/');
                    } else {
                      url = Uri.https(customInstance, '/');
                      print("custom else https://");
                    }
                  } else {
                    url = Uri.https(
                        instances[instanceIndex].toString().substring(8), '/');
                    print("default https://");
                  }
                  final response = await http.get(url);
                  if (response.statusCode == 200) {
                    String x = parse(response.body)
                        .getElementById("from_language")!
                        .innerHtml;
                    x = x.replaceAll('<', '');
                    x = x.replaceAll('>', '');
                    x = x.replaceAll('/', '');
                    x = x.replaceAll('"', '');
                    x = x.replaceAll('=', '');
                    x = x.replaceAll('selected', '');
                    x = x.replaceAll('value', '');
                    x = x.replaceAll('option', '');
                    x = x.replaceAll('(', '');
                    x = x.replaceAll(')', '');
                    x = x.replaceAll(
                        RegExp(
                            '[ \f\n\r\t\v\u00a0\u1680\u2000-\u200a\u2028\u2029\u202f\u205f\u3000\ufeff]'),
                        '');
                    var y = 0;
                    List<String> z = [];
                    for (var i = 0; i < x.length - 1; i++) {
                      if (x[i].toUpperCase() == x[i]) {
                        y = 1;
                      }
                      if (x[i].toUpperCase() == x[i] && y == 1) {
                        if (!z.contains(x.substring(0, i)) &&
                            x.substring(0, i).isNotEmpty)
                          z.add(x.substring(0, i));
                        x = x.substring(i, x.length - 1);
                        y = 0;
                        i = 0;
                      }
                    }
                    supportedLanguages = z;
                  } else
                    return 'Request failed with status: ${response.statusCode}.';
                }(),
                builder: (context, snapshot) {
                  return MainPage(
                    submitTranslation: submitTranslation,
                    instances: instances,
                    updateTranslation: updateTranslation,
                  );
                },
              );
            }
            return const Center(child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage(
      {Key? key,
      required this.submitTranslation,
      required this.instances,
      required this.updateTranslation})
      : super(key: key);

  final Future<Null> Function() submitTranslation;
  final instances;
  final updateTranslation;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  checkInstance() async {
    setState(() => checkLoading = true);

    final url;
    if (instance == "custom") {
      if (customInstance.endsWith("/")) {
        print("trimming last slash");
        customInstance = customInstance.substring(0, customInstance.length - 1);
      }
      if (customInstance.startsWith("https://")) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');
        print("custom https://");
      } else if (customInstance.startsWith("http://")) {
        print("http://");
        url = Uri.http(customInstance.substring(7), '/');
      } else {
        url = Uri.https(customInstance, '/');
        print("custom else https://");
      }
    } else {
      url = Uri.https(
          widget.instances[instanceIndex].toString().substring(8), '/');
      print("default https://");
    }
    final response;
    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
            "SimplyTranslate"))
          setState(() => isCustomInstanceValid = customInstanceValidation.True);
        else
          setState(
              () => isCustomInstanceValid = customInstanceValidation.False);
      } else
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
    } catch (err) {
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
    }

    setState(() => checkLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: FutureBuilder(
          future: null,
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row [fromLang, Switch, toLang]
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // fromLanguage select button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: boxDecorationCustom,
                        child: DropdownButton(
                          underline: const SizedBox.shrink(),
                          dropdownColor: greyColor,
                          onChanged: (String? value) =>
                              setState(() => fromLanguage = value!),
                          value: fromLanguage,
                          items: () {
                            var list = <DropdownMenuItem<String>>[];
                            for (String x in supportedLanguages)
                              list.add(
                                  DropdownMenuItem(value: x, child: Text(x)));
                            return list;
                          }(),
                        ),
                      ),
                      // Switch Language Button
                      Container(
                        decoration: boxDecorationCustom,
                        child: TextButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                              final tmp = fromLanguage;
                              fromLanguage = toLanguage;
                              toLanguage = tmp;
                            });
                            final x = await widget
                                .updateTranslation(translationOutput);
                            setState(() {
                              loading = false;
                              translationOutput = x;
                            });
                          },
                          child: const Text("<->"),
                        ),
                      ),
                      // toLanguage select button
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: boxDecorationCustom,
                        child: DropdownButton(
                          underline: const SizedBox.shrink(),
                          dropdownColor: greyColor,
                          onChanged: (String? value) =>
                              setState(() => toLanguage = value!),
                          value: toLanguage,
                          items: () {
                            var list = <DropdownMenuItem<String>>[];
                            for (String x in supportedLanguages)
                              list.add(
                                  DropdownMenuItem(value: x, child: Text(x)));
                            return list;
                          }(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Translation input
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: boxDecorationCustom,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        maxLines: 8,
                        keyboardType: TextInputType.text,
                        onChanged: (String input) async {
                          translationInput = input;
                        },
                        cursorColor: whiteColor,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: lightgreyColor),
                            hintText: "Enter Text Here"),
                        style: const TextStyle(fontSize: 20),
                        onEditingComplete: () async {
                          setState(() => loading = true);
                          await widget.submitTranslation();
                          setState(() => loading = false);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Translation output
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: boxDecorationCustom,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SelectableText(
                        translationOutput,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Translate Button
                  Container(
                    alignment: Alignment.topLeft,
                    height: 50,
                    child: loading
                        ? Container(
                            alignment: Alignment.center,
                            width: 80,
                            child: CircularProgressIndicator())
                        : TextButton(
                            onPressed: () async {
                              setState(() => loading = true);
                              await widget.submitTranslation();
                              setState(() => loading = false);
                            },
                            child: Text(
                              "Translate",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Instance Select Button.
                        Container(
                          decoration: boxDecorationCustom,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: DropdownButton(
                            underline: const SizedBox.shrink(),
                            dropdownColor: greyColor,
                            onChanged: (String? value) => setState(() {
                              if (value == "random")
                                instanceIndex =
                                    Random().nextInt(widget.instances.length);
                              else if (value == "custom")
                                instanceIndex = 0;
                              else
                                instanceIndex =
                                    widget.instances.indexOf(value!);
                              instance = value!;
                            }),
                            value: instance,
                            items: [
                              ...() {
                                var list = <DropdownMenuItem<String>>[];
                                for (String x in widget.instances)
                                  list.add(DropdownMenuItem(
                                      value: x, child: Text(x)));
                                return list;
                              }(),
                              DropdownMenuItem(
                                  value: "random", child: const Text("Random")),
                              DropdownMenuItem(
                                  value: "custom", child: const Text("Custom"))
                            ],
                          ),
                        ),
                        // If Instance selection is `Custom Instance`.
                        if (instance == "custom") ...[
                          SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: boxDecorationCustom.copyWith(
                                color: isCustomInstanceValid ==
                                        customInstanceValidation.True
                                    ? Colors.green
                                    : isCustomInstanceValid ==
                                            customInstanceValidation.False
                                        ? Colors.red
                                        : null),
                            child: TextField(
                              keyboardType: TextInputType.url,
                              onChanged: (String? value) {
                                customInstance = value!;
                                if (isCustomInstanceValid !=
                                    customInstanceValidation.NotChecked)
                                  setState(() {
                                    isCustomInstanceValid =
                                        customInstanceValidation.NotChecked;
                                  });
                              },
                              onEditingComplete: checkInstance,
                              cursorColor: whiteColor,
                              decoration: const InputDecoration(
                                  focusedBorder: InputBorder.none),
                              style: const TextStyle(
                                  fontSize: 20, color: whiteColor),
                            ),
                          ),
                          const SizedBox(height: 10),
                          checkLoading
                              ? Container(
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                              : TextButton(
                                  style: ButtonStyle(
                                      backgroundColor: checkLoading
                                          ? MaterialStateProperty.all(
                                              Colors.transparent)
                                          : null),
                                  onPressed: checkInstance,
                                  child: Text("Check")),
                        ]
                        // If Instance selection is `Random Instance`.
                        else if (instance == "random") ...[
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: () {
                                var list = <Widget>[];
                                for (String x in widget.instances) {
                                  list.add(Text("● $x"));
                                  list.add(SizedBox(height: 10));
                                }
                                return list;
                              }(),
                            ),
                          )
                        ]
                        // Instance Select is one of the `Default Instances`.
                        else
                          const SizedBox.shrink()
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
