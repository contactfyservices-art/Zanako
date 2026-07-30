import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class GuessWordScreen extends StatefulWidget {
  final ReadingLevel level;
  const GuessWordScreen({super.key, required this.level});
  @override
  State<GuessWordScreen> createState() => _GuessWordScreenState();
}

class _GuessWordScreenState extends State<GuessWordScreen> {
  int _index = 0;
  bool _revealed = false;
  late ConfettiController _confetti;

  @override
  void initState() { super.initState(); _confetti = ConfettiController(duration: const Duration(seconds: 1)); _speak(); }
  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  ReadingItem get _current => widget.level.items[_index];
  void _speak() => TtsService.instance.speak(_current.text);

  void _next(bool correct) async {
    if (correct) { await ProgressService.instance.addStar(); _confetti.play(); }
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() {
        _revealed = false;
        if (_index < widget.level.items.length - 1) { _index++; } else { Navigator.of(context).pop(); }
      });
      _speak();
    });
  }

  @override
  Widget build(BuildContext context) {
    final masked = '•' * _current.text.replaceAll(' ', '').length;
    return Scaffold(
      body: NotebookBackground(
        child: Stack(children: [
          SafeArea(child: Column(children: [
            Padding(padding: const EdgeInsets.all(12), child: Row(children: [
              IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
              Text('Deviner · ${_index + 1}/${widget.level.items.length}', style: handwritingBody(fontSize: 18)),
            ])),
            Expanded(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              GestureDetector(onTap: _speak, child: Container(width: 120, height: 120,
                decoration: const BoxDecoration(color: AppColors.berryPink, shape: BoxShape.circle),
                child: const Icon(Icons.hearing_rounded, size: 56, color: Colors.white))),
              const SizedBox(height: 20),
              Text(_revealed ? _current.text : masked, style: handwritingStyle(fontSize: 36, color: AppColors.deepBlue)),
              const SizedBox(height: 26),
              if (!_revealed)
                GestureDetector(onTap: () => setState(() => _revealed = true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  decoration: BoxDecoration(color: AppColors.skyBlue, borderRadius: BorderRadius.circular(24)),
                  child: Text('révéler', style: handwritingStyle(fontSize: 20, color: Colors.white))))
              else
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(onTap: () => _next(true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(color: AppColors.leafGreen, borderRadius: BorderRadius.circular(20)),
                    child: Text('j\'ai deviné !', style: handwritingBody(fontSize: 16, color: Colors.white)))),
                  const SizedBox(width: 14),
                  GestureDetector(onTap: () => _next(false), child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(color: AppColors.berryPink, borderRadius: BorderRadius.circular(20)),
                    child: Text('pas trouvé', style: handwritingBody(fontSize: 16, color: Colors.white)))),
                ]),
            ]))),
          ])),
          Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, shouldLoop: false,
            colors: const [AppColors.candyOrange, AppColors.berryPink, AppColors.leafGreen, AppColors.sunYellow])),
        ]),
      ),
    );
  }
}
