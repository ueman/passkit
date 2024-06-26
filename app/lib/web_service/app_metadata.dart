class AppMetadata {
  AppMetadata({
    required this.description,
    required this.id,
    required this.url,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.artworkUrl512,
    required this.name,
    required this.genres,
  });

  factory AppMetadata.fromJson(Map<String, dynamic> json) {
    return AppMetadata(
      description: json['description'] as String,
      id: json['trackId'] as int,
      url: Uri.parse(json['trackViewUrl'] as String),
      artworkUrl60: Uri.parse(json['artworkUrl60'] as String),
      artworkUrl100: Uri.parse(json['artworkUrl100'] as String),
      artworkUrl512: Uri.parse(json['artworkUrl512'] as String),
      name: json['trackName'] as String,
      genres: (json['genres'] as List<dynamic>).cast<String>(),
    );
  }

  final String description;

  // corresponds to the `trackId` in the JSON
  final int id;

  // corresponds to `trackViewUrl` in the JSON
  final Uri url;
  final Uri artworkUrl60;
  final Uri artworkUrl100;
  final Uri artworkUrl512;

  // corresponds to `trackName` in the JSON
  final String name;

  final List<String> genres;
}
