import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';

class CustomizeButtonsScreen extends StatefulWidget {
  const CustomizeButtonsScreen({Key? key}) : super(key: key);

  @override
  _CustomizeButtonsScreenState createState() => _CustomizeButtonsScreenState();
}

Map<String, IconData> icons = {
  "remove": Icons.close,
  "copy": Icons.copy,
  "camera": Icons.camera_alt,
  "paste": Icons.paste,
  "text-to-speech": Icons.volume_up,
  "maximize": Icons.fullscreen,
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
              List<Widget> inListWidgets = [];
              for (var k in inList.keys)
                inListWidgets.add(
                  CheckboxListTile(
                    value: inList[k],
                    onChanged: (v) => setState(() => inList[k] = v!),
                    title: Row(
                      children: [
                        if (icons[k] != null) Icon(icons[k]),
                        SizedBox(width: 10),
                        Text(k),
                      ],
                    ),
                  ),
                );
              List<Widget> outListWidgets = [];
              for (var k in outList.keys)
                outListWidgets.add(
                  CheckboxListTile(
                    value: outList[k],
                    onChanged: (v) => setState(() => outList[k] = v!),
                    title: Row(
                      children: [
                        if (icons[k] != null) Icon(icons[k]),
                        SizedBox(width: 10),
                        Text(k),
                      ],
                    ),
                  ),
                );
              return [
                Text("Input", style: textStyle),
                line,
                ...inListWidgets,
                Text("Output", style: textStyle),
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
