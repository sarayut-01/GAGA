import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ggh/constant/constant.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  Future<void> loginUser() async {
    final String email = _email.text;
    final String password = _password.text;

    try {
      setState(() {
        _isLoading = true;
      });

      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login Successful!')));
        Navigator.pushNamed(context, 'dashboard'); // ไปยังหน้าหลัก
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed: ${e.message}';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
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
        title: const Text(
          'Login',
          style: TextStyle(fontSize: pFont, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // พื้นหลังเป็นรูปภาพ
          Positioned.fill(
            child: Image.asset("assets/image/meaom.jpg", fit: BoxFit.cover),
          ),

          // ทำให้พื้นหลังมืดลง
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // ปรับความเข้มของพื้นหลัง
            ),
          ),

          // ฟอร์มล็อกอิน
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 8, // Adding shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                color: Colors.blueGrey.withOpacity(0.3), // Set the opacity here
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            fillColor: Color.fromARGB(255, 144, 144, 145),
                            filled: true,
                            prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 255, 254, 254)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 10.0,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _password,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            fillColor:Color.fromARGB(255, 167, 171, 169),
                            filled: true,
                            prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 251, 251, 251)),
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 10.0,
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                          onPressed: _isLoading ? null : loginUser,
                          child:
                              _isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text('Login',style: TextStyle(color: Colors.black,),
                        ),),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'register');
                          },
                          child: const Text(
                            'Don\'t have an account? Register here',
                            style: TextStyle(
                              fontSize: 16, // Increased font size
                              color: Color.fromARGB(255, 14, 14, 15), // Set the color to blue
                              fontWeight: FontWeight.bold, // Bold text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
