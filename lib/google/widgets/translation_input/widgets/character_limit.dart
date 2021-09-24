import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import '../../../../../widgets/keyboard_visibility.dart';
import '/data.dart';

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
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                googleTranslationInputController.text.length >= 10000
                    ? '9999'
                    : googleTranslationInputController.text.length.toString(),
                style: TextStyle(
                    color: googleTranslationInputController.text.length <= 5000
                        ? theme == Brightness.dark
                            ? Colors.white
                            : lightThemeGreyColor
                        : Colors.red),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 3),
                  height: 1,
                  width: 30,
                  color: googleTranslationInputController.text.length <= 5000
                      ? theme == Brightness.dark
                          ? Colors.white
                          : lightThemeGreyColor
                      : Colors.red),
              Text(
                '5000',
                style: TextStyle(
                    color: googleTranslationInputController.text.length <= 5000
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
