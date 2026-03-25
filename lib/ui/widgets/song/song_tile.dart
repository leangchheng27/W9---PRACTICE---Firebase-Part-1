import 'package:flutter/material.dart';
import '../../../model/songs/song_with_artist.dart';

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.swa,
    required this.isPlaying,
    required this.onTap,
  });

  final SongWithArtist swa;
  final bool isPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final int mins = swa.duration.inMinutes;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(
            backgroundImage: swa.imageUrl.isNotEmpty
                ? NetworkImage(swa.imageUrl)
                : null,
            radius: 24,
            child: swa.imageUrl.isEmpty ? Icon(Icons.music_note) : null,
          ),
          title: Text(swa.title),
          subtitle: Text('$mins mins  ${swa.artistName} – ${swa.artistGenre}'),
          trailing: Text(
            isPlaying ? "Playing" : "",
            style: TextStyle(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}