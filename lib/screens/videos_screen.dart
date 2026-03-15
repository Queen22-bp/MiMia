import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosScreen extends StatefulWidget {
  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Video Player')),
      body: Center(
        child: _controller.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _playPause,
                    child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
                    style: ElevatedButton.styleFrom(primary: Colors.purple, minimumSize: Size(100, 50)),
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
