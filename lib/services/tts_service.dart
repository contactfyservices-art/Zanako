import 'package:flutter_tts/flutter_tts.dart';
import 'settings_service.dart';

class TtsService {
  TtsService._internal();
  static final TtsService instance = TtsService._internal();
  final FlutterTts _tts = FlutterTts();
  bool _ready = false;

  Future<void> init() async {
    if (_ready) return;
    await _tts.setLanguage('fr-FR');
    await _tts.setSpeechRate(0.35);
    await _tts.setPitch(1.15);
    await _tts.setVolume(SettingsService.instance.voiceLevel / 10);
    _ready = true;
  }

  Future<void> speak(String text) async {
    await init();
    await _tts.setVolume(SettingsService.instance.voiceLevel / 10);
    await _tts.stop();
    await _tts.speak(text);
  }

  Future<void> stop() async => _tts.stop();
}
