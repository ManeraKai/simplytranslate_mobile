import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';

List<CameraDescription> cameras = [];

late var image;
late var decodedImage;

late void Function(void Function() fn) setStateCamera;

var imageWidth = 0.0;
var imageHeight = 0.0;
List<Offset> drawList = [];

late Size sz;
late Size screenSize;

var dilate = 0.0;

globalAppBar(context) => PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: AppBar(
        title: Text(L10n.current.text_recognition),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(
                    "Select text to translate by drawing on the screen.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(L10n.of(context).ok),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );

late var heightRatio;
late var widthRatio;
List<String> textList = [];
List<File> croppedImgsProcessedList = [];
List<Map<String, int>> filteredContourValsList = [];

checkWidth(context) {
  sz = MediaQuery.of(context).size;
  screenSize = Size(sz.width, sz.height - 50);
  heightRatio = screenSize.height / decodedImage.height;
  widthRatio = screenSize.width / decodedImage.width;
  dilate = () {
    if (decodedImage.height * widthRatio > screenSize.height)
      return heightRatio;
    else
      return widthRatio;
  }();
  imageWidth = decodedImage.width * dilate;
  imageHeight = decodedImage.height * dilate;
}
