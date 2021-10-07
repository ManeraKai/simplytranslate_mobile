import 'package:flutter/material.dart';
import '/data.dart';

bool listening = false;

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
          ? null
          : !listening
              ? () async {
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
                  }
                },
      icon: Icon(listening ? Icons.stop : Icons.volume_up),
    );
  }
}
