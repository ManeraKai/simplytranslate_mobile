import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:simplytranslate_mobile/google/widgets/translation_input/buttons/camera/data.dart';
import '/data.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
bool cameraMode = true;
List<FlashMode> modes = [FlashMode.off, FlashMode.torch];
var currentMode = modes[0];

// Remove this once we roll stable in late 2021.
T? _ambiguate<T>(T? value) => value;

class ViewFinder extends StatefulWidget {
  const ViewFinder({Key? key}) : super(key: key);

  @override
  State<ViewFinder> createState() => _ViewFinderState();
}

CameraController? controller;

class _ViewFinderState extends State<ViewFinder>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late AnimationController _flashModeControlRowAnimationController;

  @override
  void initState() {
    super.initState();
    onNewCameraSelected();
    _ambiguate(WidgetsBinding.instance)?.addObserver(this);

    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    _flashModeControlRowAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.isInitialized) return;

    if (state == AppLifecycleState.inactive) controller!.dispose();
    else if (state == AppLifecycleState.resumed) onNewCameraSelected();
  }

  @override
  Widget build(BuildContext context) {
    IconData flashIcon = () {
      switch (currentMode) {
        case FlashMode.off:
          return Icons.flash_off;
        case FlashMode.torch:
          return Icons.flash_on;
        default:
          return Icons.flash_off;
      }
    }();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(flashIcon),
            onPressed: controller != null ? onSetFlashModeButtonPressed : null,
          ),
        ],
      ),
      key: scaffoldKey,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.black),
                      child: CameraPreview(
                        controller!,
                        child: LayoutBuilder(
                          builder: (context, constraints) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTapDown: (details) =>
                                onViewFinderTap(details, constraints),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              () {
                var or = MediaQuery.of(context).orientation;
                var sz = MediaQuery.of(context).size;
                return Positioned(
                  bottom: or == Orientation.portrait
                      ? 20
                      : (sz.height / 2) - (60 / 2),
                  left: or == Orientation.portrait
                      ? (sz.width / 2) - (60 / 2)
                      : null,
                  right: or == Orientation.landscape ? 20 : null,
                  child: _captureControlRowWidget(),
                );
              }(),
            ],
          );
        },
      ),
    );
  }

  void onNewCameraSelected() async {
    controller = CameraController(
      cameras[0],
      ResolutionPreset.ultraHigh,
      imageFormatGroup: ImageFormatGroup.jpeg,
      enableAudio: false,
    );
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError)
        showInSnackBar('Camera error ${controller!.value.errorDescription}');
    });

    try {
      if (!controller!.value.isInitialized) await controller!.initialize();
    } on CameraException catch (e) {
      showCameraException(e);
    }
    if (mounted) setState(() {});
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) return;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    controller!.setExposurePoint(offset);
    controller!.setFocusPoint(offset);
  }

  Widget _captureControlRowWidget() {
    return FloatingActionButton(
      child: Icon(
        Icons.camera_alt,
        color: theme == Brightness.dark ? Colors.white : Colors.black,
      ),
      onPressed: controller != null && controller!.value.isInitialized
          ? () async {
              if (controller == null ||
                  !controller!.value.isInitialized ||
                  controller!.value.isTakingPicture) return;
              try {
                XFile pickedImageX = await controller!.takePicture();
                currentMode = modes[0];
                await controller!.setFlashMode(currentMode);
                setStateOverlord(() => loading = false);
                img = File(pickedImageX.path);
                setState(() => cameraMode = false);
              } on CameraException catch (e) {
                showCameraException(e);
              }
            }
          : null,
    );
  }

  void onSetFlashModeButtonPressed() async {
    int i = modes.indexOf(currentMode);
    currentMode = modes[(i + 1) % (modes.length)];
    if (controller == null) return;
    try {
      await controller!.setFlashMode(currentMode);
    } on CameraException catch (e) {
      showCameraException(e);
      rethrow;
    }
    if (mounted) setState(() {});
  }

  void showCameraException(CameraException e) {
    print(e);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
