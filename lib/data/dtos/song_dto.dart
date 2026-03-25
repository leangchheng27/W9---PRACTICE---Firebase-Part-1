    import '../../model/songs/song.dart';

class SongDto {
  static const String titleKey = 'title';
  static const String artistIdKey = 'artistId';
  static const String durationKey = 'duration';
  static const String imageUrlKey = 'imageUrl';

  static Song fromJson(String id, Map<String, dynamic> json) {
    return Song(
      id: id,
      title: json[titleKey] as String,
      artistId: json[artistIdKey] as String,
      duration: Duration(milliseconds: json[durationKey] as int),
      imageUrl: json[imageUrlKey] as String,
    );
  }

  /// Convert Song to JSON
  static Map<String, dynamic> toJson(Song song) {
    return {
      titleKey: song.title,
      artistIdKey: song.artistId,
      durationKey: song.duration.inMilliseconds,
      imageUrlKey: song.imageUrl,
    };
  }
}
