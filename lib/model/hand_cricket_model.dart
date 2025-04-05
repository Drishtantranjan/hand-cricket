class HandCricketGame {
  final List<int> userRuns;
  final List<int> botRuns;
  final bool isUserBatting;
  final bool isGameOver;
  final String winner;

  HandCricketGame({
    this.userRuns = const [],
    this.botRuns = const [],
    this.isUserBatting = true,
    this.isGameOver = false,
    this.winner = '',
  });

  int get userScore => userRuns.fold(0, (sum, run) => sum + run);
  int get botScore => botRuns.fold(0, (sum, run) => sum + run);

  HandCricketGame copyWith({
    List<int>? userRuns,
    List<int>? botRuns,
    bool? isUserBatting,
    bool? isGameOver,
    String? winner,
  }) {
    return HandCricketGame(
      userRuns: userRuns ?? this.userRuns,
      botRuns: botRuns ?? this.botRuns,
      isUserBatting: isUserBatting ?? this.isUserBatting,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
    );
  }
}
