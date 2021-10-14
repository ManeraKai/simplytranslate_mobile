import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/widgets/keyboard_visibility.dart';
import '/data.dart';
import '/google/widgets/translate_button/cancel_translation_button.dart';
import 'widgets/translate_button/translate_button.dart';
import 'widgets/translation_input/translation_input.dart';
import 'widgets/translation_output/translation_output.dart';
import 'widgets/lang_selector/from_lang.dart';
import 'widgets/lang_selector/to_lang.dart';
import 'widgets/lang_selector/switch_lang.dart';

class GoogleTranslate extends StatefulWidget {
  const GoogleTranslate({Key? key}) : super(key: key);

  @override
  State<GoogleTranslate> createState() => _GoogleTranslateState();
}

class _GoogleTranslateState extends State<GoogleTranslate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GoogleFromLang(),
                GoogleSwitchLang(),
                GoogleToLang(),
              ],
            ),
            const SizedBox(height: 10),
            GoogleTranslationInput(),
            const SizedBox(height: 10),
            GoogleTranslationOutput(),
            const SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      KeyboardVisibilityBuilder(
                        builder: (context, child, isKeyboardVisible) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            loading
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width - 20,
                                    child: LinearProgressIndicator(),
                                  )
                                : const SizedBox.shrink(),
                            loading
                                ? GoogleCancelTranslationButton()
                                : !isKeyboardVisible
                                    ? GoogleTranslateButton()
                                    : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
