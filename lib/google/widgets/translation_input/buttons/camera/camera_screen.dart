// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// Note: This code has been heavily modified.
import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/google/widgets/translation_input/buttons/camera/loading.dart';
import 'data.dart';
import 'ocr.dart';
import 'view_finder.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    setStateCamera = setState;
    return WillPopScope(
      onWillPop: () async {
        if (cameraMode == CameraModeStates.ViewFinder) return true;
        setStateCamera(() => cameraMode = CameraModeStates.ViewFinder);
        return false;
      },
      child: () {
        switch (cameraMode) {
          case CameraModeStates.ViewFinder:
            return ViewFinder();
          case CameraModeStates.Loading:
            return Loading();
          case CameraModeStates.OCR:
            return OCR();
        }
      }(),
    );
  }
}
