import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import 'home_menu_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  'Zanako',
                  textAlign: TextAlign.center,
                  style: handwritingStyle(
                    fontSize: 64,
                    color: AppColors.candyOrange,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'j\'apprends à lire !',
                  style: handwritingBody(
                    fontSize: 22,
                    color: AppColors.deepBlue,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.sunYellow, width: 6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/welcome_photo.jpg',
                      width: 220,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Spacer(),
                _StartButton(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const HomeMenuScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final VoidCallback onTap;
  const _StartButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.leafGreen,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          'Commencer',
          style: handwritingStyle(fontSize: 28, color: Colors.white),
        ),
      ),
    );
  }
}
