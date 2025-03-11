import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // นำเข้า firebase_core

// import 'package:weektwo/screen/update.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ggh/constant/constant.dart';
import 'package:ggh/firebase_options.dart';
import 'package:ggh/screen/Fill_in_information.dart';
import 'package:ggh/screen/SummarySelectionPage.dart';
import 'package:ggh/screen/api.dart';
import 'package:ggh/screen/dashboard.dart';
import 'package:ggh/screen/game.dart';
import 'package:ggh/screen/gamebutton.dart';
import 'package:ggh/screen/home.dart';
import 'package:ggh/screen/login.dart';
import 'package:ggh/screen/profile.dart';
import 'package:ggh/screen/register.dart'; // นำเข้า cloud_firestore สำหรับ Firestore

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // ให้แน่ใจว่า Firebase ถูก initialize ก่อน
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // ใช้การตั้งค่าจาก firebase_options.dart
  );

  runApp(Myapp()); // เรียกใช้แอปหลังจากที่ Firebase ถูก initialize
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        primaryColor: pColor,
        secondaryHeaderColor: sColor,
      ),
      routes: {
        // 'async': (context) => APIAsync(),
        // 'dogapi': (context) => dogapi(),
        'home': (context) => Home(),
        'dashboard': (context) => Dashboard(),
        // 'registor': (context) => Register(),
        'profile': (context) => Profile(),
         'login': (context) => Login(),
        'register'  :(context) => register(),
        // 'create': (context) => CreateUser(),
        // 'update': (context) => UpdateUser(userId: '2'),
        'AddTransactionPage': (context) => AddTransactionPage(),
        'SummarySelectionPage': (context) => SummarySelectionPage(),
        'API' : (context) => Api(),
        'GAMEBUTTON' : (context) => Gamebutton(),
        'test' : (context) => Dashboard(),
        'GAME' : (context) => GameScreen(),
      },
    );
  }
}

class Register {
}

// ฟังก์ชันสำหรับเพิ่มข้อมูลธุรกรรมลงใน Firestore
Future<void> addTransaction(String type, double amount, String note) async {
  // เพิ่มเอกสารใหม่ไปยัง collection 'transactions'
  await FirebaseFirestore.instance.collection('transactions').add({
    'type': type, // ประเภท: รายรับ ('income') หรือรายจ่าย ('expense')
    'amount': amount, // จำนวนเงิน
    'note': note, // หมายเหตุ
    'timestamp': FieldValue.serverTimestamp(), // เวลาที่บันทึก
  });
}

// ฟังก์ชันสำหรับดึงข้อมูลธุรกรรมทั้งหมดจาก Firestore
Stream<QuerySnapshot> getTransactions() {
  return FirebaseFirestore.instance.collection('transactions').snapshots();
}

// ฟังก์ชันสำหรับลบข้อมูลธุรกรรมจาก Firestore โดยใช้ document ID
Future<void> deleteTransaction(String docId) async {
  await FirebaseFirestore.instance
      .collection('transactions')
      .doc(docId)
      .delete();
}

// ฟังก์ชันสำหรับอัปเดตข้อมูลธุรกรรมใน Firestore
Future<void> updateTransaction(
    String docId, Map<String, dynamic> newData) async {
  await FirebaseFirestore.instance
      .collection('transactions')
      .doc(docId)
      .update(newData);
}
