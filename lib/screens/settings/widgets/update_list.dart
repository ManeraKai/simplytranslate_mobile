import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import '../../../data.dart';

var isCustomInstanceValid = customInstanceValidation.NotChecked;

var loading = false;
bool checkLoading = false;
bool isCanceled = false;

Future<customInstanceValidation> checkInstance(
    Function setState, String urlValue) async {
  setState(() => checkLoading = true);
  var url;
  try {
    url = Uri.parse(urlValue);
  } catch (_) {}
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      if ((parse(response.body).getElementsByTagName('h2')[0].innerHtml ==
          'SimplyTranslate')) {
        session.write('url', customInstance);
        if (!isCanceled) {
          setState(() => isCustomInstanceValid = customInstanceValidation.True);
        }
      } else {
        if (!isCanceled) {
          setState(
              () => isCustomInstanceValid = customInstanceValidation.False);
        }
      }
    } else {
      if (!isCanceled) {
        setState(() => isCustomInstanceValid = customInstanceValidation.False);
      }
    }
  } catch (err) {
    if (!isCanceled) {
      setState(() => isCustomInstanceValid = customInstanceValidation.False);
    }
  }
  setState(() => checkLoading = false);
  return isCustomInstanceValid;
}

class UpdateList extends StatelessWidget {
  const UpdateList({
    required this.setStateOverlord,
    Key? key,
  }) : super(key: key);

  final setStateOverlord;

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
        await checkInstance(setStateOverlord, instances[instanceIndex]);
        if (!isCanceled) {
          if (isCustomInstanceValid == customInstanceValidation.True)
            isCanceled = false;
        }
        setStateOverlord(() => loading = false);
      },
    );
  }
}
