import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../services/settings_service.dart';
import '../services/music_service.dart';
import '../services/tts_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final s = SettingsService.instance;
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
                Text('Réglages', style: handwritingStyle(fontSize: 28)),
              ]),
              const SizedBox(height: 30),
              Text('musique de fond : ${s.musicLevel}/10', style: handwritingBody(fontSize: 20)),
              Slider(
                value: s.musicLevel.toDouble(), min: 0, max: 10, divisions: 10,
                activeColor: AppColors.skyBlue,
                onChanged: (v) => setState(() { s.setMusicLevel(v.toInt()); MusicService.instance.applyVolume(v.toInt()); }),
              ),
              const SizedBox(height: 20),
              Text('voix (lecture des mots) : ${s.voiceLevel}/10', style: handwritingBody(fontSize: 20)),
              Slider(
                value: s.voiceLevel.toDouble(), min: 0, max: 10, divisions: 10,
                activeColor: AppColors.berryPink,
                onChanged: (v) => setState(() { s.setVoiceLevel(v.toInt()); TtsService.instance.speak('bonjour'); }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
