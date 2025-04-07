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
      final int botChoice = _repo.generateBotChoice();

      if (currentGame.isUserBatting) {
        final bool isOut = _repo.isOut(event.userChoice, botChoice);
        final List<int> updatedUserRuns = [...currentGame.userRuns];

        if (!isOut && updatedUserRuns.length < 6) {
          updatedUserRuns.add(event.userChoice);
        }

        if (isOut || updatedUserRuns.length == 6) {
          // Switch innings
          emit(GameUpdatedState(
            currentGame.copyWith(
              userRuns: updatedUserRuns,
              isUserBatting: false,
              currentBotNumber: botChoice,
            ),
          ));
        } else {
          emit(GameUpdatedState(
            currentGame.copyWith(
              userRuns: updatedUserRuns,
              currentBotNumber: botChoice,
            ),
          ));
        }
      } else {
        final bool isOut = _repo.isOut(event.userChoice, botChoice);
        final List<int> updatedBotRuns = [...currentGame.botRuns];

        if (!isOut && updatedBotRuns.length < 6) {
          updatedBotRuns.add(event.userChoice);
        }

        int userScore = currentGame.userRuns.fold(0, (a, b) => a + b);
        int botScore = updatedBotRuns.fold(0, (a, b) => a + b);

        bool isGameOver = isOut || updatedBotRuns.length == 6 || botScore > userScore;
        String winner = "";

        if (isGameOver) {
          if (botScore > userScore) {
            winner = "Bot Wins!";
          } else if (botScore == userScore) {
            winner = "Match Draw!";
          } else {
            winner = "You Win!";
          }
        }

        emit(GameUpdatedState(
          currentGame.copyWith(
            botRuns: updatedBotRuns,
            isGameOver: isGameOver,
            winner: isGameOver ? winner : currentGame.winner,
            currentBotNumber: botChoice,
          ),
        ));
      }
    });
  }
}
