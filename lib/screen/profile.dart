import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? email; // เก็บอีเมลของผู้ใช้
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    getUserEmail(); // ดึงข้อมูลอีเมลของผู้ใช้ที่ล็อกอิน
  }

  // ดึงอีเมลของผู้ใช้จาก Firebase
  Future<void> getUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          email = user.email;
        });
      } else {
        print('No user is logged in');
      }
    } catch (error) {
      print('Error getting user email: $error');
    }
  }

  // ฟังก์ชัน Log Out
  Future<void> signOutUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        email = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out successfully')),
      );
      Navigator.pushReplacementNamed(context, 'home'); // กลับไปหน้า Login
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to log out: $error')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Profile',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // รูปพื้นหลัง
          Positioned.fill(
            child: Image.asset(
              'assets/image/10.jpg',
              fit: BoxFit.cover, // ทำให้รูปเต็มจอ
            ),
          ),

          // แสดงข้อมูลโปรไฟล์
          email == null
              ? const Center(child: CircularProgressIndicator()) // โหลดข้อมูล
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: const AssetImage('assets/image/fa.png'), // รูปโปรไฟล์
                        ),
                        const SizedBox(height: 16),

                        // กล่องข้อความโปร่งแสงแสดงอีเมล
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8), // โปร่งแสง
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Email: $email',
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: _isLoading ? null : signOutUser,
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Log Out'),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
