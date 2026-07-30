import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../data/lessons_data.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class DictationScreen extends StatefulWidget {
  final ReadingLevel level;
  const DictationScreen({super.key, required this.level});
  @override
  State<DictationScreen> createState() => _DictationScreenState();
}

class _DictationScreenState extends State<DictationScreen> {
  int _index = 0;
  bool _revealed = false;
  late ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    _speak();
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  ReadingItem get _current => widget.level.items[_index];
  void _speak() => TtsService.instance.speak(_current.text);

  void _mark(bool correct) async {
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
    return Scaffold(
      body: NotebookBackground(
        child: Stack(children: [
          SafeArea(
            child: Column(children: [
              Padding(padding: const EdgeInsets.all(12), child: Row(children: [
                IconButton(icon: const Icon(Icons.arrow_back_rounded, size: 28), onPressed: () => Navigator.of(context).pop()),
                Text('Dictée · ${_index + 1}/${widget.level.items.length}', style: handwritingBody(fontSize: 18)),
              ])),
              Expanded(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                GestureDetector(
                  onTap: _speak,
                  child: Container(width: 120, height: 120, decoration: const BoxDecoration(color: AppColors.sunYellow, shape: BoxShape.circle),
                    child: const Icon(Icons.volume_up_rounded, size: 60, color: Colors.white)),
                ),
                const SizedBox(height: 16),
                Text('écris ce que tu entends sur ton cahier', style: handwritingBody(fontSize: 18, color: AppColors.deepBlue), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                if (!_revealed)
                  GestureDetector(
                    onTap: () => setState(() => _revealed = true),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      decoration: BoxDecoration(color: AppColors.skyBlue, borderRadius: BorderRadius.circular(24)),
                      child: Text('voir la réponse', style: handwritingStyle(fontSize: 20, color: Colors.white))),
                  )
                else
                  Column(children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.sunYellow, width: 3)),
                      child: Text(_current.text, style: handwritingStyle(fontSize: 32, color: AppColors.deepBlue))),
                    const SizedBox(height: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      GestureDetector(onTap: () => _mark(true), child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(color: AppColors.leafGreen, borderRadius: BorderRadius.circular(20)),
                        child: Text('c\'était correct', style: handwritingBody(fontSize: 16, color: Colors.white)))),
                      const SizedBox(width: 14),
                      GestureDetector(onTap: () => _mark(false), child: Container(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(color: AppColors.berryPink, borderRadius: BorderRadius.circular(20)),
                        child: Text('à revoir', style: handwritingBody(fontSize: 16, color: Colors.white)))),
                    ]),
                  ]),
              ]))),
            ]),
          ),
          Align(alignment: Alignment.topCenter, child: ConfettiWidget(confettiController: _confetti, blastDirectionality: BlastDirectionality.explosive, shouldLoop: false,
            colors: const [AppColors.candyOrange, AppColors.berryPink, AppColors.leafGreen, AppColors.sunYellow])),
        ]),
      ),
    );
  }
}
