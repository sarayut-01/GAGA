import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> blinkSequence = [];
  List<int> playerSequence = [];
  int currentLevel = 1;
  bool isPlayerTurn = false;
  int currentBlinkIndex = -1;
  final Random random = Random();

  void startNewLevel() {
    playerSequence.clear();
    blinkSequence.clear();
    for (int i = 0; i < currentLevel; i++) {
      int newBlink;
      do {
        newBlink = random.nextInt(9);
      } while (blinkSequence.contains(newBlink));
      blinkSequence.add(newBlink);
    }
    setState(() {
      isPlayerTurn = false;
      currentBlinkIndex = 0;
    });
    playBlinkSequence();
  }

  void playBlinkSequence() {
    Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (currentBlinkIndex >= blinkSequence.length) {
        timer.cancel();
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isPlayerTurn = true;
            currentBlinkIndex = -1;
          });
        });
      } else {
        setState(() {
          currentBlinkIndex++;
        });
      }
    });
  }

  void handlePlayerTap(int index) {
    if (!isPlayerTurn) return;
    setState(() {
      playerSequence.add(index);
    });

    if (playerSequence[playerSequence.length - 1] !=
        blinkSequence[playerSequence.length - 1]) {
      setState(() {
        currentLevel = 1;
      });
      Future.delayed(const Duration(seconds: 1), startNewLevel);
    } else if (playerSequence.length == blinkSequence.length) {
      setState(() {
        currentLevel++;
      });
      Future.delayed(const Duration(seconds: 1), startNewLevel);
    }
  }

  @override
  void initState() {
    super.initState();
    startNewLevel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Level $currentLevel"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                bool shouldBlink =
                    currentBlinkIndex >= 0 &&
                    currentBlinkIndex < blinkSequence.length &&
                    index == blinkSequence[currentBlinkIndex];
                bool isSelected = playerSequence.contains(index);
                return GestureDetector(
                  onTap: () => handlePlayerTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color:
                          shouldBlink
                              ? Colors.blueAccent
                              : isSelected
                              ? Colors.green
                              : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow:
                          shouldBlink || isSelected
                              ? [
                                BoxShadow(color: Colors.black26, blurRadius: 5),
                              ]
                              : [],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              isPlayerTurn ? "ตาผู้เล่น" : "Watch Closely...",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}