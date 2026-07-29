import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import 'exercise_screen.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  static const _levelColors = [
    AppColors.leafGreen,
    AppColors.candyOrange,
    AppColors.berryPink,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    Text('Choisis ton niveau',
                        style: handwritingStyle(fontSize: 28)),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: readingLevels.length,
                  itemBuilder: (context, index) {
                    final level = readingLevels[index];
                    final color = _levelColors[index % _levelColors.length];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  ExerciseScreen(level: level),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(0, 4)),
                            ],
                          ),
                          child: Row(
                            children: [
                              Text('${index + 1}',
                                  style: handwritingStyle(
                                      fontSize: 40, color: Colors.white)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(level.title,
                                        style: handwritingStyle(
                                            fontSize: 26,
                                            color: Colors.white)),
                                    Text(level.subtitle,
                                        style: handwritingBody(
                                            fontSize: 18,
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.play_circle_fill_rounded,
                                  color: Colors.white, size: 40),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
