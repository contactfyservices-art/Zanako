import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/game_data.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _advanced = false;
  int _index = 0;
  String? _selected;
  bool? _isCorrect;
  late ConfettiController _confetti;
  late List<String> _shuffled;

  List<GameRound> get _rounds => _advanced ? gameRoundsAdvanced : gameRoundsBasic;
  GameRound get _round => _rounds[_index];

  @override
  void initState() { super.initState(); _confetti = ConfettiController(duration: const Duration(seconds: 1)); ProgressService.instance.load().then((_) { _prepare(); setState(() {}); }); }
  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  void _prepare() {
    _selected = null; _isCorrect = null;
    _shuffled = List.of(_round.choices)..shuffle(Random());
    Future.delayed(const Duration(milliseconds: 300), () => TtsService.instance.speak(_round.spoken));
  }

  void _switchMode(bool advanced) => setState(() { _advanced = advanced; _index = 0; _prepare(); });

  Future<void> _tap(String choice) async {
    if (_selected != null) return;
    setState(() { _selected = choice; _isCorrect = choice == _round.correct; });
    if (_isCorrect == true) { _confetti.play(); await ProgressService.instance.addPoints(_round.points); await TtsService.instance.speak('bravo'); }
    else { await TtsService.instance.speak('essaie encore'); }
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        if (_isCorrect == true) { _index = (_index + 1) % _rounds.length; _prepare(); }
        else { _selected = null; _isCorrect = null; }
      });
    });
  }

  static const _bubbleColors = [AppColors.skyBlue, AppColors.candyOrange, AppColors.berryPink, AppColors.leafGreen];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: Stack(children: [
          SafeArea(child: Column(children: [
            Padding(padding: const EdgeInsets.fromLTRB(12, 8, 20, 0), child: Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
              Text('Jeu · ', style: handwritingStyle(fontSize: 22, color: AppColors.berryPink)),
              const Icon(Icons.bolt_rounded, color: AppColors.berryPink, size: 22),
              Text(' ${ProgressService.instance.totalPoints}', style: handwritingStyle(fontSize: 22)),
            ])),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _Toggle(label: 'Facile', selected: !_advanced, onTap: () => _switchMode(false)),
              const SizedBox(width: 10),
              _Toggle(label: 'Avancé', selected: _advanced, onTap: () => _switchMode(true)),
            ]),
            const SizedBox(height: 20),
            GestureDetector(onTap: () => TtsService.instance.speak(_round.spoken), child: Container(width: 110, height: 110,
              decoration: const BoxDecoration(color: AppColors.sunYellow, shape: BoxShape.circle),
              child: const Icon(Icons.volume_up_rounded, size: 56, color: Colors.white))),
            const SizedBox(height: 12),
            Text('écoute et touche le bon mot !', style: handwritingBody(fontSize: 18, color: AppColors.deepBlue)),
            const SizedBox(height: 24),
            ..._shuffled.map((choice) {
              Color color = _bubbleColors[_shuffled.indexOf(choice) % _bubbleColors.length];
              if (_selected == choice) color = _isCorrect == true ? AppColors.leafGreen : AppColors.berryPink;
              return Padding(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                child: GestureDetector(onTap: () => _tap(choice), child: Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(28)),
                  child: Center(child: Text(choice, style: handwritingStyle(fontSize: 24, color: Colors.white))))));
            }),
          ])),
          Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, shouldLoop: false,
            colors: const [AppColors.candyOrange, AppColors.berryPink, AppColors.leafGreen, AppColors.sunYellow])),
        ]),
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap;
  const _Toggle({required this.label, required this.selected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: selected ? AppColors.deepBlue : AppColors.lineBlue, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: handwritingBody(fontSize: 16, color: selected ? Colors.white : AppColors.inkBrown))));
  }
}
