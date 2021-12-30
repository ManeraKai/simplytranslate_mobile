import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';

import '/data.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({
    required this.image,
    required this.contourVals,
    required this.croppedImgs,
    required this.textList,
    Key? key,
  }) : super(key: key);
  final File image;
  final List<Map<String, int>> contourVals;
  final List<File> croppedImgs;
  final List<String> textList;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

var pos = Offset(0, 0);
List<int> highlightedList = [];
late Function(void Function()) highlightSetState;

var imageHeight = 0.0;
List<Offset> drawList = [];

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    var image;
    List<Map<String, int>> cnts = widget.contourVals;
    double screenWidth = MediaQuery.of(context).size.width;
    var dilate = 0.0;
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: () async {
              image = await prepareOCR(widget.image);
              var decodedImage =
                  await decodeImageFromList(image.readAsBytesSync());
              dilate = screenWidth / decodedImage.width;
              imageHeight = decodedImage.height * dilate;
              return;
            }(),
            builder: (context, state) {
              if (state.connectionState == ConnectionState.done) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    pos = details.localPosition;
                    drawList.add(pos);
                    highlightSetState(() {});
                  },
                  onPanEnd: (details) async {
                    List<String> newList = [];
                    highlightedList.sort();
                    highlightedList = highlightedList.reversed.toList();
                    for (var i in highlightedList)
                      newList.add(widget.textList[i]);
                    newText = newList.join(" ");

                    if (newText.trim() != "") {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(newText),
                                  ...highlightedList
                                      .map((e) =>
                                          Image.file(widget.croppedImgs[e]))
                                      .toList()
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(AppLocalizations.of(context)!.cancel),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                setStateOverlord(
                                    () => googleInCtrl.text = newText);
                              },
                              child: Text(AppLocalizations.of(context)!.ok),
                            )
                          ],
                        ),
                      );
                    }
                    highlightSetState(() {
                      highlightedList = [];
                      drawList = [];
                      pos = Offset.zero;
                    });
                  },
                  child: StatefulBuilder(
                    builder: (context, localSetState) {
                      highlightSetState = localSetState;
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image.file(
                                image,
                                width: screenWidth,
                              ),
                            ),
                            Container(
                              width: screenWidth,
                              height: imageHeight,
                              child: CustomPaint(painter: OpenPainter()),
                            ),
                            Positioned(
                              left: pos.dx - 25,
                              top: pos.dy - 25,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                width: 25,
                                height: 25,
                              ),
                            ),
                            ...() {
                              List<Widget> boxes = [];
                              for (var i = 0; i < cnts.length; i++) {
                                var x = cnts[i]["x"]!.toDouble() * dilate;
                                var y = cnts[i]["y"]!.toDouble() * dilate;
                                var width =
                                    cnts[i]["width"]!.toDouble() * dilate;
                                var height =
                                    cnts[i]["height"]!.toDouble() * dilate;

                                var color = () {
                                  if (highlightedList.contains(i))
                                    return Colors.blue;
                                  if ((x < pos.dx && pos.dx < x + width) &&
                                      (y < pos.dy && pos.dy < y + height)) {
                                    highlightedList.add(i);
                                    return Colors.blue;
                                  }
                                  return Colors.green;
                                }();

                                boxes.add(
                                  Positioned(
                                    left: x,
                                    top: y,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: color,
                                          width: 2,
                                        ),
                                      ),
                                      width: width,
                                      height: height,
                                    ),
                                  ),
                                );
                              }
                              return boxes;
                            }(),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xFF0000ff)
      ..style = PaintingStyle.fill;
    drawList.forEach((posy) =>
        canvas.drawCircle(posy - Offset(25 / 2, 25 / 2), 25 / 2, paint1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
