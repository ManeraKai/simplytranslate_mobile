import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import "dart:math";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

String fromLanguage = "English";
String toLanguage = "Arabic";
String instance = "translate.metalune.xyz";

String translationInput = "";
String translationOutput = "";

String customInstance = "";

int instanceIndex = 0;

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
                final url = Uri.https(
                  instance == "custom"
                      ? customInstance
                      : instances[instanceIndex],
                  '/',
                );
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

              updateTranslation(input) async => parse(await translate(input))
                  .getElementsByClassName("translation")[0]
                  .innerHtml;

              var submitTranslation = () async {
                FocusScope.of(context).unfocus();
                final x = await updateTranslation(translationInput);
                translationOutput = x;
                print(translationOutput);
              };

              return FutureBuilder(
                future: () async {
                  final url = Uri.https(
                    instance == "custom"
                        ? customInstance
                        : instances[instanceIndex],
                    '/',
                  );
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
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: FutureBuilder(
                        future: null,
                        builder: (context, snapshot) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Row [fromLang, Switch, toLang]
                                FromSwitchToLangRow(updateTranslation),
                                const SizedBox(height: 20),
                                // Translation input
                                Container(
                                  width: double.infinity,
                                  height: 150,
                                  decoration: boxDecorationCustom,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: TextField(
                                      maxLines: 8,
                                      keyboardType: TextInputType.text,
                                      onChanged: (String input) async {
                                        translationInput = input;
                                      },
                                      cursorColor: whiteColor,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: const TextStyle(
                                              color: lightgreyColor),
                                          hintText: "Enter Text Here"),
                                      style: const TextStyle(fontSize: 20),
                                      onEditingComplete: () async {
                                        loading = true;
                                        await submitTranslation();
                                        loading = false;
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
                                TranslateButton(submitTranslation),
                                const SizedBox(height: 50),
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Instance Select Button.
                                      Container(
                                        decoration: boxDecorationCustom,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: DropdownButton(
                                          underline: const SizedBox.shrink(),
                                          dropdownColor: greyColor,
                                          onChanged: (String? value) =>
                                              setState(() {
                                            if (value == "random")
                                              instanceIndex = Random()
                                                  .nextInt(instances.length);
                                            else if (value == "custom")
                                              instanceIndex = 0;
                                            else
                                              instanceIndex =
                                                  instances.indexOf(value!);
                                            instance = value!;
                                          }),
                                          value: instance,
                                          items: [
                                            ...() {
                                              var list =
                                                  <DropdownMenuItem<String>>[];
                                              for (String x in instances)
                                                list.add(DropdownMenuItem(
                                                    value: x, child: Text(x)));
                                              return list;
                                            }(),
                                            DropdownMenuItem(
                                                value: "random",
                                                child: const Text("Random")),
                                            DropdownMenuItem(
                                                value: "custom",
                                                child: const Text("Custom"))
                                          ],
                                        ),
                                      ),
                                      // If Instance selection is `Custom Instance`.
                                      if (instance == "custom") ...[
                                        SizedBox(height: 10),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          decoration: boxDecorationCustom,
                                          child: TextField(
                                            keyboardType: TextInputType.url,
                                            onChanged: (String? value) =>
                                                customInstance = value!,
                                            cursorColor: whiteColor,
                                            decoration: const InputDecoration(
                                                focusedBorder:
                                                    InputBorder.none),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: whiteColor),
                                          ),
                                        )
                                      ]
                                      // If Instance selection is `Random Instance`.
                                      else if (instance == "random") ...[
                                        const SizedBox(height: 10),
                                        SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: () {
                                              var list = <Widget>[];
                                              for (String x in instances) {
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
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: const CircularProgressIndicator());
            return Text("Wewe");
          },
        ),
      ),
    );
  }
}

class FromSwitchToLangRow extends StatefulWidget {
  final updateTranslation;

  const FromSwitchToLangRow(
    this.updateTranslation, {
    Key? key,
  }) : super(key: key);

  @override
  _FromSwitchToLangRowState createState() => _FromSwitchToLangRowState();
}

class _FromSwitchToLangRowState extends State<FromSwitchToLangRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // fromLanguage select button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: boxDecorationCustom,
          child: DropdownButton(
            underline: const SizedBox.shrink(),
            dropdownColor: greyColor,
            onChanged: (String? value) => setState(() => fromLanguage = value!),
            value: fromLanguage,
            items: () {
              var list = <DropdownMenuItem<String>>[];
              for (String x in supportedLanguages)
                list.add(DropdownMenuItem(value: x, child: Text(x)));
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
                final tmp = fromLanguage;
                fromLanguage = toLanguage;
                toLanguage = tmp;
              });
              final x = await widget.updateTranslation(translationOutput);
              setState(() => translationOutput = x);
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
            onChanged: (String? value) => setState(() => toLanguage = value!),
            value: toLanguage,
            items: () {
              var list = <DropdownMenuItem<String>>[];
              for (String x in supportedLanguages)
                list.add(DropdownMenuItem(value: x, child: Text(x)));
              return list;
            }(),
          ),
        ),
      ],
    );
  }
}

class TranslateButton extends StatefulWidget {
  const TranslateButton(this.submitTranslation, {Key? key}) : super(key: key);
  final submitTranslation;

  @override
  _TranslateButtonState createState() => _TranslateButtonState();
}

class _TranslateButtonState extends State<TranslateButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
