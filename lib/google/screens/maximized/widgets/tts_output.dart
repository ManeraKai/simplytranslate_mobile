import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/main_localizations.dart';
import '/data.dart';
import 'package:http/http.dart' as http;

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
    final _input = googleOutput;
    stopPlayer() async {
      final result = await _audioPlayer.stop();
      if (result == 1)
        setState(() => _listening = false);
      else
        print('something is wrong');
    }

    audioLimit() {
      if (!_isSnackBarPressed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 2),
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

    startPlayer() async {
      _audioPlayer.onPlayerCompletion
          .listen((event) => setState(() => _listening = false));
      isMaximizedTtsOutputCanceled = false;
      final _random = Random().nextInt(instances.length);
      final _url;
      if (instance == 'custom')
        _url = Uri.parse(
            '$customInstance/api/tts/?engine=google&lang=$toLangVal&text=$_input');
      else if (instance == 'random')
        _url = Uri.parse(
            '${instances[_random]}/api/tts/?engine=google&lang=$toLangVal&text=$_input');
      else
        _url = Uri.parse(
            '$instance/api/tts/?engine=google&lang=$toLangVal&text=$_input');
      try {
        setState(() => ttsMaximizedOutputloading = true);
        final response = await http.get(_url);
        if (!isMaximizedTtsOutputCanceled) {
          if (response.statusCode == 200) {
            final result = await _audioPlayer
                .playBytes(response.bodyBytes)
                .whenComplete(() => null);
            if (result == 1) setState(() => _listening = true);
          } else {
            if (instance == 'random') {
              final List excludedInstances = instances.toList();
              excludedInstances.removeAt(_random);
              final randomExcluded = Random().nextInt(excludedInstances.length);
              final _urlExcluded = Uri.parse(
                  '${excludedInstances[randomExcluded]}/api/tts/?engine=google&lang=$toLangVal&text=$_input');
              try {
                final response = await http.get(_urlExcluded);
                if (!isMaximizedTtsOutputCanceled) {
                  if (response.statusCode == 200) {
                    final result = await _audioPlayer
                        .playBytes(response.bodyBytes)
                        .whenComplete(() => null);
                    if (result == 1) setState(() => _listening = true);
                  } else {
                    showInstanceTtsError(context);
                  }
                }
              } catch (err) {
                try {
                  final result = await InternetAddress.lookup('exmaple.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    showInstanceTtsError(context);
                  }
                } on SocketException catch (_) {
                  showInternetError(context);
                }
              }
            } else {
              showInstanceTtsError(context);
            }
          }
          setState(() => ttsMaximizedOutputloading = false);
        }
      } catch (err) {
        try {
          final result = await InternetAddress.lookup('exmaple.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('Last chance ------------------------');
            showInstanceTtsError(context);
          }
        } on SocketException catch (_) {
          showInternetError(context);
        }
        setState(() => ttsMaximizedOutputloading = false);
      }
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
              color:
                  googleOutput.length > 200 && !_listening ? Colors.grey : null,
            ),
          );
  }
}
