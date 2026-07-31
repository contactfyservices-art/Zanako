import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._internal();
  static final TtsService instance = TtsService._internal();
  final FlutterTts _tts = FlutterTts();
  bool _ready = false;
  double _volume = 0.8;

  Future<void> init() async {
    if (_ready) return;
    await _tts.setLanguage('fr-FR');
    await _tts.setSpeechRate(0.35);
    await _tts.setPitch(1.15);
    await _tts.setVolume(_volume);
    _ready = true;
  }

  Future<void> setVolumeLevel(int level) async {
    _volume = level / 10.0;
    await _tts.setVolume(_volume);
  }

  Future<void> speak(String text) async {
    await init();
    await _tts.stop();
    await _tts.speak(text);
  }
}
