import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../services/settings_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
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
              Text('musique de fond', style: handwritingBody(fontSize: 20, color: AppColors.deepBlue)),
              Slider(
                value: SettingsService.instance.musicVolume.toDouble(),
                min: 0, max: 10, divisions: 10,
                label: '${SettingsService.instance.musicVolume}',
                activeColor: AppColors.leafGreen,
                onChanged: (v) => setState(() => SettingsService.instance.setMusicVolume(v.round())),
              ),
              const SizedBox(height: 20),
              Text('voix / prononciation', style: handwritingBody(fontSize: 20, color: AppColors.deepBlue)),
              Slider(
                value: SettingsService.instance.voiceVolume.toDouble(),
                min: 0, max: 10, divisions: 10,
                label: '${SettingsService.instance.voiceVolume}',
                activeColor: AppColors.berryPink,
                onChanged: (v) => setState(() => SettingsService.instance.setVoiceVolume(v.round())),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
