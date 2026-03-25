import '../../../model/artists/artist.dart';
import 'artist_repository.dart';

class ArtistRepositoryMock implements ArtistRepository {
  final List<Artist> _artists = [
    Artist(
      id: 'artist_1',
      name: 'VannDa',
      genre: 'Hip-Hop',
      imageUrl: 'https://images.unsplash.com/photo-1511379938547-c1f69419868d',
    ),
    Artist(
      id: 'artist_2',
      name: 'Sokun Nisa',
      genre: 'Pop',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
    ),
  ];

  @override
  Future<List<Artist>> fetchArtists() async {
    return Future.delayed(Duration(seconds: 1), () => _artists);
  }

  @override
  Future<Artist?> fetchArtistById(String id) async {
    return Future.delayed(Duration(seconds: 1), () {
      return _artists.firstWhere(
        (artist) => artist.id == id,
        orElse: () => throw Exception('No artist with id $id'),
      );
    });
  }
}