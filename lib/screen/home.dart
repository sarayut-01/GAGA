import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:audioplayers/audioplayers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VideoPlayerController _controller;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isMusicPlaying = false;

  @override
  void initState() {
    super.initState();

    // กำหนดค่าวิดีโอ
    _controller = VideoPlayerController.asset('assets/video/sample.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
        _controller.play();
      });

    // เล่นเพลงพื้นหลัง และตั้งค่าให้เล่นซ้ำเมื่อจบ
    _audioPlayer.onPlayerComplete.listen((event) {
      _playBackgroundMusic();
    });
    _playBackgroundMusic();
  }

  Future<void> _playBackgroundMusic() async {
    try {
      await _audioPlayer.play(AssetSource('music/malog.mp3'));
      setState(() {
        isMusicPlaying = true;
      });
    } catch (e) {
      print('Error playing music: $e');
    }
  }

  Future<void> _stopBackgroundMusic() async {
    if (isMusicPlaying) {
      await _audioPlayer.pause();
      setState(() {
        isMusicPlaying = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Sarayut@TRAIPOB",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(isMusicPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: isMusicPlaying ? _stopBackgroundMusic : _playBackgroundMusic,
          ),
        ],
      ),
      body: Stack(
        children: [
          // วิดีโอพื้นหลัง
          Positioned.fill(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : const Center(child: CircularProgressIndicator()),
          ),

          // เนื้อหาตรงกลาง
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // รูปภาพตรงกลาง
                Image.asset(
                  'assets/image/123.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
