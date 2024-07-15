class MusicModel {
  final String name;
  final String author;
  final String musicPath;
  final String imagePath;

  MusicModel(
      {required this.name,
      required this.author,
      required this.musicPath,
      required this.imagePath});

  factory MusicModel.empty() {
    return MusicModel(
      name: '',
      author: '',
      musicPath: '',
      imagePath: '',
    );
  }
}

final List<MusicModel> musicProvider = [
  MusicModel(
    name: 'Tarde en tu vida',
    author: 'Agua marina',
    musicPath: 'audio/tarde.mp3',
    imagePath: 'assets/images/tarde.jpeg',
  ),
  MusicModel(
    name: 'A que volviste',
    author: 'Armonia 10',
    musicPath: 'audio/aquevolviste.mp3',
    imagePath: 'assets/images/aquevolviste.jpeg',
  ),
  MusicModel(
    name: 'Pagaras',
    author: 'Armonia 10',
    musicPath: 'audio/pagaras.mp3',
    imagePath: 'assets/images/pagaras.jpeg',
  ),
];
