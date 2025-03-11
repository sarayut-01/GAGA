import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isMusicPlaying = false;

  @override
  void initState() {
    super.initState();
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
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sarayut@TRAIPOB",
          style: GoogleFonts.lobster(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent.shade700,
        elevation: 10,
        actions: [
          IconButton(
            icon: Icon(
              isMusicPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              size: 32,
              color: Colors.white,
            ),
            onPressed: isMusicPlaying ? _stopBackgroundMusic : _playBackgroundMusic,
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/weaom.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              "Welcome",
              style: GoogleFonts.pacifico(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildButton(context, 'Login', Colors.blueAccent, 'login'),
                const SizedBox(width: 20),
                _buildButton(context, 'Test', Colors.greenAccent, 'test'),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
        textStyle: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 8,
        shadowColor: Colors.black45,
      ),
      child: Text(text),
    );
  }
}