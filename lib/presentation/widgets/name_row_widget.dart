import 'package:flutter/material.dart';
import 'package:hand_cricket/constants/strings.dart';
import 'package:hand_cricket/presentation/widgets/score_board_container.dart';
import 'package:provider/provider.dart';
import 'package:hand_cricket/bloc/game_bloc.dart';


class NameRowWidget extends StatelessWidget {
  const NameRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.watch<GameBloc>().state; // get the state
    final runsToWin = gameState.game.totalUserRuns; // access total user runs

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.userName,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                AppStrings.botName,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
          ScoreBoardContainer(runsToWin: runsToWin),
        ],
      ),
    );
  }
}
