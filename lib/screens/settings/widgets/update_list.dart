import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplytranslate_mobile/generated/l10n.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/settings_button.dart';
import '/data.dart';

var isCustomInstanceValid = InstanceValidation.NotChecked;

var loading = false;
bool checkLoading = false;
bool isCanceled = false;

class UpdateList extends StatelessWidget {
  const UpdateList({Key? key}) : super(key: key);

  Future<bool> updateList() async {
    try {
      final response = await http
          .get(Uri.parse('https://simple-web.org/instances/simplytranslate'));
      List<String> newInstances = [];
      response.body
          .trim()
          .split('\n')
          .forEach((element) => newInstances.add('https://$element'));
      session.write('instances', newInstances);
      instances = newInstances;
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsButton(
      onTap: () async {
        setStateOverlord(() => loading = true);
        var response = await updateList();
        setStateOverlord(() => loading = false);
        if (response) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              width: 160,
              content: Text(
                L10n.of(context).updated_successfully,
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              width: 160,
              content: Text(
                L10n.of(context).error,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
      icon: Icons.download,
      iconColor: greenColor,
      title: L10n.of(context).update_list,
      content: L10n.of(context).update_list_summary,
      loading: loading,
    );
  }
}
