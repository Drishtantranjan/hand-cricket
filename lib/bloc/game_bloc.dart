import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hand_cricket/repositories/game_repositories.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final GameRepository _repo;

  GameBloc(this._repo) : super(GameInitialState()) {
    on<StartGameEvent>((event, emit) {
      emit(GameInitialState());
    });

    on<UserPlayedEvent>((event, emit) {
      final currentGame = state.game;

      int botChoice = _repo.generateBotChoice();

      if (currentGame.isUserBatting) {
        if (_repo.isOut(event.userChoice, botChoice) ||
            currentGame.userRuns.length == 5) {
          // Switch to bot batting
          emit(GameUpdatedState(
            currentGame.copyWith(
              isUserBatting: false,
            ),
          ));
        } else {
          emit(GameUpdatedState(
            currentGame.copyWith(
              userRuns: [...currentGame.userRuns, event.userChoice],
            ),
          ));
        }
      } else {
        if (_repo.isOut(event.userChoice, botChoice) ||
            currentGame.botScore + event.userChoice > currentGame.userScore ||
            currentGame.botRuns.length == 5) {
          final newBotScore = _repo.isOut(event.userChoice, botChoice)
              ? currentGame.botScore
              : currentGame.botScore + event.userChoice;

          final winner =
              newBotScore > currentGame.userScore ? "Bot Wins!" : "User Wins!";

          emit(GameUpdatedState(
            currentGame.copyWith(
              botRuns: [...currentGame.botRuns, event.userChoice],
              isGameOver: true,
              winner: winner,
            ),
          ));
        } else {
          emit(GameUpdatedState(
            currentGame.copyWith(
              botRuns: [...currentGame.botRuns, event.userChoice],
            ),
          ));
        }
      }
    });
  }
}
