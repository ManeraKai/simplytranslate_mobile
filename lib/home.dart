import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'google/google_translate_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getSharedText();
    super.initState();
  }

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    if (callSharedText) getSharedText();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GoogleTranslate(),
    );
  }
}
