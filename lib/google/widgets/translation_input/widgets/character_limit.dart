import 'package:flutter/material.dart';
import '/data.dart';

bool _isSnackBarVisible = false;

class CharacterLimit extends StatelessWidget {
  const CharacterLimit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 48,
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
        child: InkWell(
          onTap: () {
            if (!_isSnackBarVisible) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  width: 300,
                  content: Text(
                    googleTranslationInputController.text.length > 5000
                        ? 'Exceeded 5000 character limit by ${googleTranslationInputController.text.length - 5000}'
                        : 'Entered ${googleTranslationInputController.text.length} characters out of 5000 possible',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
              _isSnackBarVisible = true;
              Future.delayed(Duration(seconds: 1))
                  .then((value) => _isSnackBarVisible = false);
            }
          },
          child: Column(
            children: [
              Text(
                googleTranslationInputController.text.length.toString(),
                style: TextStyle(
                  color: googleTranslationInputController.text.length > 5000
                      ? Colors.red
                      : theme == Brightness.dark
                          ? Colors.white
                          : lightThemeGreyColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                height: 1,
                width: 30,
                color: googleTranslationInputController.text.length > 5000
                    ? Colors.red
                    : theme == Brightness.dark
                        ? Colors.white
                        : lightThemeGreyColor,
              ),
              Text(
                '5000',
                style: TextStyle(
                    color: googleTranslationInputController.text.length > 5000
                        ? Colors.red
                        : theme == Brightness.dark
                            ? Colors.white
                            : lightThemeGreyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
