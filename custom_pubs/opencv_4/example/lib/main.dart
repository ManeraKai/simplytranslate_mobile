import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:opencv_4/factory/pathfrom.dart';
import 'package:opencv_4/opencv_4.dart';
//uncomment when image_picker is installed
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  List<Uint8List?>? _bytes;
  bool _visible = false;
  final picker = ImagePicker();

  openCV({
    required String pathString,
    required CVPathFrom pathFrom,
    required double thresholdValue,
    required double maxThresholdValue,
    required int thresholdType,
  }) async {
    try {
      //test with threshold
      print("pathString: $pathString");
      var message =
          await Cv2.contour(pathString: pathString, pathFrom: pathFrom);
      setState(() {
        _bytes = message;
        _visible = false;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  _fromAssets() async {
    openCV(
      pathFrom: CVPathFrom.ASSETS,
      pathString: 'assets/Test.JPG',
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );
    setState(() => _visible = true);
  }

  _fromUrl() async {
    openCV(
      pathFrom: CVPathFrom.URL,
      pathString:
          'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/16fe9f114930481.6044f05fca574.jpeg',
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );
    setState(() => _visible = true);
  }

  _fromCamera() async {
    //uncomment when image_picker is installed
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    _bytes = openCV(
      pathFrom: CVPathFrom.GALLERY_CAMERA,
      pathString: _image!.path,
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );

    setState(() => _visible = true);
  }

  _testFromGallery() async {
    //uncomment when image_picker is installed
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    _image = File(pickedFile!.path);
    openCV(
      pathFrom: CVPathFrom.GALLERY_CAMERA,
      pathString: _image!.path,
      thresholdValue: 150,
      maxThresholdValue: 200,
      thresholdType: Cv2.THRESH_BINARY,
    );

    setState(() => _visible = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "OpenCV",
                          style: TextStyle(fontSize: 23),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: _bytes != null
                              ? Column(
                                  children: () {
                                    List<Widget> list = [];
                                    for (var byte in _bytes!) {
                                      list.add(
                                        Image.memory(
                                          byte!,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    }
                                    return list;
                                  }(),
                                )
                              : Container(
                                  width: 300,
                                  height: 300,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                        Visibility(
                            maintainAnimation: true,
                            maintainState: true,
                            visible: _visible,
                            child:
                                Container(child: CircularProgressIndicator())),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test assets'),
                            onPressed: _fromAssets,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test url'),
                            onPressed: _fromUrl,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test gallery'),
                            onPressed: _testFromGallery,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          child: TextButton(
                            child: Text('test camara'),
                            onPressed: _fromCamera,
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              backgroundColor: Colors.teal,
                              onSurface: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
