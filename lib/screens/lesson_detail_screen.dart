import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_content.dart';
import '../services/tts_service.dart';

class LessonDetailScreen extends StatelessWidget {
  final LessonContent lesson;
  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
                Text(lesson.letter, style: handwritingStyle(fontSize: 46, color: AppColors.candyOrange)),
              ]),
              const SizedBox(height: 12),
              Text('les syllabes', style: handwritingBody(fontSize: 18, color: AppColors.deepBlue)),
              Wrap(spacing: 10, runSpacing: 10, children: lesson.syllables.map((s) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: AppColors.skyBlue, borderRadius: BorderRadius.circular(14)),
                child: Text(s, style: handwritingStyle(fontSize: 22, color: Colors.white)),
              )).toList()),
              const SizedBox(height: 20),
              Text('les mots', style: handwritingBody(fontSize: 18, color: AppColors.deepBlue)),
              Wrap(spacing: 10, runSpacing: 10, children: lesson.words.map((w) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(color: AppColors.sunYellow, borderRadius: BorderRadius.circular(14)),
                child: Text(w, style: handwritingBody(fontSize: 18, color: AppColors.inkBrown)),
              )).toList()),
              const SizedBox(height: 26),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: AppColors.marginRed, width: 3)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(lesson.sentence, style: handwritingStyle(fontSize: 24)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => TtsService.instance.speak(lesson.sentence),
                    child: Row(children: [
                      const Icon(Icons.volume_up_rounded, color: AppColors.berryPink),
                      const SizedBox(width: 6),
                      Text('écouter', style: handwritingBody(fontSize: 18, color: AppColors.berryPink)),
                    ]),
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
