import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../services/progress_service.dart';
import 'level_select_screen.dart';
import 'game_screen.dart';

class HomeMenuScreen extends StatefulWidget {
  const HomeMenuScreen({super.key});

  @override
  State<HomeMenuScreen> createState() => _HomeMenuScreenState();
}

class _HomeMenuScreenState extends State<HomeMenuScreen> {
  @override
  void initState() {
    super.initState();
    ProgressService.instance.load().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Zanako',
                        style: handwritingStyle(
                            fontSize: 40, color: AppColors.candyOrange)),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.sunYellow, size: 30),
                        const SizedBox(width: 4),
                        Text('${ProgressService.instance.totalStars}',
                            style: handwritingStyle(fontSize: 26)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Que veux-tu faire ?',
                    style: handwritingBody(
                        fontSize: 22, color: AppColors.deepBlue)),
                const SizedBox(height: 28),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: _MenuCard(
                          label: 'Exercices',
                          subtitle: 'apprendre à lire',
                          icon: Icons.menu_book_rounded,
                          color: AppColors.skyBlue,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const LevelSelectScreen()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _MenuCard(
                          label: 'Jeux',
                          subtitle: 'je m\'amuse',
                          icon: Icons.sports_esports_rounded,
                          color: AppColors.berryPink,
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const GameScreen()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.label,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: Colors.white),
            const SizedBox(height: 14),
            Text(label,
                style: handwritingStyle(fontSize: 30, color: Colors.white)),
            Text(subtitle,
                style: handwritingBody(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
