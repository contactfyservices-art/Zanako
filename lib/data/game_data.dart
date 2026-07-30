class GameRound {
  final String spoken;
  final List<String> choices;
  final String correct;
  final int points;
  const GameRound({required this.spoken, required this.choices, required this.correct, required this.points});
}

final List<GameRound> gameRoundsBasic = [
  const GameRound(spoken: 'papa', choices: ['papa', 'mama', 'lolo'], correct: 'papa', points: 10),
  const GameRound(spoken: 'maman', choices: ['tata', 'maman', 'domino'], correct: 'maman', points: 10),
  const GameRound(spoken: 'mimi', choices: ['mimi', 'lama', 'bola'], correct: 'mimi', points: 10),
  const GameRound(spoken: 'lama', choices: ['bola', 'lama', 'papa'], correct: 'lama', points: 10),
  const GameRound(spoken: 'bola', choices: ['bola', 'mimi', 'tata'], correct: 'bola', points: 10),
  const GameRound(spoken: 'toto', choices: ['toto', 'tête', 'pipe'], correct: 'toto', points: 10),
  const GameRound(spoken: 'chat', choices: ['chat', 'cheval', 'coq'], correct: 'chat', points: 10),
  const GameRound(spoken: 'avion', choices: ['avion', 'gare', 'école'], correct: 'avion', points: 10),
  const GameRound(spoken: 'café', choices: ['carafe', 'café', 'farine'], correct: 'café', points: 10),
  const GameRound(spoken: 'robe', choices: ['robe', 'jupe', 'cabine'], correct: 'robe', points: 10),
];

final List<GameRound> gameRoundsAdvanced = [
  const GameRound(spoken: 'papa lit', choices: ['papa lit', 'maman lit', 'mimi a mal', 'toto a été têtu'], correct: 'papa lit', points: 20),
  const GameRound(spoken: 'maman aime papa', choices: ['papa aime maman', 'maman aime papa', 'lolo aime maman', 'tata a la lama'], correct: 'maman aime papa', points: 20),
  const GameRound(spoken: 'rémi a patiné', choices: ['rémi a patiné', 'dédé est malade', 'l\'avion va vite', 'éva fera du café'], correct: 'rémi a patiné', points: 20),
  const GameRound(spoken: 'le chat ronronne devant le rôti', choices: ['le cheval tire la charrue', 'le chat ronronne devant le rôti', 'la joie au jour de l\'an', 'papa a tapé toto'], correct: 'le chat ronronne devant le rôti', points: 20),
  const GameRound(spoken: 'l\'avion va vite', choices: ['dédé est malade', 'l\'avion va vite', 'éva fera du café', 'sidonie démêla la salade'], correct: 'l\'avion va vite', points: 20),
  const GameRound(spoken: 'le coq est le roi de la basse-cour', choices: ['le coq est le roi de la basse-cour', 'émile a été poli à l\'école', 'adèle dévidera la bobine', 'père a réparé ta ratière'], correct: 'le coq est le roi de la basse-cour', points: 20),
];
