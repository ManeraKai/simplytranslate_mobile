import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import '../../../data.dart';

var isCustomInstanceValid = customInstanceValidation.NotChecked;

var loading = false;
bool checkLoading = false;
bool isCanceled = false;

class UpdateList extends StatelessWidget {
  const UpdateList({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  final setStateOverlord;

  Future<bool> updateList() async {
    try {
      final response = await http
          .get(Uri.parse('https://simple-web.org/instances/simplytranslate'));
      List<String> newInstances = [];
      parse(response.body)
          .body!
          .innerHtml
          .trim()
          .split('\n')
          .forEach((element) {
        newInstances.add('https://$element');
      });
      session.write('instances', newInstances);
      instances = newInstances;
      return true;
    } catch (error) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: loading
                      ? Container(
                          height: 45,
                          width: 45,
                          padding: EdgeInsets.all(5),
                          child: CircularProgressIndicator())
                      : Icon(
                          Icons.download,
                          color: theme == Brightness.dark
                              ? Colors.white
                              : greenColor,
                          size: 45,
                        ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Update official list',
                          style: TextStyle(fontSize: 18)),
                      Text(
                        'Update the official list of instances',
                        style: TextStyle(
                          fontSize: 18,
                          color: theme == Brightness.dark
                              ? Colors.white54
                              : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () async {
        setStateOverlord(() => loading = true);
        var response = await updateList();
        setStateOverlord(() => loading = false);
        if (response) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Updated Successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('There was an error')),
          );
        }
      },
    );
  }
}
