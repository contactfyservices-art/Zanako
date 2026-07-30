import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../services/music_service.dart';
import '../utils/page_turn_route.dart';
import 'home_menu_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() { super.initState(); MusicService.instance.startBackgroundMusic(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 24, 24, 24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Spacer(),
              Text('Zanako', textAlign: TextAlign.center, style: handwritingStyle(fontSize: 64, color: AppColors.candyOrange, fontWeight: FontWeight.w700)),
              Text('j\'apprends à lire !', style: handwritingBody(fontSize: 22, color: AppColors.deepBlue)),
              const SizedBox(height: 28),
              Container(
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.sunYellow, width: 6),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12, offset: const Offset(0, 6))]),
                child: ClipOval(child: Image.asset('assets/images/welcome_photo.jpg', width: 220, height: 220, fit: BoxFit.cover)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => pushReplacementPage(context, const HomeMenuScreen()),
                child: Container(padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                  decoration: BoxDecoration(color: AppColors.leafGreen, borderRadius: BorderRadius.circular(40),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4))]),
                  child: Text('Commencer', style: handwritingStyle(fontSize: 28, color: Colors.white))),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ),
    );
  }
}
