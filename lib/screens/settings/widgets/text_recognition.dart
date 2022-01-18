import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/screens/settings/screens/text_recognition_screen.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/settings_button.dart';

class TextRecognition extends StatelessWidget {
  const TextRecognition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => TextRecognitionScreen()),
        );
      },
      icon: Icons.text_fields,
      iconColor: Colors.yellow[800]!,
      title: L10n.of(context).text_recognition,
      content: L10n.of(context).download_trained_data_files,
    );
  }
}
