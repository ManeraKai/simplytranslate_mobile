import 'package:flutter/material.dart';

import '/data.dart';

class TextRecognitionScreen extends StatefulWidget {
  const TextRecognitionScreen({Key? key}) : super(key: key);

  @override
  _TextRecognitionScreenState createState() => _TextRecognitionScreenState();
}

Map<String, bool> downloadingList = {};

class _TextRecognitionScreenState extends State<TextRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Text Recognition")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: () {
              List<Widget> myList = [];
              myList.add(
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 95,
                                child: Text("Install All",
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                            Container(
                              child: downloadingList["install"] ?? false
                                  ? Container(
                                      height: 45,
                                      width: 45,
                                      padding: const EdgeInsets.all(5),
                                      child: const CircularProgressIndicator(),
                                    )
                                  : Icon(
                                      downloadedList.contains("install")
                                          ? Icons.check
                                          : Icons.download,
                                      color: greenColor,
                                      size: 45),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: downloadedList.contains("install")
                      ? null
                      : () async {
                          downloadedList.add("install");
                          setStateOverlord(
                              () => downloadingList["install"] = true);
                          for (var key in two2three.keys) {
                            downloadedList.add(key);
                            setStateOverlord(() => downloadingList[key] = true);
                            final result =
                                await downloadOCRLanguage(two2three[key]);
                            if (result)
                              setStateOverlord(
                                  () => downloadingList[key] = false);
                          }
                          setStateOverlord(
                              () => downloadingList["install"] = false);
                          print(downloadedList);
                        },
                ),
              );
              toSelLangMap.forEach((key, value) {
                myList.add(
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 95,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                child: downloadingList[key] ?? false
                                    ? Container(
                                        height: 45,
                                        width: 45,
                                        padding: const EdgeInsets.all(5),
                                        child:
                                            const CircularProgressIndicator(),
                                      )
                                    : Icon(
                                        downloadedList.contains(key)
                                            ? Icons.check
                                            : Icons.download,
                                        color: greenColor,
                                        size: 45,
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: downloadedList.contains(key)
                        ? null
                        : () async {
                            downloadedList.add(key);
                            setStateOverlord(() => downloadingList[key] = true);
                            bool result =
                                await downloadOCRLanguage(two2three[key]);
                            if (result)
                              setStateOverlord(
                                  () => downloadingList[key] = false);
                          },
                  ),
                );
              });
              return myList;
            }(),
          ),
        ),
      ),
    );
  }
}
