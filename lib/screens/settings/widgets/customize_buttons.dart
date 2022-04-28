import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/data.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/screens/settings/screens/customize_buttons_screen.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/settings_button.dart';

class CustomizeButtons extends StatelessWidget {
  const CustomizeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => CustomizeButtonsScreen()),
      ).then((_) => setStateOverlord(() {})),
      icon: Icons.edit,
      iconColor: Colors.green,
      title: L10n.of(context).customize_buttons,
    );
  }
}
