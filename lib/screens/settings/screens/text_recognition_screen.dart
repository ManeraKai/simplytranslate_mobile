import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.text_recognition),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: () {
              List<Widget> myList = [];
              for (var key in toSelLangMap.keys) {
                if (downloadingList[key] == null) continue;
                var value = toSelLangMap[key]!;
                myList.add(
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 95,
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          () {
                            switch (downloadingList[key]!) {
                              case TrainedDataState.Downloaded:
                                return Icon(
                                  Icons.check,
                                  color: greenColor,
                                  size: 45,
                                );
                              case TrainedDataState.Downloading:
                                return Container(
                                  height: 45,
                                  width: 45,
                                  padding: const EdgeInsets.all(5),
                                  child: const CircularProgressIndicator(),
                                );
                              case TrainedDataState.notDownloaded:
                                return Icon(
                                  Icons.download,
                                  color: greenColor,
                                  size: 45,
                                );
                            }
                          }(),
                        ],
                      ),
                    ),
                    onTap:
                        downloadingList[key] != TrainedDataState.notDownloaded
                            ? null
                            : () => downloadOCRLanguage(key),
                  ),
                );
              }
              return myList;
            }(),
          ),
        ),
      ),
    );
  }
}
