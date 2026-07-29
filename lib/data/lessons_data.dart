class ReadingItem {
  final String text;
  final String? hint;
  const ReadingItem(this.text, {this.hint});
}

class ReadingLevel {
  final String id;
  final String title;
  final String subtitle;
  final List<ReadingItem> items;
  const ReadingLevel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.items,
  });
}

final List<ReadingLevel> readingLevels = [
  const ReadingLevel(
    id: 'niveau1',
    title: 'Niveau 1',
    subtitle: 'Les syllabes',
    items: [
      ReadingItem('pa'),
      ReadingItem('ma'),
      ReadingItem('lo'),
      ReadingItem('mi'),
      ReadingItem('ta'),
      ReadingItem('la'),
      ReadingItem('do'),
      ReadingItem('ni'),
      ReadingItem('bo'),
      ReadingItem('ri'),
    ],
  ),
  const ReadingLevel(
    id: 'niveau2',
    title: 'Niveau 2',
    subtitle: 'Les mots',
    items: [
      ReadingItem('papa', hint: '👨'),
      ReadingItem('maman', hint: '👩'),
      ReadingItem('mimi', hint: '🐱'),
      ReadingItem('lolo', hint: '😊'),
      ReadingItem('tata', hint: '👵'),
      ReadingItem('domino', hint: '🁢'),
      ReadingItem('lama', hint: '🦙'),
      ReadingItem('bola', hint: '⚽'),
    ],
  ),
  const ReadingLevel(
    id: 'niveau3',
    title: 'Niveau 3',
    subtitle: 'Les phrases',
    items: [
      ReadingItem('papa lit'),
      ReadingItem('maman aime papa'),
      ReadingItem('mimi a mal'),
      ReadingItem('papa a la balle'),
      ReadingItem('lolo aime maman'),
      ReadingItem('tata a la lama'),
    ],
  ),
];

class GameRound {
  final String spoken;
  final List<String> choices;
  final String correct;
  const GameRound({
    required this.spoken,
    required this.choices,
    required this.correct,
  });
}

final List<GameRound> gameRounds = [
  const GameRound(spoken: 'papa', choices: ['papa', 'mama', 'lolo'], correct: 'papa'),
  const GameRound(spoken: 'maman', choices: ['tata', 'maman', 'domino'], correct: 'maman'),
  const GameRound(spoken: 'mimi', choices: ['mimi', 'lama', 'bola'], correct: 'mimi'),
  const GameRound(spoken: 'lama', choices: ['bola', 'lama', 'papa'], correct: 'lama'),
  const GameRound(spoken: 'bola', choices: ['bola', 'mimi', 'tata'], correct: 'bola'),
  const GameRound(spoken: 'papa lit', choices: ['papa lit', 'maman lit', 'mimi a mal'], correct: 'papa lit'),
];
