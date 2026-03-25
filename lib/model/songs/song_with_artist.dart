import '../artists/artist.dart';
import 'song.dart';

class SongWithArtist {
  final Song song;
  final Artist artist;

  SongWithArtist({
    required this.song,
    required this.artist,
  });

  // Convenience getters
  String get id => song.id;
  String get title => song.title;
  String get imageUrl => song.imageUrl;
  Duration get duration => song.duration;
  String get artistName => artist.name;
  String get artistGenre => artist.genre;

  @override
  String toString() {
    return 'SongWithArtist(title: $title, artist: $artistName, genre: $artistGenre)';
  }
}