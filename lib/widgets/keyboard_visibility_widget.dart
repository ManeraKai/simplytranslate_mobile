/// Calls `builder` on keyboard close/open.
/// https://stackoverflow.com/a/63241409/1321917
import 'package:flutter/material.dart';

class KeyboardVisibilityBuilder extends StatefulWidget {
  final Widget? child;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  const KeyboardVisibilityBuilder({
    Key? key,
    this.child,
    required this.builder,
  }) : super(key: key);

  @override
  _KeyboardVisibilityBuilderState createState() =>
      _KeyboardVisibilityBuilderState();
}

class _KeyboardVisibilityBuilderState extends State<KeyboardVisibilityBuilder>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance!.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.child,
        _isKeyboardVisible,
      );
}
