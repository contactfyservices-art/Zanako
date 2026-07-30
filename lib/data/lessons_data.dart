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
  const ReadingLevel({required this.id, required this.title, required this.subtitle, required this.items});
}

const List<String> _syllables = [
  'pa','ma','la','ta','na','ra','da','fa','ga','ba','sa','ja','va','ca',
  'pé','mé','lé','té','né','ré','dé','fé','gé','bé','sé','jé','vé','cé',
  'pi','mi','li','ti','ni','ri','di','fi','gi','bi','si','ji','vi','ci',
  'po','mo','lo','to','no','ro','do','fo','go','bo','so','jo','vo','co',
  'pu','mu','lu','tu','nu','ru','du','fu','gu','bu','su','ju','vu','cu',
];

const List<String> _words = [
  'papa','maman','mimi','lolo','tata','domino','lama','bola','toto','tête',
  'pipe','patate','robe','cabine','carafe','farine','jupe','café','gare','bûche',
  'charrue','chat','cheval','dédé','malade','avion','vite','coq','école','capitale',
  'cane','macaroni','capote','colère','rature','pâture','pari','pire','rôti','épine',
  'narine','tétine','note','âne','numéro','tomate','minute','étui','pâté','étape',
  'cabane','salade','salière','salive','sabotière','bobine','joue','jolie','loto','lime',
];

const List<String> _sentences = [
  'papa lit.', 'maman aime papa.', 'mimi a mal.', 'papa a la balle.',
  'lolo aime maman.', 'tata a la lama.', 'toto a été têtu.', 'papa a tapé toto.',
  'père a réparé ta ratière.', 'ma mère a ramené petite marie.', 'rémi a patiné.',
  'le chat ronronne devant le rôti.', 'sidonie démêla la salade.', 'adèle dévidera la bobine.',
  'éva fera du café.', 'la joie au jour de l\'an.', 'le cheval tire la charrue.',
  'émile a été poli à l\'école.', 'dédé est malade.', 'l\'avion va vite.',
  'le coq est le roi de la basse-cour.',
];

List<ReadingLevel> _buildLevels() {
  final levels = <ReadingLevel>[];
  int n = 1;
  for (int i = 0; i < _syllables.length; i += 3) {
    final chunk = _syllables.skip(i).take(3).map((s) => ReadingItem(s)).toList();
    levels.add(ReadingLevel(id: 'niv$n', title: 'Niveau $n', subtitle: 'Syllabes', items: chunk));
    n++;
  }
  for (int i = 0; i < _words.length; i += 3) {
    final chunk = _words.skip(i).take(3).map((s) => ReadingItem(s)).toList();
    levels.add(ReadingLevel(id: 'niv$n', title: 'Niveau $n', subtitle: 'Mots', items: chunk));
    n++;
  }
  for (final s in _sentences) {
    levels.add(ReadingLevel(id: 'niv$n', title: 'Niveau $n', subtitle: 'Phrases', items: [ReadingItem(s)]));
    n++;
  }
  return levels;
}

final List<ReadingLevel> readingLevels = _buildLevels();
