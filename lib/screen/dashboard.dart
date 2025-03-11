import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  // ฟังก์ชันดึงข้อมูลผู้ใช้จาก Firebase
  Future<void> _getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Dashboard"
        ,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          // แสดงอีเมลของผู้ใช้ในมุมขวาบน
          _user == null
              ? const CircularProgressIndicator() // แสดงการโหลดหากยังไม่ได้ดึงข้อมูลผู้ใช้
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _user!.email ?? 'No Email', // แสดงอีเมลผู้ใช้หากมี
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, 'profile');
            },
          ),
        ],
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 100, 184, 253),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('AddTransactionPage'),
              onTap: () {
                Navigator.pushNamed(context, 'AddTransactionPage');
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text('Home'),
            //   onTap: () {
            //     Navigator.pushNamed(context, 'dashboard');
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.summarize),
              title: const Text('สรุปผล'),
              onTap: () {
                Navigator.pushNamed(context, 'SummarySelectionPage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, 'profile');
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // พื้นหลังเป็นรูปภาพ
          Positioned.fill(
            child: SizedBox(
              width: 10,
              height: 20,
              child: Image.asset(
                "assets/image/111.png",
              ),
            ),
          ),

          // ทำให้พื้นหลังมืดลง เพื่อให้ตัวอักษรอ่านง่ายขึ้น
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // ปรับความเข้มของพื้นหลัง
            ),
          ),

          // เนื้อหาหลัก
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 5000,
                  height: 200,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'profile');
                  },
                  child: const Text('Go to Profile'),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                  width: 500,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'SummarySelectionPage');
                  },
                  child: const Text('สรุปผล'),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'AddTransactionPage');
                  },
                  child: const Text('AddTransactionPage'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
