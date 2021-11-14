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

var _scrollController = ScrollController();

class GoogleTranslate extends StatefulWidget {
  const GoogleTranslate({Key? key}) : super(key: key);

  @override
  State<GoogleTranslate> createState() => _GoogleTranslateState();
}

var _isBefore = false;

class _GoogleTranslateState extends State<GoogleTranslate> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (MediaQuery.of(context).orientation == Orientation.landscape)
      _isBefore = true;
    else if (MediaQuery.of(context).orientation == Orientation.portrait &&
        _isBefore) {
      _scrollController.jumpTo(0);
      _isBefore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            padding: const EdgeInsets.all(10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      KeyboardVisibilityBuilder(
                        builder: (context, _, isKeyboardVisible) => Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (loading)
                              Container(
                                width: MediaQuery.of(context).size.width - 20,
                                child: LinearProgressIndicator(),
                              ),
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        KeyboardVisibilityBuilder(
          builder: (context, _, isKeyboardVisible) => isKeyboardVisible
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
                  child: TranslateButtonFloat(),
                )
              : const SizedBox.shrink(),
        )
      ],
    );
  }
}
