import '../../model/artists/artist.dart';

class ArtistDto {
  static const String nameKey = 'name';
  static const String genreKey = 'genre';
  static const String imageUrlKey = 'imageUrl';

  static Artist fromJson(String id, Map<String, dynamic> json) {
    return Artist(
      id: id,
      name: json[nameKey] as String,
      genre: json[genreKey] as String,
      imageUrl: json[imageUrlKey] as String,
    );
  }

  static Map<String, dynamic> toJson(Artist artist) {
    return {
      nameKey: artist.name,
      genreKey: artist.genre,
      imageUrlKey: artist.imageUrl,
    };
  }
}