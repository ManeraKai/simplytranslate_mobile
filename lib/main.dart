import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import './data.dart';

String fromLanguage = 'English';
String toLanguage = 'Arabic';
String instance = 'https://translate.metalune.xyz';
int instanceIndex = 0;

String translationInput = '';
String translationOutput = '';

String customInstance = '';
String customUrl = '';

enum customInstanceValidation {
  False,
  True,
  NotChecked,
}

var isCustomInstanceValid = customInstanceValidation.NotChecked;
List selectLanguages = [];
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
  if (session.read('from_language').toString() != 'null')
    fromLanguage = session.read('from_language').toString();
  if (session.read('to_language').toString() != 'null')
    toLanguage = session.read('to_language').toString();

  instance = session.read('instance_mode').toString() != 'null'
      ? session.read('instance_mode').toString()
      : instance;

  customUrl = session.read('url') != null ? session.read('url').toString() : '';
  customUrlController.text = customUrl;
  //--------------------------------------------//

  return runApp(MyApp());
}

final session = GetStorage();

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: whiteColor,
        ),
        textTheme: const TextTheme(
            bodyText2: const TextStyle(color: whiteColor),
            subtitle1: const TextStyle(color: whiteColor, fontSize: 16),
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
        body: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

final customUrlController = TextEditingController();
final translationInputController = TextEditingController();

class _MainPageState extends State<MainPage> {
  void dispose() {
    customUrlController.dispose();
    super.dispose();
  }

  Future<String> translate(String input) async {
    final url;
    if (instance == 'custom') {
      if (customInstance.endsWith('/')) {
        // trimming last slash
        customInstance = customInstance.substring(0, customInstance.length - 1);
      }
      if (customInstance.startsWith('https://')) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');
        // custom https://
      } else if (customInstance.startsWith('http://')) {
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

    showDialogError() {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                backgroundColor: secondgreyColor,
                title: Text(AppLocalizations.of(context)!.something_went_wrong),
                content: Text(AppLocalizations.of(context)!.check_instance),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(AppLocalizations.of(context)!.ok),
                  )
                ],
              ));
    }

    try {
      final response = await http.post(url, body: {
        'from_language': fromLanguage,
        'to_language': toLanguage,
        'input': input,
      });

      if (response.statusCode == 200) {
        final x = parse(response.body)
            .getElementsByClassName('translation')[0]
            .innerHtml;
        translationOutput = x;
        return x;
      } else
        showDialogError();
      return 'Request failed with status: ${response.statusCode}.';
    } catch (err) {
      showDialogError();
      return 'something went wrong buddy.';
    }
  }

  Future<void> checkInstance() async {
    setState(() => checkLoading = true);

    final url;
    var tmpUrl = '';
    if (instance == 'custom') {
      tmpUrl = customInstance;
      if (customInstance.endsWith('/'))
        // trimming last slash
        customInstance = customInstance.substring(0, customInstance.length - 1);

      if (customInstance.startsWith('https://')) {
        customInstance = customInstance.trim();
        url = Uri.https(customInstance.substring(8), '/');
        // custom https://
      } else if (customInstance.startsWith('http://'))
        // http://
        url = Uri.http(customInstance.substring(7), '/');
      else
        url = Uri.https(customInstance, '/');
      // custom else https://

    } else
      url = Uri.https(instances[instanceIndex].toString().substring(8), '/');
    // default https://

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
            'SimplyTranslate')) {
          session.write('url', tmpUrl);
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
    return;
  }

  fromLangWidget() => Container(
        width: MediaQuery.of(context).size.width / 3 + 10,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: boxDecorationCustom,
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox.shrink(),
          dropdownColor: greyColor,
          onChanged: (String? value) {
            session.write('from_language', value);
            setState(() => fromLanguage = value!);
          },
          value: fromLanguage,
          items: () {
            var list = <DropdownMenuItem<String>>[];
            list.add(DropdownMenuItem(
              value: AppLocalizations.of(context)!.autodetect,
              child: Text(AppLocalizations.of(context)!.autodetect),
            ));
            for (int i = 1; i < supportedLanguages.length; i++)
              list.add(DropdownMenuItem(
                  value: supportedLanguages[i],
                  child: Text(selectLanguages[i])));
            return list;
          }(),
        ),
      );

  toLangWidget() => Container(
        width: MediaQuery.of(context).size.width / 3 + 10,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: boxDecorationCustom,
        child: DropdownButton(
          isExpanded: true,
          underline: const SizedBox.shrink(),
          dropdownColor: greyColor,
          onChanged: (String? value) async {
            session.write('to_language', value);
            setState(() => {toLanguage = value!});
          },
          value: toLanguage,
          items: () {
            var list = <DropdownMenuItem<String>>[];
            for (int i = 1; i < supportedLanguages.length; i++)
              list.add(DropdownMenuItem(
                  value: supportedLanguages[i],
                  child: Text(selectLanguages[i])));
            return list;
          }(),
        ),
      );

  switchLangBtnWidget() => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        decoration: boxDecorationCustom,
        child: TextButton(
          onPressed: () async {
            FocusScope.of(context).unfocus();
            loading = true;
            final tmp = fromLanguage;
            fromLanguage = toLanguage;
            toLanguage = tmp;
            translationInputController.text = translationOutput;
            final x = await translate(translationInput);
            setState(() {
              loading = false;
              translationOutput = x;
            });
          },
          child: const Text('<->'),
        ),
      );

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    selectLanguages = [
      AppLocalizations.of(context)!.afrikaans,
      AppLocalizations.of(context)!.albanian,
      AppLocalizations.of(context)!.amharic,
      AppLocalizations.of(context)!.arabic,
      AppLocalizations.of(context)!.armenian,
      AppLocalizations.of(context)!.azerbaijani,
      AppLocalizations.of(context)!.basque,
      AppLocalizations.of(context)!.belarusian,
      AppLocalizations.of(context)!.bengali,
      AppLocalizations.of(context)!.bosnian,
      AppLocalizations.of(context)!.bulgarian,
      AppLocalizations.of(context)!.catalan,
      AppLocalizations.of(context)!.cebuano,
      AppLocalizations.of(context)!.chichewa,
      AppLocalizations.of(context)!.chinese,
      AppLocalizations.of(context)!.corsican,
      AppLocalizations.of(context)!.croatian,
      AppLocalizations.of(context)!.czech,
      AppLocalizations.of(context)!.danish,
      AppLocalizations.of(context)!.dutch,
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.esperanto,
      AppLocalizations.of(context)!.estonian,
      AppLocalizations.of(context)!.filipino,
      AppLocalizations.of(context)!.finnish,
      AppLocalizations.of(context)!.french,
      AppLocalizations.of(context)!.frisian,
      AppLocalizations.of(context)!.galician,
      AppLocalizations.of(context)!.georgian,
      AppLocalizations.of(context)!.german,
      AppLocalizations.of(context)!.greek,
      AppLocalizations.of(context)!.gujarati,
      AppLocalizations.of(context)!.haitian_creole,
      AppLocalizations.of(context)!.hausa,
      AppLocalizations.of(context)!.hawaiian,
      AppLocalizations.of(context)!.hebrew,
      AppLocalizations.of(context)!.hindi,
      AppLocalizations.of(context)!.hmong,
      AppLocalizations.of(context)!.hungarian,
      AppLocalizations.of(context)!.icelandic,
      AppLocalizations.of(context)!.igbo,
      AppLocalizations.of(context)!.indonesian,
      AppLocalizations.of(context)!.irish,
      AppLocalizations.of(context)!.italian,
      AppLocalizations.of(context)!.japanese,
      AppLocalizations.of(context)!.javanese,
      AppLocalizations.of(context)!.kannada,
      AppLocalizations.of(context)!.kazakh,
      AppLocalizations.of(context)!.khmer,
      AppLocalizations.of(context)!.kinyarwanda,
      AppLocalizations.of(context)!.korean,
      AppLocalizations.of(context)!.kurdish_kurmanji,
      AppLocalizations.of(context)!.kyrgyz,
      AppLocalizations.of(context)!.lao,
      AppLocalizations.of(context)!.latin,
      AppLocalizations.of(context)!.latvian,
      AppLocalizations.of(context)!.lithuanian,
      AppLocalizations.of(context)!.luxembourgish,
      AppLocalizations.of(context)!.macedonian,
      AppLocalizations.of(context)!.malagasy,
      AppLocalizations.of(context)!.malay,
      AppLocalizations.of(context)!.malayalam,
      AppLocalizations.of(context)!.maltese,
      AppLocalizations.of(context)!.maori,
      AppLocalizations.of(context)!.marathi,
      AppLocalizations.of(context)!.mongolian,
      AppLocalizations.of(context)!.myanmar_burmese,
      AppLocalizations.of(context)!.nepali,
      AppLocalizations.of(context)!.norwegian,
      AppLocalizations.of(context)!.odia_oriya,
      AppLocalizations.of(context)!.pashto,
      AppLocalizations.of(context)!.persian,
      AppLocalizations.of(context)!.polish,
      AppLocalizations.of(context)!.portuguese,
      AppLocalizations.of(context)!.punjabi,
      AppLocalizations.of(context)!.romanian,
      AppLocalizations.of(context)!.russian,
      AppLocalizations.of(context)!.samoan,
      AppLocalizations.of(context)!.scots_gaelic,
      AppLocalizations.of(context)!.serbian,
      AppLocalizations.of(context)!.sesotho,
      AppLocalizations.of(context)!.shona,
      AppLocalizations.of(context)!.sindhi,
      AppLocalizations.of(context)!.sinhala,
      AppLocalizations.of(context)!.slovak,
      AppLocalizations.of(context)!.slovenian,
      AppLocalizations.of(context)!.somali,
      AppLocalizations.of(context)!.spanish,
      AppLocalizations.of(context)!.sundanese,
      AppLocalizations.of(context)!.swahili,
      AppLocalizations.of(context)!.swedish,
      AppLocalizations.of(context)!.tajik,
      AppLocalizations.of(context)!.tamil,
      AppLocalizations.of(context)!.tatar,
      AppLocalizations.of(context)!.telugu,
      AppLocalizations.of(context)!.thai,
      AppLocalizations.of(context)!.turkish,
      AppLocalizations.of(context)!.turkmen,
      AppLocalizations.of(context)!.ukrainian,
      AppLocalizations.of(context)!.urdu,
      AppLocalizations.of(context)!.uyghur,
      AppLocalizations.of(context)!.uzbek,
      AppLocalizations.of(context)!.vietnamese,
      AppLocalizations.of(context)!.welsh,
      AppLocalizations.of(context)!.xhosa,
      AppLocalizations.of(context)!.yiddish,
      AppLocalizations.of(context)!.yoruba,
      AppLocalizations.of(context)!.zulu,
    ];
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //------------- [fromLang, Switch, toLang] -------------//
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  fromLangWidget(),
                  switchLangBtnWidget(),
                  toLangWidget(),
                ],
              ),
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
                    controller: translationInputController,
                    keyboardType: TextInputType.text,
                    onChanged: (String input) async {
                      translationInput = input;
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: lightgreyColor),
                        hintText:
                            AppLocalizations.of(context)!.enter_text_here),
                    style: const TextStyle(fontSize: 20),
                    onEditingComplete: () async {
                      FocusScope.of(context).unfocus();
                      setState(() => loading = true);
                      await translate(translationInput);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: loading
                        ? Container(
                            alignment: Alignment.center,
                            width: 80,
                            child: CircularProgressIndicator())
                        : TextButton(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              setState(() => loading = true);
                              await translate(translationInput);
                              setState(() => loading = false);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.translate,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Clipboard.setData(
                                ClipboardData(text: translationOutput))
                            .then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: greyColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              behavior: SnackBarBehavior.floating,
                              width: 160,
                              content: Text(
                                AppLocalizations.of(context)!
                                    .copied_to_clipboard,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.copy),
                    ),
                  )
                ],
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
                        isExpanded: true,
                        underline: const SizedBox.shrink(),
                        dropdownColor: greyColor,
                        onChanged: (String? value) => setState(() {
                          if (value == 'random')
                            instanceIndex = Random().nextInt(instances.length);
                          else if (value == 'custom')
                            instanceIndex = 0;
                          else
                            instanceIndex = instances.indexOf(value!);
                          instance = value!;
                          session.write('instance_mode', value);
                        }),
                        value: instance,
                        items: [
                          ...() {
                            var list = <DropdownMenuItem<String>>[];
                            for (String x in instances)
                              list.add(
                                  DropdownMenuItem(value: x, child: Text(x)));
                            return list;
                          }(),
                          DropdownMenuItem(
                              value: 'random',
                              child:
                                  Text(AppLocalizations.of(context)!.random)),
                          DropdownMenuItem(
                              value: 'custom',
                              child: Text(AppLocalizations.of(context)!.custom))
                        ],
                      ),
                    ),
                    //----------------------------------------------------------//
                    if (instance == 'custom') ...[
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
                          onEditingComplete: () {
                            FocusScope.of(context).unfocus();
                            checkInstance();
                          },
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
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                checkInstance();
                              },
                              child: Text(AppLocalizations.of(context)!.check)),
                      //----------------------------------------------------//
                    ] else if (instance == 'random') ...[
                      const SizedBox(height: 10),
                      //------- All Known Instances in a Scrollable List -------//
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: () {
                            var list = <Widget>[];
                            for (String x in instances) {
                              list.add(Text('● $x'));
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
