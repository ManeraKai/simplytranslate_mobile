import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import "dart:math";
import 'package:get_storage/get_storage.dart';

import './data.dart';

String fromLanguage = "English";
String toLanguage = "Arabic";
String instance = "https://translate.metalune.xyz";
int instanceIndex = 0;

String translationInput = "";
String translationOutput = "";

String customInstance = "";
String customUrl = '';

enum customInstanceValidation {
  False,
  True,
  NotChecked,
}

var isCustomInstanceValid = customInstanceValidation.NotChecked;

bool checkLoading = false;
bool loading = false;

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

void main(List<String> args) async {
  //------ Setting session variables up --------//
  await GetStorage.init();
  if (box.read('from_language').toString() != 'null')
    fromLanguage = box.read('from_language').toString();
  if (box.read('to_language').toString() != 'null')
    toLanguage = box.read('to_language').toString();

  instance = box.read('instance_mode').toString() != 'null'
      ? box.read('instance_mode').toString()
      : instance;

  customUrl = box.read('url') != null ? box.read('url').toString() : '';
  customUrlController.text = customUrl;
  //--------------------------------------------//

  return runApp(MyApp());
}

final box = GetStorage();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Future<String> translate(String input) async {
      final url;
      if (instance == "custom") {
        if (customInstance.endsWith("/")) {
          // trimming last slash
          customInstance =
              customInstance.substring(0, customInstance.length - 1);
        }
        if (customInstance.startsWith("https://")) {
          customInstance = customInstance.trim();
          url = Uri.https(customInstance.substring(8), '/');
          // custom https://
        } else if (customInstance.startsWith("http://")) {
          // http://
          url = Uri.http(customInstance.substring(7), '/');
        } else {
          url = Uri.https(customInstance, '/');
          // custom else https://
        }
      } else {
        url = Uri.https(instances[instanceIndex].toString().substring(8), '/');
        // default https://
      }

      final response;
      response = await http.post(url, body: {
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
        body: MainPage(
          submitTranslation: submitTranslation,
          instances: instances,
          updateTranslation: updateTranslation,
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

final customUrlController = TextEditingController();

class _MainPageState extends State<MainPage> {
  checkInstance() async {
    setState(() => checkLoading = true);

    final url;
    var tmpUrl = '';
    if (instance == "custom") {
      tmpUrl = customInstance;
      if (customInstance.endsWith("/")) {
        // trimming last slash
        customInstance = customInstance.substring(0, customInstance.length - 1);
      }
      if (customInstance.startsWith("https://")) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');

        // custom https://
      } else if (customInstance.startsWith("http://")) {
        // http://
        url = Uri.http(customInstance.substring(7), '/');
      } else {
        url = Uri.https(customInstance, '/');
        // custom else https://
      }
    } else {
      url = Uri.https(
          widget.instances[instanceIndex].toString().substring(8), '/');
      // default https://
    }

    final response;
    try {
      response = await http.get(url);

      if (response.statusCode == 200) {
        if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
            "SimplyTranslate")) {
          box.write('url', tmpUrl);
          setState(() => isCustomInstanceValid = customInstanceValidation.True);
        } else
          setState(
              () => isCustomInstanceValid = customInstanceValidation.False);
      } else
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
    } catch (err) {
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
    }

    setState(() => checkLoading = false);
  }

  void dispose() {
    customUrlController.dispose();
    super.dispose();
  }

  fromLangWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: boxDecorationCustom,
        child: DropdownButton(
          underline: const SizedBox.shrink(),
          dropdownColor: greyColor,
          onChanged: (String? value) {
            box.write('from_language', value);
            setState(() => fromLanguage = value!);
          },
          value: fromLanguage,
          items: () {
            var list = <DropdownMenuItem<String>>[];
            for (String x in supportedLanguages)
              list.add(DropdownMenuItem(value: x, child: Text(x)));
            return list;
          }(),
        ),
      );

  toLangWidget() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: boxDecorationCustom,
        child: DropdownButton(
          underline: const SizedBox.shrink(),
          dropdownColor: greyColor,
          onChanged: (String? value) async {
            box.write('to_language', value);
            setState(() => {toLanguage = value!});
          },
          value: toLanguage,
          items: () {
            var list = <DropdownMenuItem<String>>[];
            for (String x in supportedLanguages)
              list.add(DropdownMenuItem(value: x, child: Text(x)));
            return list;
          }(),
        ),
      );

  switchLangBtnWidget() => Container(
        width: 50,
        decoration: boxDecorationCustom,
        child: TextButton(
          onPressed: () async {
            setState(() {
              loading = true;
              final tmp = fromLanguage;
              fromLanguage = toLanguage;
              toLanguage = tmp;
            });
            final x = await widget.updateTranslation(translationOutput);
            setState(() {
              loading = false;
              translationOutput = x;
            });
          },
          child: const Text("<->"),
        ),
      );

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //------------- [fromLang, Switch, toLang] -------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  fromLangWidget(),
                  MediaQuery.of(context).size.width > rowWidth
                      ? switchLangBtnWidget()
                      : SizedBox.shrink(),
                  toLangWidget(),
                ],
              ),
              const SizedBox(height: 10),
              MediaQuery.of(context).size.width < rowWidth
                  ? switchLangBtnWidget()
                  : SizedBox.shrink(),
              // ---------------------------------------------------//
              const SizedBox(height: 10),
              //------------------- Translation Input --------------//
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
              //----------------------------------------------------------//
              const SizedBox(height: 10),
              //------------------ Translation Output --------------------//
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
              //----------------------------------------------------------//
              const SizedBox(height: 10),
              //---------------------- Translate Button ------------------//
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
              //--------------------------------------------------------//
              const SizedBox(height: 20),
              //---------------- Settings ------------------//
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //-------------- Instance Select Button --------------------//
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
                            instanceIndex = widget.instances.indexOf(value!);
                          instance = value!;
                          box.write('instance_mode', value);
                        }),
                        value: instance,
                        items: [
                          ...() {
                            var list = <DropdownMenuItem<String>>[];
                            for (String x in widget.instances)
                              list.add(
                                  DropdownMenuItem(value: x, child: Text(x)));
                            return list;
                          }(),
                          DropdownMenuItem(
                              value: "random", child: const Text("Random")),
                          DropdownMenuItem(
                              value: "custom", child: const Text("Custom"))
                        ],
                      ),
                    ),
                    //----------------------------------------------------------//
                    if (instance == "custom") ...[
                      SizedBox(height: 10),
                      //------------- Custom Instance URL Input ----------------//
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
                          controller: customUrlController,
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
                          style:
                              const TextStyle(fontSize: 20, color: whiteColor),
                        ),
                      ),
                      //--------------------------------------------------------//
                      const SizedBox(height: 10),
                      checkLoading
                          ?
                          //----------------- Loading Circle --------------------//
                          Container(
                              width: 50,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator())
                          //----------------------------------------------------//
                          :
                          //----------------- Check Button ---------------------//
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor: checkLoading
                                      ? MaterialStateProperty.all(
                                          Colors.transparent)
                                      : null),
                              onPressed: checkInstance,
                              child: Text("Check")),
                      //----------------------------------------------------//
                    ] else if (instance == "random") ...[
                      const SizedBox(height: 10),
                      //------- All Known Instances in a Scrollable List -------//
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
                      //--------------------------------------------------------//
                    ]
                    // Instance Select is one of the `Default Instances`.
                    else
                      //---- Nothing... the instance will be selected from the original Select Button -----//
                      const SizedBox.shrink()
                  ],
                ),
              ),
              //----------------------------------------------------------//
            ],
          ),
        ),
      ),
    );
  }
}
