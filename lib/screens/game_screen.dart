import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hand_cricket/presentation/assets_path.dart';
import 'package:hand_cricket/presentation/widgets/hand_gesture_animation_container.dart';
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
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(AssetsPath.appBackgorund),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          children: [
            Container(height: 150,),
            TopContainer(
              runValues: runValues,
              userBatting: isUserBatting,
            ),

            HandGestureAnimationContainer(),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  shape: BoxShape.circle,
                  border: Border.all(
                      width: 3,
                      color: Color(0xC65C0000)
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '$_counter',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Text(
              "Pick a number before timer runs out",
              style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
              overflow: TextOverflow.clip,
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _updateRun(1),
                  child: Image.asset(AssetsPath.oneNumber, height: 60),
                ),
                GestureDetector(
                  onTap: () => _updateRun(2),
                  child: Image.asset(AssetsPath.twoNumber, height: 60),
                ),
                GestureDetector(
                  onTap: () => _updateRun(3),
                  child: Image.asset(AssetsPath.threeNumber, height: 60),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _updateRun(4),
                  child: Image.asset(AssetsPath.fourNumber, height: 60),
                ),
                GestureDetector(
                  onTap: () => _updateRun(5),
                  child: Image.asset(AssetsPath.fiveNumber, height: 60),
                ),
                GestureDetector(
                  onTap: () => _updateRun(6),
                  child: Image.asset(AssetsPath.sixNumber, height: 60),
                ),
              ],
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}

