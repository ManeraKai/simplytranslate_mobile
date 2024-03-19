import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/data.dart';

class AboutButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? content;
  final void Function() onTap;

  const AboutButton({
    required this.icon,
    required this.title,
    this.content,
    required this.onTap,
    required this.iconColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 45),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width - 95,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18)),
                    if (content != null)
                      Text(
                        content!,
                        style: TextStyle(
                          fontSize: 18,
                          color: theme == Brightness.dark ? Colors.white54 : Colors.black54,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
