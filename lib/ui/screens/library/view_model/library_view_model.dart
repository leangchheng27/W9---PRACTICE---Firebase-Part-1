import 'package:flutter/material.dart';
import '../../../../data/repositories/artists/artist_repository.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/artists/artist.dart';
import '../../../../model/songs/song.dart';
import '../../../../model/songs/song_with_artist.dart';
import '../../../states/player_state.dart';
import '../../../utils/async_value.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final ArtistRepository artistRepository;
  final PlayerState playerState;

  AsyncValue<List<SongWithArtist>> songsValue = AsyncValue.loading();

  LibraryViewModel({
    required this.songRepository,
    required this.artistRepository,
    required this.playerState,
  }) {
    playerState.addListener(notifyListeners);
    _init();
  }

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    fetchSong();
  }

  void fetchSong() async {
    songsValue = AsyncValue.loading();
    notifyListeners();

    try {
      // Fetch both in parallel
      final results = await Future.wait([
        songRepository.fetchSongs(),
        artistRepository.fetchArtists(),
      ]);

      List<Song> songs = results[0] as List<Song>;
      List<Artist> artists = results[1] as List<Artist>;

      // Build a map for quick lookup: artistId → Artist
      Map<String, Artist> artistMap = {
        for (var artist in artists) artist.id: artist
      };

      // Join songs with artists
      List<SongWithArtist> songsWithArtist = songs.map((song) {
        Artist artist = artistMap[song.artistId] ??
            Artist(
              id: song.artistId,
              name: 'Unknown Artist',
              genre: 'Unknown',
              imageUrl: '',
            );
        return SongWithArtist(song: song, artist: artist);
      }).toList();

      songsValue = AsyncValue.success(songsWithArtist);
    } catch (e) {
      songsValue = AsyncValue.error(e);
    }
    notifyListeners();
  }

  bool isSongPlaying(SongWithArtist swa) =>
      playerState.currentSong == swa.song;

  void start(SongWithArtist swa) => playerState.start(swa.song);
  void stop() => playerState.stop();
}