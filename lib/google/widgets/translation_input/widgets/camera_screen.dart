import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';

import '/data.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({
    required this.image,
    required this.contourVals,
    Key? key,
  }) : super(key: key);
  final File image;
  final List<Map<String, int>> contourVals;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

Offset position = Offset(0, 0);

List<int> highlightedList = [];

late Function(void Function()) highlightSetState;

double imageHeight = 0;
List<Offset> drawList = [];

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, int>> cnts = widget.contourVals;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Camera")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: () async {
              var decodedImage =
                  await decodeImageFromList(widget.image.readAsBytesSync());
              imageHeight =
                  decodedImage.height * (screenWidth / decodedImage.width);
              return screenWidth / decodedImage.width;
            }(),
            builder: (context, state) {
              if (state.connectionState == ConnectionState.done) {
                double dilate = double.parse(state.data.toString());
                return GestureDetector(
                  onPanUpdate: (details) {
                    position = details.localPosition;
                    drawList.add(position);
                    highlightSetState(() {});
                  },
                  onPanEnd: (details) async {
                    List<String> newList = [];
                    highlightedList.sort();
                    highlightedList = highlightedList.reversed.toList();
                    for (var i in highlightedList) newList.add(textList[i - 1]);
                    newText = newList.join(" ");
                    highlightedList = [];
                    if (newText.trim() != "") {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(newText),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
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
                      position = Offset.zero;
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
                                widget.image,
                                width: screenWidth,
                              ),
                            ),
                            Container(
                              width: screenWidth,
                              height: imageHeight,
                              child: CustomPaint(
                                painter: OpenPainter(),
                              ),
                            ),
                            Positioned(
                              left: position.dx - 25,
                              top: position.dy - 25,
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
                              List<Widget> myList = [];
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
                                  if ((x < position.dx &&
                                          position.dx < x + width) &&
                                      (y < position.dy &&
                                          position.dy < y + height)) {
                                    highlightedList.add(i);
                                    return Colors.blue;
                                  }
                                  return Colors.green;
                                }();

                                myList.add(
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
                              return myList;
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
    drawList.forEach((pos) {
      canvas.drawCircle(pos - Offset(25 / 2, 25 / 2), 25 / 2, paint1);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
