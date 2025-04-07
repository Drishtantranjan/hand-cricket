import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/bloc/game_bloc.dart';
import 'package:hand_cricket/bloc/game_event.dart';
import 'package:hand_cricket/bloc/game_state.dart';
import 'package:hand_cricket/presentation/widgets/appBar_card.dart';
import 'package:hand_cricket/presentation/widgets/background_container.dart';
import 'package:hand_cricket/presentation/widgets/game_overlays.dart';
import 'package:hand_cricket/presentation/widgets/game_timer.dart';
import 'package:hand_cricket/presentation/widgets/hand_animation_container.dart';
import 'package:hand_cricket/presentation/widgets/name_row_widget.dart';
import 'package:hand_cricket/presentation/widgets/number_picker.dart';
import 'package:hand_cricket/presentation/widgets/timer_text.dart';
import 'package:hand_cricket/presentation/widgets/top_score_container.dart';

enum GameOverlayType { six, out, timeout, userWin, botWin }

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int _counter = 10;
  Timer? _timer;
  int? selectedNumber;
  GameOverlayType? overlayType;

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
      _showOverlay(GameOverlayType.timeout);
      Future.delayed(const Duration(seconds: 1), () {
        _resetGame();
      });
    }
  }

  void _onNumberSelected(int number) {
    setState(() => selectedNumber = number);

    if (number == 6) {
      _showOverlay(GameOverlayType.six);
    }

    context.read<GameBloc>().add(UserPlayedEvent(number));
    _startCountdown();
  }

  void _showOverlay(GameOverlayType type) {
    setState(() => overlayType = type);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => overlayType = null);
      }
    });
  }

  void _resetGame() {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const GameScreen()),
    );
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
        if (state is GameUpdatedState) {
          if (state.game.isGameOver) {
            _timer?.cancel();
            Future.delayed(Duration.zero, () {
              _showOverlay(state.game.winner.contains('User')
                  ? GameOverlayType.userWin
                  : GameOverlayType.botWin);
              Future.delayed(const Duration(seconds: 1), () {
                _resetGame();
              });
            });
          } else if (!state.game.isUserBatting &&
              state.game.userRuns.length < 6 &&
              state.game.botRuns.isEmpty) {
            Future.delayed(Duration.zero, () {
              _showOverlay(GameOverlayType.out);
            });
          }
        }
      },
      builder: (context, state) {
        final game = (state is GameUpdatedState || state is GameInitialState)
            ? state.game
            : null;

        return Stack(
          children: [
            Scaffold(
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
                    NameRowWidget(),
                    const SizedBox(height: 40),
                    HandAnimationContainer(
                      userNumber: selectedNumber,
                      botNumber: game?.currentBotNumber,
                      isUserBatting: game?.isUserBatting,
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
            ),

            /// Overlay on top
            if (overlayType != null)
              GameOverlays(
                type: overlayType!,
                userScore: game!.totalUserRuns,
              )
          ],
        );
      },
    );
  }
}
