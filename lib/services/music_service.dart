import 'package:audioplayers/audioplayers.dart';
import 'settings_service.dart';

class MusicService {
  MusicService._internal();
  static final MusicService instance = MusicService._internal();
  final AudioPlayer _player = AudioPlayer();
  bool _started = false;

  Future<void> startBackgroundMusic() async {
    if (_started) return;
    _started = true;
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(SettingsService.instance.musicLevel / 10);
    await _player.play(AssetSource('audio/background_music.mp3'));
  }

  Future<void> applyVolume(int level) async {
    await _player.setVolume(level / 10);
  }
}
