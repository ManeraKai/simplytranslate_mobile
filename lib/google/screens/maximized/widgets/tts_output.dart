import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';
import '/simplytranslate.dart' as simplytranslate;

bool _listening = false;
bool _isSnackBarPressed = false;

AudioPlayer _audioPlayer = AudioPlayer();

class MaximizedTtsOutput extends StatefulWidget {
  const MaximizedTtsOutput({Key? key}) : super(key: key);

  @override
  State<MaximizedTtsOutput> createState() => _TtsOutputState();
}

class _TtsOutputState extends State<MaximizedTtsOutput> {
  @override
  void dispose() {
    _audioPlayer.stop();
    _listening = false;
    isMaximizedTtsOutputCanceled = true;
    ttsMaximizedOutputloading = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _input = googleOutput['text'];
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
              L10n.of(context).audio_limit,
              textAlign: TextAlign.center,
            ),
          ),
        );
        _isSnackBarPressed = true;
        Future.delayed(Duration(seconds: 1))
            .then((_) => _isSnackBarPressed = false);
      }
    }

    startPlayer() async {
      isTtsInCanceled = false;
      setState(() => ttsInputloading = true);
      await _audioPlayer
          .setSourceBytes(await simplytranslate.tts(_input, toLangVal));
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

    return ttsMaximizedOutputloading
        ? InkWell(
            onTap: () {
              print('rofrof');
              setState(() {
                ttsMaximizedOutputloading = false;
                isMaximizedTtsOutputCanceled = true;
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
              if (_input == null) {
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
              color:
                  googleOutput.length > 200 && !_listening ? Colors.grey : null,
            ),
          );
  }
}
