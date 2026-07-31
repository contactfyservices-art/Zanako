import 'package:shared_preferences/shared_preferences.dart';
import 'music_service.dart';
import 'tts_service.dart';

class SettingsService {
  SettingsService._internal();
  static final SettingsService instance = SettingsService._internal();

  int musicVolume = 2;
  int voiceVolume = 8;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    musicVolume = prefs.getInt('zanako_music_volume') ?? 2;
    voiceVolume = prefs.getInt('zanako_voice_volume') ?? 8;
    await MusicService.instance.setVolumeLevel(musicVolume);
    await TtsService.instance.setVolumeLevel(voiceVolume);
  }

  Future<void> setMusicVolume(int v) async {
    musicVolume = v;
    await MusicService.instance.setVolumeLevel(v);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zanako_music_volume', v);
  }

  Future<void> setVoiceVolume(int v) async {
    voiceVolume = v;
    await TtsService.instance.setVolumeLevel(v);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zanako_voice_volume', v);
  }
}
