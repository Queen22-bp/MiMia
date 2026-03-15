import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class MusicScreen extends StatefulWidget {
  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playPause() {
    if (isPlaying) _player.pause();
    else _player.play();
    setState(() => isPlaying = !isPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Music Player')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note, size: 100, color: Colors.purple),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _playPause,
              child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              style: ElevatedButton.styleFrom(primary: Colors.purple, minimumSize: Size(100, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
