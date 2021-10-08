import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
    audioPlayer.onPlayerCompletion
        .listen((event) => setState(() => listening = false));
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
                  if (result == 1)
                    setState(() => listening = false);
                  else
                    print('something is wrong');
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
                      final _url;
                      if (instance == 'custom')
                        _url = Uri.parse(
                            '$customInstance/api/tts/?engine=google&lang=$toLanguageValue&text=$googleTranslationOutput');
                      else if (instance == 'random')
                        _url = Uri.parse(
                            '${instances[Random().nextInt(instances.length)]}/api/tts/?engine=google&lang=$toLanguageValue&text=$googleTranslationOutput');
                      else
                        _url = Uri.parse(
                            '$instance/api/tts/?engine=google&lang=$toLanguageValue&text=$googleTranslationOutput');
                      try {
                        final response = await http.get(_url);
                        if (response.statusCode == 200) {
                          final result = await audioPlayer
                              .playBytes(response.bodyBytes)
                              .whenComplete(() => null);
                          if (result == 1) setState(() => listening = true);
                        } else
                          showInstanceTtsError(context);
                      } catch (err) {
                        try {
                          final result =
                              await InternetAddress.lookup('exmaple.com');
                          if (result.isNotEmpty &&
                              result[0].rawAddress.isNotEmpty) {
                            showInstanceTtsError(context);
                          }
                        } on SocketException catch (_) {
                          showInternetError(context);
                        }
                      }
                    }
              : () async {
                  final result = await audioPlayer.stop();
                  if (result == 1)
                    setState(() => listening = false);
                  else
                    print('something is wrong');
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
