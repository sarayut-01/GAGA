import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User? _user;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      _user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_user?.displayName ?? "Guest", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              accountEmail: Text(_user?.email ?? "No Email", style: TextStyle(color: Colors.white)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlue],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildDrawerItem(Icons.add, 'Add Transaction', 'AddTransactionPage'),
                  _buildDrawerItem(Icons.api, 'API', 'API'),
                  _buildDrawerItem(Icons.videogame_asset, 'Game', 'GAMEBUTTON'),
                  _buildDrawerItem(Icons.summarize, 'Summary', 'SummarySelectionPage'),
                  _buildDrawerItem(Icons.account_circle, 'Profile', 'profile'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset("assets/image/aom8.jpg", fit: BoxFit.cover),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.4)),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                  ),
                  _user == null
                      ? const CircularProgressIndicator()
                      : Text(
                          _user!.email ?? 'No Email',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                  IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, 'profile');
                    },
                  ),
                ],
              ),
            ),
          ),
          // ปุ่มใหม่ที่จัดตำแหน่งใหม่
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNewStyledButton('Go to Profile', Colors.blueAccent, 'profile'),
                  SizedBox(height: 20),
                  _buildNewStyledButton('สรุปผล', Colors.greenAccent, 'SummarySelectionPage'),
                  SizedBox(height: 20),
                  _buildNewStyledButton('Add Transaction', Colors.purpleAccent, 'AddTransactionPage'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildNewStyledButton(String text, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 18.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50.0), // ทำขอบมนให้ดูทันสมัย
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              blurRadius: 12.0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 1.2, // เพิ่มช่องว่างระหว่างตัวอักษร
          ),
        ),
      ),
    );
  }
}
