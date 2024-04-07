import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '/data.dart';
import '/simplytranslate.dart' as simplytranslate;

bool _listening = false;
bool _isSnackBarPressed = false;

AudioPlayer _audioPlayer = AudioPlayer();

class TtsOutput extends StatefulWidget {
  const TtsOutput({
    Key? key,
  }) : super(key: key);

  @override
  State<TtsOutput> createState() => _TtsOutputState();
}

class _TtsOutputState extends State<TtsOutput> {
  @override
  Widget build(BuildContext context) {
    final _input = googleOutput['text'] ?? '';
    stopPlayer() async {
      await _audioPlayer.stop();
      setState(() => _listening = false);
    }

    audioLimit() {
      if (!_isSnackBarPressed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
            width: 300,
            content: Text(
              i18n().main.audio_limit,
              textAlign: TextAlign.center,
            ),
          ),
        );
        _isSnackBarPressed = true;
        Future.delayed(Duration(seconds: 1)).then((_) => _isSnackBarPressed = false);
      }
    }

    startPlayer() async {
      isTtsInCanceled = false;
      setState(() => ttsInputloading = true);
      await _audioPlayer.setSourceBytes(await simplytranslate.tts(_input, toLangVal));
      if (isTtsInCanceled) return;
      setState(() {
        _listening = true;
        ttsInputloading = false;
      });
      await _audioPlayer.resume();
      _audioPlayer.onPlayerComplete.listen((event) {
        setState(() => _listening = false);
      });
    }

    return ttsOutloading
        ? InkWell(
            onTap: () {
              setState(() {
                ttsOutloading = false;
                isTtsOutputCanceled = true;
              });
            },
            child: Container(
              height: 48,
              width: 48,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                height: 24,
                width: 24,
                child: const CircularProgressIndicator(strokeWidth: 3),
              ),
            ),
          )
        : IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              if (_input == '') {
                if (_listening)
                  return stopPlayer;
                else
                  return null;
              } else if (!_listening) {
                if (_input.length > 200)
                  return audioLimit;
                else
                  return startPlayer;
              } else
                return stopPlayer;
            }(),
            icon: Icon(
              _listening ? Icons.stop : Icons.volume_up,
              color: googleOutput.length > 200 && !_listening ? Colors.grey : null,
            ),
          );
  }
}
