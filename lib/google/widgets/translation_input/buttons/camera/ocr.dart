import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';
import 'data.dart';

var pos = Offset(0, 0);
List<int> highlightedList = [];
late Function(void Function()) highlightSetState;

class OCR extends StatelessWidget {
  OCR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkWidth(context);
    return Scaffold(
      appBar: globalAppBar,
      body: Container(
        alignment: Alignment.center,
        height: screenSize.height,
        width: screenSize.width,
        child: GestureDetector(
          onPanUpdate: (details) {
            pos = details.localPosition;
            drawList.add(pos);
            highlightSetState(() {});
          },
          onPanEnd: (details) async {
            List<String> newList = [];
            highlightedList.sort();
            highlightedList = highlightedList.reversed.toList();
            for (var i in highlightedList) newList.add(textList[i]);
            newText = newList.join(" ");
            if (newText.trim() != "") {
              String translatedText = "";
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: FutureBuilder(
                    future: () async {
                      translatedText = await translate(
                        input: newText,
                        fromLang: fromLangVal,
                        toLang: toLangVal,
                        context: context,
                      );
                      return;
                    }(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      else
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                newText,
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(height: 10),
                              line,
                              SizedBox(height: 10),
                              Text(
                                translatedText,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        );
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(L10n.of(context).cancel),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        setStateOverlord(() {
                          googleOutput = translatedText;
                          googleInCtrl.text = newText;
                        });
                      },
                      child: Text(L10n.of(context).ok),
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
          child: DrawBoard(),
        ),
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
    drawList.forEach((posy) => canvas.drawCircle(posy, 7, paint1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DrawBoard extends StatefulWidget {
  const DrawBoard({Key? key}) : super(key: key);

  @override
  _DrawBoardState createState() => _DrawBoardState();
}

class _DrawBoardState extends State<DrawBoard> {
  @override
  Widget build(BuildContext context) {
    print("Hello Weird WOrld!!");
    return StatefulBuilder(
      builder: (context, localSetState) {
        highlightSetState = localSetState;
        return Container(
          color: Colors.red,
          width: imageWidth,
          height: imageHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Image.file(
                  image,
                  width: imageWidth,
                  height: imageHeight,
                ),
              ),
              Container(
                width: imageWidth,
                height: imageHeight,
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
              Positioned(
                left: pos.dx - 7,
                top: pos.dy - 7,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  width: 14,
                  height: 14,
                ),
              ),
              ...() {
                List<Map<String, int>> cnts = filteredContourValsList;
                List<Widget> boxes = [];
                for (var i = 0; i < cnts.length; i++) {
                  var x = cnts[i]["x"]!.toDouble() * dilate;
                  var y = cnts[i]["y"]!.toDouble() * dilate;
                  var width = cnts[i]["width"]!.toDouble() * dilate;
                  var height = cnts[i]["height"]!.toDouble() * dilate;
                  var color = () {
                    if (highlightedList.contains(i)) return Colors.blue;
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
    );
  }
}
