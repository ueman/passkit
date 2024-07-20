class ArtistMetadata {
  ArtistMetadata({
    required this.name,
    required this.id,
    required this.url,
    required this.primaryGenre,
  });

  factory ArtistMetadata.fromJson(Map<String, dynamic> json) {
    return ArtistMetadata(
      id: json['artistId'] as int,
      url: Uri.parse(json['artistLinkUrl'] as String),
      name: json['artistName'] as String,
      primaryGenre: json['primaryGenreName'] as String,
    );
  }

  final String name;

  // corresponds to the `artistId` in the JSON
  final int id;

  // corresponds to `artistLinkUrl` in the JSON
  final Uri url;

  final String primaryGenre;
}
