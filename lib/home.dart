import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'data.dart';
import 'screens/about/about_screen.dart';
import 'google/google_translate_widget.dart';
import 'screens/settings/settings_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    getSharedText(
      setStateParent: setState,
      context: context,
    );
    super.initState();
  }

  @override
  void dispose() {
    customUrlController.dispose();
    super.dispose();
  }

  final rowWidth = 430;

  @override
  Widget build(BuildContext context) {
    if (callSharedText) {
      getSharedText(
        setStateParent: setState,
        context: context,
      );
    }
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Container(
              height: 80,
              child: AppBar(
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(2),
                  child: Container(height: 2, color: greenColor),
                ),
                actions: [
                  PopupMenuButton(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'settings',
                        child: Text(AppLocalizations.of(context)!.settings),
                      ),
                      PopupMenuItem<String>(
                        value: 'about',
                        child: Text(AppLocalizations.of(context)!.about),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'settings')
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Settings()),
                        );
                      else if (value == 'about')
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AboutScreen()),
                        );
                    },
                  ),
                ],
                elevation: 3,
                iconTheme: IconThemeData(),
                title: const Text('Simply Translate Mobile'),
              ),
            ),
            Container(child: GoogleTranslate()),
          ],
        ),
      ),
    );
  }
}
