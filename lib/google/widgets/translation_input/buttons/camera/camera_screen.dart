// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// Note: This code has been heavily modified.
import 'package:flutter/material.dart';
import 'ocr.dart';
import 'view_finder.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (cameraMode) return true;
        setState(() => cameraMode = true);
        return false;
      },
      child: cameraMode ? ViewFinder() : OCR(),
    );
  }
}
