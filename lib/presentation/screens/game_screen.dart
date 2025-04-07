import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/bloc/game_bloc.dart';
import 'package:hand_cricket/bloc/game_event.dart';
import 'package:hand_cricket/bloc/game_state.dart';
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
  int? selectedNumber;

  @override
  void initState() {
    super.initState();
    context.read<GameBloc>().add(StartGameEvent());
    _startCountdown();
  }

  void _startCountdown() {
    _counter = 10;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter == 0) {
        timer.cancel();
        _handleTimeout();
      } else {
        setState(() {
          _counter--;
        });
      }
    });
  }

  void _handleTimeout() {
    final currentState = context.read<GameBloc>().state;
    if (currentState is GameUpdatedState && !currentState.game.isGameOver) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Time's up!"),
          content: const Text("You took too long. Bot wins!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<GameBloc>().add(StartGameEvent());
                _startCountdown();
              },
              child: const Text("Play Again"),
            ),
          ],
        ),
      );
    }
  }

  void _onNumberSelected(int number) {
    setState(() {
      selectedNumber = number;
    });
    context.read<GameBloc>().add(UserPlayedEvent(number));
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameBloc, GameState>(
      listener: (context, state) {
        if (state is GameUpdatedState && state.game.isGameOver) {
          _timer?.cancel();
          Future.delayed(Duration.zero, () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                title: const Text("Game Over"),
                content: Text(state.game.winner),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<GameBloc>().add(StartGameEvent());
                      _startCountdown();
                    },
                    child: const Text("Play Again"),
                  ),
                ],
              ),
            );
          });
        }
      },
      builder: (context, state) {
        final game = (state is GameUpdatedState || state is GameInitialState)
            ? state.game
            : null;

        return Scaffold(
          body: BackgroundContainer(
            child: Column(
              children: [
                const AppbarCard(),
                TopScoreContainer(
                  runValues: game?.isUserBatting == true
                      ? game?.userRuns ?? []
                      : game?.botRuns ?? [],
                  isUserBatting: game?.isUserBatting ?? true,
                ),
                const SizedBox(height: 40),

                /// 👇 Updated: Pass both user and bot numbers to the animation
                HandAnimationContainer(
                  userNumber: selectedNumber,
                  botNumber: game?.currentBotNumber,
                ),

                const Spacer(),
                GameTimer(counter: _counter),
                const TimeText(),
                const SizedBox(height: 10),
                NumberPickerWidget(
                  onNumberSelected: (num) {
                    if (!(game?.isGameOver ?? true)) {
                      _onNumberSelected(num);
                    }
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }
}
