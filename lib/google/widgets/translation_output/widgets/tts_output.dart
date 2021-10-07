import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';

bool listening = false;
bool _isSnackBarPressed = false;

class TtsOutput extends StatefulWidget {
  const TtsOutput({
    Key? key,
  }) : super(key: key);

  @override
  State<TtsOutput> createState() => _TtsOutputState();
}

class _TtsOutputState extends State<TtsOutput> {
  @override
  void initState() {
    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        listening = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onPressed: googleTranslationOutput == ''
          ? listening
              ? () async {
                  final result = await audioPlayer.stop();
                  if (result == 1) {
                    setState(() {
                      listening = false;
                    });
                  } else {
                    print('something is wrong');
                  }
                }
              : null
          : !listening
              ? googleTranslationInputController.text.length > 200
                  ? () {
                      if (!_isSnackBarPressed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            width: 300,
                            content: Text(
                              AppLocalizations.of(context)!.audio_limit,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                        _isSnackBarPressed = true;
                        Future.delayed(Duration(seconds: 1))
                            .then((_) => _isSnackBarPressed = false);
                      }
                    }
                  : () async {
                      final result = await audioPlayer
                          .play(
                              'https://simplytranslate.org/api/tts/?engine=google&lang=$toLanguageValue&text=$googleTranslationOutput')
                          .whenComplete(() => null);
                      if (result == 1) {
                        setState(() {
                          listening = true;
                        });
                      }
                    }
              : () async {
                  final result = await audioPlayer.stop();
                  if (result == 1) {
                    setState(() {
                      listening = false;
                    });
                  } else {
                    print('something is wrong');
                  }
                },
      icon: Icon(
        listening ? Icons.stop : Icons.volume_up,
        color: googleTranslationInputController.text.length > 200 && !listening
            ? Colors.grey
            : null,
      ),
    );
  }
}
