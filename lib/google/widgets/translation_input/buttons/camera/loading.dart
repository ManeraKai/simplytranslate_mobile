import 'package:flutter/material.dart';
import 'data.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    checkWidth(context);
    return Scaffold(
      appBar: globalAppBar,
      body: Container(
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
            Container(color: Colors.black.withAlpha(180)),
            Center(
              child: Container(
                width: 300,
                child: LinearProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
