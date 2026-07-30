class LessonContent {
  final String letter;
  final List<String> syllables;
  final List<String> words;
  final String sentence;
  const LessonContent({required this.letter, required this.syllables, required this.words, required this.sentence});
}

final List<LessonContent> lessons = [
  const LessonContent(letter: 'l', syllables: ['lê','la','le','lé','li','lè','lo','lu'], words: ['émile','la lune','le loto','la lame','la lime','la pelote','la tulipe'], sentence: 'amélie, retire ta pèlerine.'),
  const LessonContent(letter: 'n', syllables: ['ni','né','na','nê','no','nè','nu','ne'], words: ['nina','irène','tenu','puni','âne','une note','une épine'], sentence: 'papa a puni rené.'),
  const LessonContent(letter: 'r', syllables: ['rê','ra','ré','ru','re','ri','rè','ro'], words: ['ratière','rire','rare','rata','rue','père','râpe'], sentence: 'père a réparé ta petite ratière.'),
  const LessonContent(letter: 'm', syllables: ['mé','me','mu','mo','mê','mi','mè','ma'], words: ['mimi','maria','ma mère','une mare','ami','numéro','une tomate'], sentence: 'ma mère a ramené petite marie.'),
  const LessonContent(letter: 't', syllables: ['ta','té','ti','te','tu','tè','to','tê'], words: ['toto','tête','têtu','été','étui','patate','pâté'], sentence: 'papa, toto a ôté ta petite pipe.'),
  const LessonContent(letter: 'p', syllables: ['pi','pu','po','pa','pe','pé','pè','pê'], words: ['papa','pipe','épi','pie'], sentence: 'la poule appelle ses petits.'),
  const LessonContent(letter: 's / b', syllables: ['sé','so','sê','si','sa','sê','sè','bê','ba','be','bo','bé','bi','bu'], words: ['la salière','la salade','la salive','la sabotière','la robe','la cabine'], sentence: 'sidonie démêla la salade. adèle dévidera la bobine.'),
  const LessonContent(letter: 'f / j', syllables: ['fu','fé','fo','fê','fa','jo','jé','ju','je','ja','ji'], words: ['café','carafe','farine','fumée','jolie jupe','bébé cajole'], sentence: 'éva fera du café. la joie au jour de l\'an.'),
  const LessonContent(letter: 'g / ch', syllables: ['gâ','go','gu','cha','chi','che','chô','chu'], words: ['la gare','la rigole','une bûche','une galopade','le chat','le cheval'], sentence: 'le cheval tire la charrue.'),
  const LessonContent(letter: 'd / v', syllables: ['da','dé','du','dé','do','di','vo','vé','va','vu','ve','vi'], words: ['dédé','malade','camarade','modèle','avion','vite'], sentence: 'dédé est malade. l\'avion va vite.'),
  const LessonContent(letter: 'c', syllables: ['cu','co','ca'], words: ['cocorico','l\'écume','la capitale','la cane','l\'école','la capote'], sentence: 'le coq est le roi de la basse-cour.'),
];
