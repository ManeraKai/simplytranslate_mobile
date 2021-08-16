import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import "dart:math";
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

String _value = "translate.metalune.xyz";
String fromLanguage = "English";
String toLanguage = "Arabic";
String myText = "";

Future<List<String>> instancesGet = () async {
  var tmpData = json.decode(await rootBundle.loadString('instances.json'));
  List<String> data = [];
  for (var x in tmpData) {
    data.add(x.toString());
  }
  return data;
}();

int instanceIndex = 0;

void main(List<String> args) => runApp(MyApp());

var greyColor = Color(0xff131618);
var lightgreyColor = Color(0xff495057);
var secondgreyColor = Color(0xff212529);
var whiteColor = Color(0xfff5f6f7);

var boxDecorationCustom = BoxDecoration(
    color: greyColor,
    border: Border.all(
      color: lightgreyColor,
      width: 2,
      style: BorderStyle.solid,
    ));

var customInstance = "";

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText2: TextStyle(color: whiteColor),
            subtitle1: TextStyle(color: whiteColor),
            headline6: TextStyle(color: whiteColor)),
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
            future: instancesGet,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                dynamic instances = snapshot.data;

                List<DropdownMenuItem<String>> _instancesDropDown = () {
                  var list = <DropdownMenuItem<String>>[];
                  for (String x in instances) {
                    list.add(DropdownMenuItem(value: x, child: Text(x)));
                  }
                  return list;
                }();

                Future<String> translate(String input) async {
                  var url = Uri.https(
                    _value == "custom"
                        ? customInstance
                        : instances[instanceIndex],
                    '/',
                  );
                  var response = await http.post(url, body: {
                    "from_language": fromLanguage,
                    "to_language": toLanguage,
                    "input": input,
                  });
                  if (response.statusCode == 200)
                    return response.body;
                  else
                    return 'Request failed with status: ${response.statusCode}.';
                }

                updateTranslation(input, instancesLocal) async =>
                    parse(await translate(input))
                        .getElementsByClassName("translation")[0]
                        .innerHtml;

                List<Widget> _instancesText = () {
                  var list = <Widget>[];
                  for (String x in instances) {
                    list.add(Text("● $x"));
                    list.add(SizedBox(height: 10));
                  }
                  return list;
                }();
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: boxDecorationCustom,
                                child: DropdownButton(
                                  underline: SizedBox.shrink(),
                                  dropdownColor: greyColor,
                                  onChanged: (String? value) =>
                                      setState(() => fromLanguage = value!),
                                  value: fromLanguage,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("English"),
                                        value: "English"),
                                    DropdownMenuItem(
                                        child: Text("Arabic"), value: "Arabic"),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: boxDecorationCustom,
                                child: TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      var tmp = fromLanguage;
                                      fromLanguage = toLanguage;
                                      toLanguage = tmp;
                                    });
                                    var x = await updateTranslation(
                                        myText, snapshot.data);
                                    setState(() => myText = x);
                                  },
                                  child: Text("<->"),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                decoration: boxDecorationCustom,
                                child: DropdownButton(
                                  underline: SizedBox.shrink(),
                                  dropdownColor: greyColor,
                                  onChanged: (String? value) =>
                                      setState(() => toLanguage = value!),
                                  value: toLanguage,
                                  items: [
                                    DropdownMenuItem(
                                        child: Text("English"),
                                        value: "English"),
                                    DropdownMenuItem(
                                        child: Text("Arabic"), value: "Arabic"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 350,
                            height: 150,
                            decoration: boxDecorationCustom,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                  maxLines: 8,
                                  onChanged: (String? input) async {
                                    var x = await updateTranslation(
                                        input!, snapshot.data);
                                    setState(() => myText = x);
                                  },
                                  cursorColor: whiteColor,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle:
                                          TextStyle(color: lightgreyColor),
                                      hintText: "Enter Text Here"),
                                  style: TextStyle(fontSize: 20)),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            width: 350,
                            height: 150,
                            decoration: boxDecorationCustom,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SelectableText(
                                  myText,
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // IconButton(
                                //     onPressed: () {}, icon: Icon(Icons.settings)),
                                Container(
                                  decoration: boxDecorationCustom,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: DropdownButton(
                                    underline: SizedBox.shrink(),
                                    dropdownColor: greyColor,
                                    onChanged: (String? value) => setState(() {
                                      if (value == "random")
                                        instanceIndex =
                                            Random().nextInt(instances.length);
                                      else if (value == "custom")
                                        instanceIndex = 0;
                                      else
                                        instanceIndex = instances.indexOf(
                                            value!, instances);

                                      _value = value!;
                                    }),
                                    value: _value,
                                    items: [
                                      ..._instancesDropDown,
                                      DropdownMenuItem(
                                          value: "random",
                                          child: Text("Random")),
                                      DropdownMenuItem(
                                          value: "custom",
                                          child: Text("Custom"))
                                    ],
                                  ),
                                ),
                                if (_value == "custom") ...[
                                  SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: boxDecorationCustom,
                                    child: TextField(
                                      onChanged: (String? value) =>
                                          customInstance = value!,
                                      cursorColor: whiteColor,
                                      decoration: InputDecoration(
                                          focusedBorder: InputBorder.none),
                                      style: TextStyle(
                                          fontSize: 20, color: whiteColor),
                                    ),
                                  )
                                ] else if (_value == "random") ...[
                                  SizedBox(height: 10),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: _instancesText,
                                    ),
                                  )
                                ] else
                                  SizedBox.shrink()
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
