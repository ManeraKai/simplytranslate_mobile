import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';
import '/google/widgets/translate_button/cancel_translation_button.dart';
import '/widgets/keyboard_visibility.dart';
import 'widgets/translate_button/translate_button_float.dart';
import 'widgets/translate_button/translate_button.dart';
import 'widgets/translation_input/translation_input.dart';
import 'widgets/translation_output/translation_output.dart';
import 'widgets/lang_selector/from_lang.dart';
import 'widgets/lang_selector/to_lang.dart';
import 'widgets/lang_selector/switch_lang.dart';

class GoogleTranslate extends StatefulWidget {
  final setStateParent;
  const GoogleTranslate({
    required this.setStateParent,
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleTranslate> createState() => _GoogleTranslateState();
}

class _GoogleTranslateState extends State<GoogleTranslate> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GoogleFromLang(setStateOverlord: widget.setStateParent),
                      GoogleSwitchLang(
                        setStateParent: widget.setStateParent,
                      ),
                      GoogleToLang(
                        setStateOverlord: widget.setStateParent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GoogleTranslationInput(
                    setStateParent: widget.setStateParent,
                  ),
                  const SizedBox(height: 10),
                  GoogleTranslationOutput(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                                ? GoogleCancelTranslationButton(
                                    setStateParent: widget.setStateParent)
                                : !isKeyboardVisible
                                    ? GoogleTranslateButton(
                                        setStateParent: widget.setStateParent,
                                        contextParent: context,
                                      )
                                    : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        KeyboardVisibilityBuilder(
          builder: (context, child, isKeyboardVisible) => isKeyboardVisible
              ? Positioned(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  right: intl.Bidi.detectRtlDirectionality(
                    AppLocalizations.of(context)!.arabic,
                  )
                      ? null
                      : 0,
                  left: intl.Bidi.detectRtlDirectionality(
                    AppLocalizations.of(context)!.arabic,
                  )
                      ? 0
                      : null,
                  child: TranslateButtonFloat(
                    setStateParent: widget.setStateParent,
                    contextParent: context,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
