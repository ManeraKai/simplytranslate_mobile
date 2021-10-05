import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data.dart';

// Loading widgets don't work.

class SettingsButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String content;
  final void Function() onTap;
  final bool loading;

  const SettingsButton({
    required this.onTap,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.content,
    this.loading = false,
    Key? key,
  }) : super(key: key);

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
                          icon,
                          color: iconColor,
                          size: 45,
                        ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 95,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          content,
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
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
