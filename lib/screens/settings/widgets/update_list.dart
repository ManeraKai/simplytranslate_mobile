import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import 'package:simplytranslate_mobile/screens/settings/widgets/settings_button.dart';
import '/data.dart';

var isCustomInstanceValid = instanceValidation.NotChecked;

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
                AppLocalizations.of(context)!.updated_successfully,
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
                AppLocalizations.of(context)!.error,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
      },
      icon: Icons.download,
      iconColor: greenColor,
      title: AppLocalizations.of(context)!.update_list,
      content: AppLocalizations.of(context)!.update_list_summary,
      loading: loading,
    );
  }
}
