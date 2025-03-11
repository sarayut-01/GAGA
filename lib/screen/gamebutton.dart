import 'package:flutter/material.dart';

class Gamebutton extends StatefulWidget {
  const Gamebutton({super.key});

  @override
  State<Gamebutton> createState() => _GamebuttonState();
}

class _GamebuttonState extends State<Gamebutton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset("assets/image/aom9.jpg", fit: BoxFit.cover),
          ),
          // Your main content
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // การย้อนกลับ
              },
            ),
          ),
          Center(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'เกมฝึกสมาธิ',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blueAccent,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, 'GAME');
                      },
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          color: Color.fromARGB(255, 247, 247, 247),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
