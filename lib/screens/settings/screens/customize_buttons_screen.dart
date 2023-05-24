import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';

class CustomizeButtonsScreen extends StatefulWidget {
  const CustomizeButtonsScreen({Key? key}) : super(key: key);

  @override
  _CustomizeButtonsScreenState createState() => _CustomizeButtonsScreenState();
}

Map<String, IconData> icons = {
  "Remove": Icons.close,
  "Copy": Icons.copy,
  "Paste": Icons.paste,
  "Text-To-Speech": Icons.volume_up,
  "Maximize": Icons.fullscreen,
};

class _CustomizeButtonsScreenState extends State<CustomizeButtonsScreen> {
  @override
  Widget build(BuildContext context) {
    const textStyle = const TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(title: Text("Customize Buttons")),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: () {
              var outListTranslation = getOutListTranslation(context);
              var inListTranslation = getInListTranslation(context);
              List<Widget> inListWidgets = [];
              for (var k in inList.keys)
                inListWidgets.add(
                  CheckboxListTile(
                    value: inList[k],
                    onChanged: (v) {
                      setState(() {
                        inList[k] = v!;
                        session.write('inListWidgets', inList);
                      });
                    },
                    title: Row(
                      children: [
                        if (k == 'Counter')
                          Image.asset(
                            theme == Brightness.dark
                                ? "assets/settings/counter-dark.png"
                                : "assets/settings/counter-light.png",
                            scale: 2,
                          ),
                        if (icons[k] != null) Icon(icons[k]),
                        SizedBox(width: 10),
                        Text(inListTranslation[k]!),
                      ],
                    ),
                  ),
                );
              List<Widget> outListWidgets = [];
              for (var k in outList.keys)
                outListWidgets.add(
                  CheckboxListTile(
                    value: outList[k],
                    onChanged: (v) {
                      setState(() {
                        outList[k] = v!;
                        session.write('outListWidgets', outList);
                      });
                    },
                    title: Row(
                      children: [
                        if (icons[k] != null) Icon(icons[k]),
                        SizedBox(width: 10),
                        Text(outListTranslation[k]!),
                      ],
                    ),
                  ),
                );
              return [
                const SizedBox(height: 10),
                Text(L10n.of(context).input, style: textStyle),
                line,
                ...inListWidgets,
                Text(L10n.of(context).output, style: textStyle),
                line,
                ...outListWidgets,
              ];
            }(),
          ),
        ),
      ),
    );
  }
}
