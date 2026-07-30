import 'package:audioplayers/audioplayers.dart';

class MusicService {
  MusicService._internal();
  static final MusicService instance = MusicService._internal();
  final AudioPlayer _player = AudioPlayer();
  bool _started = false;

  Future<void> startBackgroundMusic() async {
    if (_started) return;
    _started = true;
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(0.15);
    await _player.play(AssetSource('audio/background_music.mp3'));
  }
}
