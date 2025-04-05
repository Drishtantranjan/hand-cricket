import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/assets_path.dart';
import 'package:hand_cricket/presentation/widgets/hand_gesture_animation_container.dart';
import 'package:hand_cricket/presentation/widgets/number_picker.dart';
import 'package:hand_cricket/presentation/widgets/top_container.dart';

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
        _counter = 10;
        if (_timer != null) {
          _timer!.cancel();
          _startCountdown();
        }
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
      body: Container(
        decoration: _buildBackgroundContainerDecoration(),
        child: Column(
          children: [
            Container(
              height: 150,
              color: Colors.black38,
            ),

            _buildTopContainer(runValues, isUserBatting),
            const SizedBox(height: 80),
            const HandGestureAnimationContainer(),
            const Spacer(),
            _buildTimerContainer(_counter),
            _buildTimeText(),
            const SizedBox(height: 15),
            NumberPickerWidget(onNumberSelected: _updateRun),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

BoxDecoration _buildBackgroundContainerDecoration() {
  return BoxDecoration(
    color: Colors.transparent,
    image: DecorationImage(
      image: AssetImage(AssetsPath.appBackgorund),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black54,
        BlendMode.darken,
      ),
    ),
  );
}

Widget _buildTimerContainer(int counter) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.black38,
      shape: BoxShape.circle,
      border: Border.all(
        width: 3,
        color: Color(0xC65C0000),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        '$counter',
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildTopContainer(List<int> runValues, bool isUserBatting) {
  return TopContainer(
    runValues: runValues,
    userBatting: isUserBatting,
  );
}

Widget _buildTimeText() {
  return Text(
    "Pick a number before timer runs out",
    style: TextStyle(
      fontSize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    overflow: TextOverflow.clip,
  );
}
