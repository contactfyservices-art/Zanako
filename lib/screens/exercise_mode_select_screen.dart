import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import 'exercise_screen.dart';
import 'dictation_screen.dart';
import 'guess_word_screen.dart';

class ExerciseModeSelectScreen extends StatelessWidget {
  final ReadingLevel level;
  const ExerciseModeSelectScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(level.title, style: handwritingStyle(fontSize: 32, color: AppColors.candyOrange)),
            const SizedBox(height: 30),
            _ModeButton(label: 'Lecture', color: AppColors.skyBlue, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExerciseScreen(level: level)))),
            const SizedBox(height: 16),
            _ModeButton(label: 'Dictée', color: AppColors.leafGreen, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => DictationScreen(level: level)))),
            const SizedBox(height: 16),
            _ModeButton(label: 'Deviner', color: AppColors.berryPink, onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => GuessWordScreen(level: level)))),
            const SizedBox(height: 30),
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('retour', style: handwritingBody(fontSize: 18))),
          ]),
        ),
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _ModeButton({required this.label, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(30)),
        child: Center(child: Text(label, style: handwritingStyle(fontSize: 26, color: Colors.white))),
      ),
    );
  }
}
