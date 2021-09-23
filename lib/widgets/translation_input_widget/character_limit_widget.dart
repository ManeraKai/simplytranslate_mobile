import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data.dart';
import '../keyboard_visibility_widget.dart';

class CharacterLimit extends StatelessWidget {
  const CharacterLimit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: KeyboardVisibilityBuilder(
        builder: (context, child, isKeyboardVisible) => Container(
          width: 48,
          alignment:
              isKeyboardVisible ? Alignment.topCenter : Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: Column(
            children: [
              Text(
                '$translationLength',
                style: TextStyle(
                    color: translationLength <= 5000
                        ? theme == Brightness.dark
                            ? Colors.white
                            : lightThemeGreyColor
                        : Colors.red),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  height: 1,
                  width: 30,
                  color: translationLength <= 5000
                      ? theme == Brightness.dark
                          ? Colors.white
                          : lightThemeGreyColor
                      : Colors.red),
              Text(
                '5000',
                style: TextStyle(
                    color: translationLength <= 5000
                        ? theme == Brightness.dark
                            ? Colors.white
                            : lightThemeGreyColor
                        : Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
