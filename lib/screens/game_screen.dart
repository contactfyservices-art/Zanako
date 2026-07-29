import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _index = 0;
  String? _selected;
  bool? _isCorrect;
  late ConfettiController _confetti;
  late List<String> _shuffledChoices;

  static const _bubbleColors = [
    AppColors.skyBlue,
    AppColors.candyOrange,
    AppColors.berryPink,
  ];

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    _prepareRound();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  GameRound get _round => gameRounds[_index];

  void _prepareRound() {
    _selected = null;
    _isCorrect = null;
    _shuffledChoices = List.of(_round.choices)..shuffle(Random());
    Future.delayed(const Duration(milliseconds: 300), () {
      TtsService.instance.speak(_round.spoken);
    });
  }

  Future<void> _onChoiceTap(String choice) async {
    if (_selected != null) return;
    setState(() {
      _selected = choice;
      _isCorrect = choice == _round.correct;
    });
    if (_isCorrect == true) {
      _confetti.play();
      await ProgressService.instance.addStar();
      await TtsService.instance.speak('bravo');
    } else {
      await TtsService.instance.speak('essaie encore');
    }
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        if (_isCorrect == true) {
          _index = (_index + 1) % gameRounds.length;
          _prepareRound();
        } else {
          _selected = null;
          _isCorrect = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotebookBackground(
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 20, 0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded, size: 28),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text('Jeu d\'écoute',
                            style: handwritingStyle(
                                fontSize: 26, color: AppColors.berryPink)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => TtsService.instance.speak(_round.spoken),
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        color: AppColors.sunYellow,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.volume_up_rounded,
                          size: 56, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('écoute et touche le bon mot !',
                      style: handwritingBody(
                          fontSize: 20, color: AppColors.deepBlue)),
                  const SizedBox(height: 40),
                  ..._shuffledChoices.map((choice) {
                    final colorIndex =
                        _shuffledChoices.indexOf(choice) % _bubbleColors.length;
                    Color color = _bubbleColors[colorIndex];
                    if (_selected == choice) {
                      color = _isCorrect == true
                          ? AppColors.leafGreen
                          : AppColors.berryPink;
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 10),
                      child: GestureDetector(
                        onTap: () => _onChoiceTap(choice),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3)),
                            ],
                          ),
                          child: Center(
                            child: Text(choice,
                                style: handwritingStyle(
                                    fontSize: 30, color: Colors.white)),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confetti,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  AppColors.candyOrange,
                  AppColors.berryPink,
                  AppColors.leafGreen,
                  AppColors.sunYellow,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
