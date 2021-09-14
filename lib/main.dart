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
Map selectLanguagesMap = {};
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
        body: MainPageLocalization(),
      ),
    );
  }
}

class MainPageLocalization extends StatelessWidget {
  const MainPageLocalization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    selectLanguagesMap = {
      AppLocalizations.of(context)!.afrikaans: "Afrikaans",
      AppLocalizations.of(context)!.albanian: "Albanian",
      AppLocalizations.of(context)!.amharic: "Amharic",
      AppLocalizations.of(context)!.arabic: "Arabic",
      AppLocalizations.of(context)!.armenian: "Armenian",
      AppLocalizations.of(context)!.azerbaijani: "Azerbaijani",
      AppLocalizations.of(context)!.basque: "Basque",
      AppLocalizations.of(context)!.belarusian: "Belarusian",
      AppLocalizations.of(context)!.bengali: "Bengali",
      AppLocalizations.of(context)!.bosnian: "Bosnian",
      AppLocalizations.of(context)!.bulgarian: "Bulgarian",
      AppLocalizations.of(context)!.catalan: "Catalan",
      AppLocalizations.of(context)!.cebuano: "Cebuano",
      AppLocalizations.of(context)!.chichewa: "Chichewa",
      AppLocalizations.of(context)!.chinese: "Chinese",
      AppLocalizations.of(context)!.corsican: "Corsican",
      AppLocalizations.of(context)!.croatian: "Croatian",
      AppLocalizations.of(context)!.czech: "Czech",
      AppLocalizations.of(context)!.danish: "Danish",
      AppLocalizations.of(context)!.dutch: "Dutch",
      AppLocalizations.of(context)!.english: "English",
      AppLocalizations.of(context)!.esperanto: "Esperanto",
      AppLocalizations.of(context)!.estonian: "Estonian",
      AppLocalizations.of(context)!.filipino: "Filipino",
      AppLocalizations.of(context)!.finnish: "Finnish",
      AppLocalizations.of(context)!.french: "French",
      AppLocalizations.of(context)!.frisian: "Frisian",
      AppLocalizations.of(context)!.galician: "Galician",
      AppLocalizations.of(context)!.georgian: "Georgian",
      AppLocalizations.of(context)!.german: "German",
      AppLocalizations.of(context)!.greek: "Greek",
      AppLocalizations.of(context)!.gujarati: "Gujarati",
      AppLocalizations.of(context)!.haitian_creole: "Haitian_creole",
      AppLocalizations.of(context)!.hausa: "Hausa",
      AppLocalizations.of(context)!.hawaiian: "Hawaiian",
      AppLocalizations.of(context)!.hebrew: "Hebrew",
      AppLocalizations.of(context)!.hindi: "Hindi",
      AppLocalizations.of(context)!.hmong: "Hmong",
      AppLocalizations.of(context)!.hungarian: "Hungarian",
      AppLocalizations.of(context)!.icelandic: "Icelandic",
      AppLocalizations.of(context)!.igbo: "Igbo",
      AppLocalizations.of(context)!.indonesian: "Indonesian",
      AppLocalizations.of(context)!.irish: "Irish",
      AppLocalizations.of(context)!.italian: "Italian",
      AppLocalizations.of(context)!.japanese: "Japanese",
      AppLocalizations.of(context)!.javanese: "Javanese",
      AppLocalizations.of(context)!.kannada: "Kannada",
      AppLocalizations.of(context)!.kazakh: "Kazakh",
      AppLocalizations.of(context)!.khmer: "Khmer",
      AppLocalizations.of(context)!.kinyarwanda: "Kinyarwanda",
      AppLocalizations.of(context)!.korean: "Korean",
      AppLocalizations.of(context)!.kurdish_kurmanji: "Kurdish_kurmanji",
      AppLocalizations.of(context)!.kyrgyz: "Kyrgyz",
      AppLocalizations.of(context)!.lao: "Lao",
      AppLocalizations.of(context)!.latin: "Latin",
      AppLocalizations.of(context)!.latvian: "Latvian",
      AppLocalizations.of(context)!.lithuanian: "Lithuanian",
      AppLocalizations.of(context)!.luxembourgish: "Luxembourgish",
      AppLocalizations.of(context)!.macedonian: "Macedonian",
      AppLocalizations.of(context)!.malagasy: "Malagasy",
      AppLocalizations.of(context)!.malay: "Malay",
      AppLocalizations.of(context)!.malayalam: "Malayalam",
      AppLocalizations.of(context)!.maltese: "Maltese",
      AppLocalizations.of(context)!.maori: "Maori",
      AppLocalizations.of(context)!.marathi: "Marathi",
      AppLocalizations.of(context)!.mongolian: "Mongolian",
      AppLocalizations.of(context)!.myanmar_burmese: "Myanmar_burmese",
      AppLocalizations.of(context)!.nepali: "Nepali",
      AppLocalizations.of(context)!.norwegian: "Norwegian",
      AppLocalizations.of(context)!.odia_oriya: "Odia_oriya",
      AppLocalizations.of(context)!.pashto: "Pashto",
      AppLocalizations.of(context)!.persian: "Persian",
      AppLocalizations.of(context)!.polish: "Polish",
      AppLocalizations.of(context)!.portuguese: "Portuguese",
      AppLocalizations.of(context)!.punjabi: "Punjabi",
      AppLocalizations.of(context)!.romanian: "Romanian",
      AppLocalizations.of(context)!.russian: "Russian",
      AppLocalizations.of(context)!.samoan: "Samoan",
      AppLocalizations.of(context)!.scots_gaelic: "Scots_gaelic",
      AppLocalizations.of(context)!.serbian: "Serbian",
      AppLocalizations.of(context)!.sesotho: "Sesotho",
      AppLocalizations.of(context)!.shona: "Shona",
      AppLocalizations.of(context)!.sindhi: "Sindhi",
      AppLocalizations.of(context)!.sinhala: "Sinhala",
      AppLocalizations.of(context)!.slovak: "Slovak",
      AppLocalizations.of(context)!.slovenian: "Slovenian",
      AppLocalizations.of(context)!.somali: "Somali",
      AppLocalizations.of(context)!.spanish: "Spanish",
      AppLocalizations.of(context)!.sundanese: "Sundanese",
      AppLocalizations.of(context)!.swahili: "Swahili",
      AppLocalizations.of(context)!.swedish: "Swedish",
      AppLocalizations.of(context)!.tajik: "Tajik",
      AppLocalizations.of(context)!.tamil: "Tamil",
      AppLocalizations.of(context)!.tatar: "Tatar",
      AppLocalizations.of(context)!.telugu: "Telugu",
      AppLocalizations.of(context)!.thai: "Thai",
      AppLocalizations.of(context)!.turkish: "Turkish",
      AppLocalizations.of(context)!.turkmen: "Turkmen",
      AppLocalizations.of(context)!.ukrainian: "Ukrainian",
      AppLocalizations.of(context)!.urdu: "Urdu",
      AppLocalizations.of(context)!.uyghur: "Uyghur",
      AppLocalizations.of(context)!.uzbek: "Uzbek",
      AppLocalizations.of(context)!.vietnamese: "Vietnamese",
      AppLocalizations.of(context)!.welsh: "Welsh",
      AppLocalizations.of(context)!.xhosa: "Xhosa",
      AppLocalizations.of(context)!.yiddish: "Yiddish",
      AppLocalizations.of(context)!.yoruba: "Yoruba",
      AppLocalizations.of(context)!.zulu: "Zulu",
    };
    selectLanguages = [];
    selectLanguagesMap.keys.forEach((element) => selectLanguages.add(element));
    selectLanguages.sort();
    return MainPage();
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

bool fromLanguageisDefault = true;
bool toLanguageisDefault = true;

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

  languageOptionsViewBuilder() => (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width / 3 + 7,
              height: MediaQuery.of(context).size.height / 2 <=
                      (options.length) * (36 + 25) + 25
                  ? MediaQuery.of(context).size.height / 2
                  : (options.length) * (36 + 25) + 25,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: greyColor,
                boxShadow: [
                  BoxShadow(offset: Offset(0, 0), blurRadius: 5),
                ],
              ),
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Container(
                      height: 25,
                      margin:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 36),
                      child: Text(option, style: const TextStyle(fontSize: 20)),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      };

  Widget fromLangWidget() => Container(
      width: MediaQuery.of(context).size.width / 3 + 10,
      decoration: boxDecorationCustom,
      child: () {
        return Autocomplete<String>(
          onSelected: (String selectedLanguage) {
            session.write('from_language', selectedLanguage);
            setState(() => fromLanguage = selectedLanguage);
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            List selectLanguagesFrom = ['Autodetect', ...selectLanguages];
            Iterable<String> selectLanguagesIterable =
                Iterable.generate(selectLanguagesFrom.length, (i) {
              return selectLanguagesFrom[i];
            });
            return selectLanguagesIterable
                .where((word) => word
                    .toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase()))
                .toList();
          },
          optionsViewBuilder: languageOptionsViewBuilder(),
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            if (fromLanguageisDefault) {
              fieldTextEditingController.text = fromLanguage;
              fromLanguageisDefault = false;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                onTap: () {
                  fieldTextEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: fieldTextEditingController.text.length,
                  );
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  var chosenOne = selectLanguages.firstWhere((word) => word
                      .toLowerCase()
                      .startsWith(
                          fieldTextEditingController.text.toLowerCase()));

                  session.write('from_language', chosenOne);
                  setState(() => {fromLanguage = chosenOne});
                  fieldTextEditingController.text = chosenOne;
                },
                decoration: InputDecoration(border: InputBorder.none),
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: const TextStyle(fontSize: 20),
              ),
            );
          },
        );
      }());

  Widget toLangWidget() => Container(
        width: MediaQuery.of(context).size.width / 3 + 10,
        decoration: boxDecorationCustom,
        child: Autocomplete(
          onSelected: (String selectedLanguage) {
            session.write('to_language', selectedLanguage);
            setState(() => {toLanguage = selectedLanguage});
          },
          optionsBuilder: (TextEditingValue textEditingValue) {
            Iterable<String> selectLanguagesIterable =
                Iterable.generate(selectLanguages.length, (i) {
              return selectLanguages[i];
            });
            return selectLanguagesIterable
                .where((word) => word
                    .toLowerCase()
                    .startsWith(textEditingValue.text.toLowerCase()))
                .toList();
          },
          optionsViewBuilder: languageOptionsViewBuilder(),
          fieldViewBuilder: (
            BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted,
          ) {
            if (toLanguageisDefault) {
              fieldTextEditingController.text = toLanguage;
              toLanguageisDefault = false;
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                onTap: () {
                  fieldTextEditingController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: fieldTextEditingController.text.length,
                  );
                },
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  var chosenOne = selectLanguages.firstWhere((word) => word
                      .toLowerCase()
                      .startsWith(
                          fieldTextEditingController.text.toLowerCase()));

                  session.write('to_language', chosenOne);
                  setState(() => {toLanguage = chosenOne});
                  fieldTextEditingController.text = chosenOne;
                },
                decoration: InputDecoration(border: InputBorder.none),
                controller: fieldTextEditingController,
                focusNode: fieldFocusNode,
                style: const TextStyle(fontSize: 20),
              ),
            );
          },
        ),
      );

  Widget switchLangBtnWidget() => Container(
        width: MediaQuery.of(context).size.width / 3 - 60,
        decoration: boxDecorationCustom,
        child: TextButton(
          onPressed: () async {
            if (fromLanguage != 'Autodetect') {
              FocusScope.of(context).unfocus();
              loading = true;
              final tmp = fromLanguage;
              fromLanguage = toLanguage;
              toLanguage = tmp;
              fromLanguageisDefault = true;
              toLanguageisDefault = true;
              translationInputController.text = translationOutput;
              final x = await translate(translationInput);
              setState(() {
                loading = false;
                translationOutput = x;
              });
            }
          },
          child: const Text('<->'),
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
