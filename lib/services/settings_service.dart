import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  SettingsService._internal();
  static final SettingsService instance = SettingsService._internal();
  int musicLevel = 6;
  int voiceLevel = 8;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    musicLevel = prefs.getInt('zanako_music_level') ?? 6;
    voiceLevel = prefs.getInt('zanako_voice_level') ?? 8;
  }

  Future<void> setMusicLevel(int v) async {
    musicLevel = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zanako_music_level', v);
  }

  Future<void> setVoiceLevel(int v) async {
    voiceLevel = v;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('zanako_voice_level', v);
  }
}
