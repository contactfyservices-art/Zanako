import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_content.dart';
import 'lesson_detail_screen.dart';

class LessonsMenuScreen extends StatelessWidget {
  const LessonsMenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
                Text('Les leçons', style: handwritingStyle(fontSize: 28)),
              ]),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: lessons.length,
                itemBuilder: (context, i) {
                  final l = lessons[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => LessonDetailScreen(lesson: l))),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(color: AppColors.leafGreen, borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          Text(l.letter, style: handwritingStyle(fontSize: 34, color: Colors.white)),
                          const Spacer(),
                          const Icon(Icons.play_circle_fill_rounded, color: Colors.white, size: 34),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
