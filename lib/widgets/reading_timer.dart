import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReadingTimer extends StatefulWidget {
  final int seconds;
  final VoidCallback onFinished;
  final Key resetKey;

  const ReadingTimer({
    super.key,
    required this.resetKey,
    this.seconds = 10,
    required this.onFinished,
  });

  @override
  State<ReadingTimer> createState() => _ReadingTimerState();
}

class _ReadingTimerState extends State<ReadingTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  void _setupController() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget.onFinished();
        }
      });
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ReadingTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.resetKey != widget.resetKey) {
      _controller.dispose();
      _setupController();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final remaining =
            (widget.seconds * (1 - _controller.value)).ceil();
        return SizedBox(
          width: 72,
          height: 72,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: 1 - _controller.value,
                strokeWidth: 7,
                backgroundColor: AppColors.lineBlue,
                valueColor: AlwaysStoppedAnimation(
                  remaining <= 3
                      ? AppColors.berryPink
                      : AppColors.leafGreen,
                ),
              ),
              Text(
                '$remaining',
                style: handwritingStyle(fontSize: 26),
              ),
            ],
          ),
        );
      },
    );
  }
}
