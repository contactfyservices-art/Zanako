import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../services/progress_service.dart';
import 'level_select_screen.dart';
import 'game_screen.dart';
import 'lessons_menu_screen.dart';

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
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Zanako', style: handwritingStyle(fontSize: 38, color: AppColors.candyOrange)),
                    Row(children: [
                      const Icon(Icons.star_rounded, color: AppColors.sunYellow, size: 26),
                      Text(' ${ProgressService.instance.totalStars}  ', style: handwritingStyle(fontSize: 22)),
                      const Icon(Icons.bolt_rounded, color: AppColors.berryPink, size: 26),
                      Text(' ${ProgressService.instance.totalPoints}', style: handwritingStyle(fontSize: 22)),
                    ]),
                  ],
                ),
                const SizedBox(height: 24),
                _MenuCard(label: 'Leçons', subtitle: 'je découvre les lettres', icon: Icons.auto_stories_rounded, color: AppColors.leafGreen,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LessonsMenuScreen()))),
                const SizedBox(height: 16),
                _MenuCard(label: 'Exercices', subtitle: 'je m\'entraîne à lire', icon: Icons.menu_book_rounded, color: AppColors.skyBlue,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LevelSelectScreen()))),
                const SizedBox(height: 16),
                _MenuCard(label: 'Jeux', subtitle: 'je m\'amuse', icon: Icons.sports_esports_rounded, color: AppColors.berryPink,
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const GameScreen()))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final String label, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _MenuCard({required this.label, required this.subtitle, required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]),
        child: Row(children: [
          Icon(icon, size: 48, color: Colors.white),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: handwritingStyle(fontSize: 28, color: Colors.white)),
            Text(subtitle, style: handwritingBody(fontSize: 16, color: Colors.white)),
          ]),
        ]),
      ),
    );
  }
}
