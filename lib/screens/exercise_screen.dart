import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../theme/app_theme.dart';
import '../widgets/notebook_background.dart';
import '../widgets/reading_timer.dart';
import '../data/lessons_data.dart';
import '../services/tts_service.dart';
import '../services/progress_service.dart';

class ExerciseScreen extends StatefulWidget {
  final ReadingLevel level;
  const ExerciseScreen({super.key, required this.level});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int _index = 0;
  int _timerResetCounter = 0;
  bool _appIsReading = false;
  late ConfettiController _confetti;

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 1));
    _speakCurrentPrompt();
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  ReadingItem get _current => widget.level.items[_index];

  Future<void> _speakCurrentPrompt() async {
    await TtsService.instance.speak('à toi de lire');
  }

  Future<void> _appReadsTheWord() async {
    setState(() => _appIsReading = true);
    await TtsService.instance.speak(_current.text);
    if (mounted) setState(() => _appIsReading = false);
  }

  void _onTimerFinished() {
    _appReadsTheWord();
  }

  Future<void> _markAsRead() async {
    await ProgressService.instance.addStar();
    _confetti.play();
    await TtsService.instance.speak('bravo');
    _goNext();
  }

  void _goNext() {
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      setState(() {
        if (_index < widget.level.items.length - 1) {
          _index += 1;
          _timerResetCounter += 1;
        } else {
          Navigator.of(context).pop();
        }
      });
      _speakCurrentPrompt();
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_rounded, size: 28),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Text(
                          '${widget.level.title} · ${_index + 1}/${widget.level.items.length}',
                          style: handwritingBody(
                              fontSize: 18, color: AppColors.deepBlue),
                        ),
                        ReadingTimer(
                          key: ValueKey(_timerResetCounter),
                          resetKey: ValueKey(_timerResetCounter),
                          seconds: 10,
                          onFinished: _onTimerFinished,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (_current.hint != null)
                            Text(_current.hint!,
                                style: const TextStyle(fontSize: 64)),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: AppColors.sunYellow, width: 4),
                            ),
                            child: Text(
                              _current.text,
                              style: handwritingStyle(
                                fontSize: widget.level.id == 'niveau3' ? 42 : 64,
                                color: AppColors.deepBlue,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (_appIsReading) ...[
                            const SizedBox(height: 16),
                            Text('🔊 écoute bien...',
                                style: handwritingBody(
                                    fontSize: 20, color: AppColors.berryPink)),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _RoundActionButton(
                          icon: Icons.volume_up_rounded,
                          color: AppColors.skyBlue,
                          label: 'écouter',
                          onTap: _appReadsTheWord,
                        ),
                        const SizedBox(width: 24),
                        _RoundActionButton(
                          icon: Icons.check_circle_rounded,
                          color: AppColors.leafGreen,
                          label: 'j\'ai lu !',
                          onTap: _markAsRead,
                        ),
                      ],
                    ),
                  ),
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

class _RoundActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _RoundActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 74,
            height: 74,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 36),
          ),
          const SizedBox(height: 6),
          Text(label, style: handwritingBody(fontSize: 16)),
        ],
      ),
    );
  }
}
