import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import '../utils/page_turn_route.dart';
import 'exercise_mode_select_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});
  static const _colors = [AppColors.leafGreen, AppColors.candyOrange, AppColors.berryPink, AppColors.skyBlue];

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
                Text('Choisis ton niveau', style: handwritingStyle(fontSize: 24)),
              ]),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemCount: readingLevels.length,
                itemBuilder: (context, i) {
                  final level = readingLevels[i];
                  return GestureDetector(
                    onTap: () => pushPage(context, ExerciseModeSelectScreen(level: level)),
                    child: Container(
                      decoration: BoxDecoration(color: _colors[i % _colors.length], borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text('${i + 1}', style: handwritingStyle(fontSize: 22, color: Colors.white))),
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
