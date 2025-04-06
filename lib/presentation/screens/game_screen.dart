import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/widgets/appBar_card.dart';
import 'package:hand_cricket/presentation/widgets/hand_animation_container.dart';
import 'package:hand_cricket/presentation/widgets/number_picker.dart';
import 'package:hand_cricket/presentation/widgets/timer_text.dart';
import 'package:hand_cricket/presentation/widgets/top_score_container.dart';
import 'package:hand_cricket/presentation/widgets/background_container.dart';
import 'package:hand_cricket/presentation/widgets/game_timer.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _counter = 10;
  Timer? _timer;
  List<int> runValues = [0, 0, 0, 0, 0, 0];
  int currentRunIndex = 0;
  bool isUserBatting = true;
  int? selectedNumber;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 1) {
        timer.cancel();
      }
      setState(() {
        _counter--;
      });
    });
  }

  void _updateRun(int value) {
    if (currentRunIndex < runValues.length) {
      setState(() {
        runValues[currentRunIndex] = value;
        currentRunIndex++;
        selectedNumber = value;
        _counter = 10;
        _timer?.cancel();
        _startCountdown();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          children: [
            const AppbarCard(),
            TopScoreContainer(
              runValues: runValues,
              isUserBatting: isUserBatting,
            ),
            const SizedBox(height: 40),
            HandAnimationContainer(userNumber: selectedNumber),
            const Spacer(),
            GameTimer(counter: _counter),
            const TimeText(),
            const SizedBox(height: 10),
            NumberPickerWidget(onNumberSelected: _updateRun),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
