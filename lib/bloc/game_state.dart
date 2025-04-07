import 'package:hand_cricket/model/hand_cricket_model.dart';

abstract class GameState {
  final HandCricketGame game;

  const GameState(this.game);
}

class GameInitialState extends GameState {
  GameInitialState()
      : super(
    HandCricketGame(
      userRuns: [],
      botRuns: [],
      isUserBatting: true,
      isGameOver: false,
      winner: '',
      currentBotNumber: null,
    ),
  );
}

class GameUpdatedState extends GameState {
  const GameUpdatedState(HandCricketGame game) : super(game);
}
