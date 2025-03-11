import 'package:flutter/material.dart';
import 'package:ggh/screen/DailySummaryPage.dart';
import 'package:ggh/screen/MonthlySummaryPage.dart';
import 'package:ggh/screen/WeeklySummaryPage.dart';


class SummarySelectionPage extends StatelessWidget {
  const SummarySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Summary',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.home, size: 28),
          onPressed: () {
            Navigator.pushNamed(context, 'dashboard');
          },
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,  // Ensure the container takes up the full width
        height: double.infinity, // Ensure the container takes up the full height
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/000.png'), // Replace with your image path
            fit: BoxFit.cover, // Ensures the image fills the screen
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSummaryButton(context, 'Daily Summary', Colors.orange, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DailySummaryPage()),
                  );
                }),
                const SizedBox(height: 20),
                _buildSummaryButton(context, 'Weekly Summary', Colors.green, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeeklySummaryPage()),
                  );
                }),
                const SizedBox(height: 20),
                _buildSummaryButton(context, 'Monthly Summary', Colors.purple, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MonthlySummaryPage()),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryButton(
      BuildContext context, String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
