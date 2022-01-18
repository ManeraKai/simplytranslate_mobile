import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simplytranslate_mobile/generated/l10n.dart';
import '/data.dart';

bool _listening = false;
bool _isSnackBarPressed = false;

AudioPlayer _audioPlayer = AudioPlayer();

class TtsInput extends StatefulWidget {
  const TtsInput({Key? key}) : super(key: key);

  @override
  State<TtsInput> createState() => _TtsOutputState();
}

class _TtsOutputState extends State<TtsInput> {
  @override
  Widget build(BuildContext context) {
    final _input = googleInCtrl.text;
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
              L10n.of(context).audio_limit,
              textAlign: TextAlign.center,
            ),
          ),
        );
        _isSnackBarPressed = true;
        Future.delayed(const Duration(seconds: 1)).then(
          (_) => _isSnackBarPressed = false,
        );
      }
    }

    startPlayer() async {
      _audioPlayer.onPlayerCompletion.listen(
        (event) => setState(() => _listening = false),
      );
      isTtsInCanceled = false;
      final _random = Random().nextInt(instances.length);
      final _url;
      if (instance == 'custom')
        _url = Uri.parse(
          '$customInstance/api/tts/?engine=google&lang=$fromLangVal&text=$_input',
        );
      else if (instance == 'random')
        _url = Uri.parse(
          '${instances[_random]}/api/tts/?engine=google&lang=$fromLangVal&text=$_input',
        );
      else
        _url = Uri.parse(
          '$instance/api/tts/?engine=google&lang=$fromLangVal&text=$_input',
        );
      try {
        setState(() => ttsInputloading = true);
        final response = await http.get(_url);
        if (!isTtsInCanceled) {
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
                '${excludedInstances[randomExcluded]}/api/tts/?engine=google&lang=$fromLangVal&text=$_input',
              );
              try {
                final response = await http.get(_urlExcluded);
                if (!isTtsInCanceled) {
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
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
                    showInstanceTtsError(context);
                } on SocketException catch (_) {
                  showInternetError(context);
                }
              }
            } else
              showInstanceTtsError(context);
          }
          setState(() => ttsInputloading = false);
        }
      } catch (err) {
        try {
          final result = await InternetAddress.lookup('exmaple.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty)
            showInstanceTtsError(context);
        } on SocketException catch (_) {
          showInternetError(context);
        }
        setState(() => ttsInputloading = false);
      }
    }

    return ttsInputloading
        ? InkWell(
            onTap: () {
              setState(() {
                ttsInputloading = false;
                isTtsInCanceled = true;
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
              color: googleInCtrl.text.length > 200 && !_listening
                  ? Colors.grey
                  : null,
            ),
          );
  }
}

// googleInCtrl.text == ''
//     ? _listening
//         ? () async {
//             final result = await audioPlayer.stop();
//             if (result == 1)
//               setState(() => _listening = false);
//             else
//               print('something is wrong');
//           }
//         : null
//     : !_listening
//         ? googleInCtrl.text.length > 200
//             ? () {
//                 if (!_isSnackBarPressed) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       duration: Duration(seconds: 2),
//                       width: 300,
//                       content: Text(
//                         L10n.of(context).audio_limit,
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   );
//                   _isSnackBarPressed = true;
//                   Future.delayed(Duration(seconds: 1))
//                       .then((_) => _isSnackBarPressed = false);
//                 }
//               }
//             : () async {
//                 final _url;
//                 if (instance == 'custom')
//                   _url = Uri.parse(
//                       '$customInstance/api/tts/?engine=google&lang=$fromLangVal&text=${googleInCtrl.text}');
//                 else if (instance == 'random')
//                   _url = Uri.parse(
//                       '${instances[Random().nextInt(instances.length)]}/api/tts/?engine=google&lang=$fromLangVal&text=${googleInCtrl.text}');
//                 else
//                   _url = Uri.parse(
//                       '$instance/api/tts/?engine=google&lang=$fromLangVal&text=${googleInCtrl.text}');
//                 try {
//                   final response = await http.get(_url);
//                   if (response.statusCode == 200) {
//                     final result = await audioPlayer
//                         .playBytes(response.bodyBytes)
//                         .whenComplete(() => null);
//                     if (result == 1) {
//                       setState(() {
//                         _listening = true;
//                       });
//                     }
//                   } else
//                     showInstanceTtsError(context);
//                 } catch (err) {
//                   try {
//                     final result =
//                         await InternetAddress.lookup('exmaple.com');
//                     if (result.isNotEmpty &&
//                         result[0].rawAddress.isNotEmpty)
//                       showInstanceTtsError(context);
//                   } on SocketException catch (_) {
//                     showInternetError(context);
//                   }
//                 }
//               }
//         : () async {
//             final result = await audioPlayer.stop();
//             if (result == 1) setState(() => _listening = false);
//           },
